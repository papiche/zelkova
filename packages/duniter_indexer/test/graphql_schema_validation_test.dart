import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:gql/ast.dart';
import 'package:gql/language.dart';

void main() {
  group('Duniter Indexer GraphQL Schema Validation Tests', () {
    late DocumentNode schemaDoc;
    late DocumentNode queriesDoc;
    late Map<String, TypeDefinitionNode> schemaTypes;

    setUpAll(() async {
      // Load and parse the schema file
      final schemaFile =
          File('lib/graphql/schema/duniter-indexer.schema.graphql');
      final schemaContent = await schemaFile.readAsString();
      schemaDoc = parseString(schemaContent);

      // Load and parse the queries file
      final queriesFile =
          File('lib/graphql/schema/duniter-indexer-queries.graphql');
      final queriesContent = await queriesFile.readAsString();
      queriesDoc = parseString(queriesContent);

      // Build a map of types from schema for validation
      schemaTypes = {};
      for (final def in schemaDoc.definitions) {
        if (def is TypeDefinitionNode) {
          schemaTypes[def.name.value] = def;
        }
      }
    });

    test('Schema file should be syntactically valid', () {
      expect(schemaDoc, isNotNull);
      expect(schemaDoc.definitions, isNotEmpty);
      expect(schemaTypes, isNotEmpty);
    });

    test('All queries and fragments from file should be syntactically valid',
        () {
      expect(queriesDoc, isNotNull);
      expect(queriesDoc.definitions, isNotEmpty);

      // Verify all definitions are either operations or fragments
      for (final def in queriesDoc.definitions) {
        expect(def is OperationDefinitionNode || def is FragmentDefinitionNode,
            isTrue,
            reason:
                'All definitions in queries file should be operations or fragments');
      }
    });

    test('All queries should have valid operation names and types', () {
      final operations =
          queriesDoc.definitions.whereType<OperationDefinitionNode>().toList();

      expect(operations, isNotEmpty, reason: 'Should have at least one query');

      for (final op in operations) {
        expect(op.name, isNotNull, reason: 'All queries should have a name');
        expect(op.type, equals(OperationType.query),
            reason: 'All operations in queries file should be queries');
      }
    });

    test('All fragments should have valid names and type conditions', () {
      final fragments =
          queriesDoc.definitions.whereType<FragmentDefinitionNode>().toList();

      expect(fragments, isNotEmpty,
          reason: 'Should have at least one fragment');

      for (final fragment in fragments) {
        expect(fragment.name, isNotNull,
            reason: 'All fragments should have a name');
        expect(fragment.typeCondition, isNotNull,
            reason: 'All fragments should have a type condition');

        final typeName = fragment.typeCondition.on.name.value;
        // Verify the type exists in schema
        expect(schemaTypes.containsKey(typeName), isTrue,
            reason:
                'Fragment ${fragment.name.value} references type "$typeName" which should exist in schema. '
                'If this fails, the schema may have changed.');
      }
    });

    test('All query root fields should reference valid schema types', () {
      final operations =
          queriesDoc.definitions.whereType<OperationDefinitionNode>().toList();

      // Get Query type from schema
      final queryType = schemaTypes['Query'];
      expect(queryType, isNotNull, reason: 'Schema should define Query type');

      Set<String> validQueryFields = {};
      if (queryType is ObjectTypeDefinitionNode) {
        validQueryFields = queryType.fields.map((f) => f.name.value).toSet();
      }

      for (final op in operations) {
        final queryName = op.name?.value ?? 'unnamed';
        expect(op.selectionSet, isNotNull,
            reason: 'Query $queryName should have selections');

        // Validate that root fields exist in schema Query type
        for (final selection in op.selectionSet.selections) {
          if (selection is FieldNode) {
            final fieldName = selection.name.value;
            expect(validQueryFields.contains(fieldName), isTrue,
                reason:
                    'Query $queryName uses field "$fieldName" which should exist in Query schema type. '
                    'Available fields: ${validQueryFields.take(10).join(", ")}... '
                    'If this fails, the schema may have changed.');
          }
        }
      }
    });

    test('All expected queries exist and can be parsed', () {
      final expectedQueries = [
        'LastBlock',
        'IdentitiesByNameOrPk',
        'IdentitiesByPk',
        'IdentitiesByName',
        'AccountByPk',
        'AccountsByPk',
        'AccountBasicByPk',
        'AccountsBasicByPk',
        'AccountTransactions',
      ];

      final operations =
          queriesDoc.definitions.whereType<OperationDefinitionNode>().toList();

      final queryNames = operations.map((op) => op.name?.value).toSet();

      for (final expectedQuery in expectedQueries) {
        expect(queryNames.contains(expectedQuery), isTrue,
            reason:
                'Expected query "$expectedQuery" should exist in queries file');
      }
    });

    test('All expected fragments exist and can be parsed', () {
      final expectedFragments = [
        'IdentityBasicFields',
        'IdentityFields',
        'CommentsIssued',
        'AccountBasicFields',
        'AccountFields',
        'AccountTxsFields',
        'TransferFields',
      ];

      final fragments =
          queriesDoc.definitions.whereType<FragmentDefinitionNode>().toList();

      final fragmentNames = fragments.map((f) => f.name.value).toSet();

      for (final expectedFragment in expectedFragments) {
        expect(fragmentNames.contains(expectedFragment), isTrue,
            reason:
                'Expected fragment "$expectedFragment" should exist in queries file');
      }
    });

    test('Schema defines required types used by queries', () {
      final requiredTypes = [
        'Account',
        'Identity',
        'Cert',
        'Transfer',
        'Block',
        'Query',
      ];

      for (final typeName in requiredTypes) {
        expect(schemaTypes.containsKey(typeName), isTrue,
            reason: 'Schema should define $typeName type');
      }
    });

    test('No duplicate operation names in queries', () {
      final operations =
          queriesDoc.definitions.whereType<OperationDefinitionNode>().toList();

      final names = operations.map((op) => op.name?.value).toList();
      final uniqueNames = names.toSet();

      expect(names.length, equals(uniqueNames.length),
          reason: 'All query names should be unique');
    });

    test('No duplicate fragment names', () {
      final fragments =
          queriesDoc.definitions.whereType<FragmentDefinitionNode>().toList();

      final names = fragments.map((f) => f.name.value).toList();
      final uniqueNames = names.toSet();

      expect(names.length, equals(uniqueNames.length),
          reason: 'All fragment names should be unique');
    });

    test('All fragment type conditions reference existing schema types', () {
      final fragments =
          queriesDoc.definitions.whereType<FragmentDefinitionNode>().toList();

      for (final fragment in fragments) {
        final typeName = fragment.typeCondition.on.name.value;
        expect(schemaTypes.containsKey(typeName), isTrue,
            reason:
                'Fragment "${fragment.name.value}" uses type condition "$typeName" which should exist in schema');
      }
    });

    test('Schema Query type contains expected root fields', () {
      final queryType = schemaTypes['Query'];
      expect(queryType, isNotNull, reason: 'Schema should define Query type');

      if (queryType is ObjectTypeDefinitionNode) {
        final fieldNames = queryType.fields.map((f) => f.name.value).toSet();

        // Check for commonly used root fields
        expect(fieldNames.contains('accounts'), isTrue,
            reason: 'Query type should have accounts field');
        expect(fieldNames.contains('identities'), isTrue,
            reason: 'Query type should have identities field');
        expect(fieldNames.contains('blocks'), isTrue,
            reason: 'Query type should have blocks field');
      }
    });
  });
}
