import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:gql/ast.dart';
import 'package:gql/language.dart';

void main() {
  group('Duniter Datapod GraphQL Schema Validation Tests', () {
    late DocumentNode schemaDoc;
    late DocumentNode queriesDoc;
    late DocumentNode mutationsDoc;
    late Map<String, TypeDefinitionNode> schemaTypes;

    setUpAll(() async {
      // Load and parse the schema file
      final schemaFile =
          File('lib/graphql/schema/duniter-datapod.schema.graphql');
      final schemaContent = await schemaFile.readAsString();
      schemaDoc = parseString(schemaContent);

      // Load and parse the queries file
      final queriesFile =
          File('lib/graphql/schema/duniter-datapod-queries.graphql');
      final queriesContent = await queriesFile.readAsString();
      queriesDoc = parseString(queriesContent);

      // Load and parse the mutations file
      final mutationsFile =
          File('lib/graphql/schema/duniter-datapod-mutations.graphql');
      final mutationsContent = await mutationsFile.readAsString();
      mutationsDoc = parseString(mutationsContent);

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

    test('All queries from file should be syntactically valid', () {
      expect(queriesDoc, isNotNull);
      expect(queriesDoc.definitions, isNotEmpty);

      // Verify all definitions are operation definitions
      for (final def in queriesDoc.definitions) {
        expect(def is OperationDefinitionNode, isTrue,
            reason: 'All definitions in queries file should be operations');
      }
    });

    test('All mutations from file should be syntactically valid', () {
      expect(mutationsDoc, isNotNull);
      expect(mutationsDoc.definitions, isNotEmpty);

      // Verify all definitions are operation definitions
      for (final def in mutationsDoc.definitions) {
        expect(def is OperationDefinitionNode, isTrue,
            reason: 'All definitions in mutations file should be operations');
      }
    });

    test('All queries should have valid operation names and types', () {
      final operations =
          queriesDoc.definitions.whereType<OperationDefinitionNode>().toList();

      expect(operations, isNotEmpty);

      for (final op in operations) {
        expect(op.name, isNotNull, reason: 'All queries should have a name');
        expect(op.type, equals(OperationType.query),
            reason: 'All operations in queries file should be queries');
      }
    });

    test('All mutations should have valid operation names and types', () {
      final operations = mutationsDoc.definitions
          .whereType<OperationDefinitionNode>()
          .toList();

      expect(operations, isNotEmpty);

      for (final op in operations) {
        expect(op.name, isNotNull, reason: 'All mutations should have a name');
        expect(op.type, equals(OperationType.mutation),
            reason: 'All operations in mutations file should be mutations');
      }
    });

    test('All query fields should reference valid schema root fields', () {
      final operations =
          queriesDoc.definitions.whereType<OperationDefinitionNode>().toList();

      for (final op in operations) {
        final queryName = op.name?.value ?? 'unnamed';
        expect(op.selectionSet, isNotNull,
            reason: 'Query $queryName should have selections');

        // Validate that root fields exist in schema
        for (final selection in op.selectionSet.selections) {
          if (selection is FieldNode) {
            final fieldName = selection.name.value;
            // These are the main query root fields in Hasura
            final validRootFields = ['profiles', 'profiles_aggregate'];
            expect(validRootFields.contains(fieldName), isTrue,
                reason:
                    'Query $queryName uses field "$fieldName" which should be a valid root query field. '
                    'If this fails, the schema may have changed.');
          }
        }
      }
    });

    test('All mutation fields should reference valid schema mutation fields',
        () {
      final operations = mutationsDoc.definitions
          .whereType<OperationDefinitionNode>()
          .toList();

      // Get mutation fields from schema
      final mutationRoot = schemaTypes['mutation_root'];
      expect(mutationRoot, isNotNull,
          reason: 'Schema should define mutation_root type');

      Set<String> validMutationFields = {};
      if (mutationRoot is ObjectTypeDefinitionNode) {
        validMutationFields =
            mutationRoot.fields.map((f) => f.name.value).toSet();
      }

      for (final op in operations) {
        final mutationName = op.name?.value ?? 'unnamed';
        expect(op.selectionSet, isNotNull,
            reason: 'Mutation $mutationName should have selections');

        // Validate that mutation fields exist in schema
        for (final selection in op.selectionSet.selections) {
          if (selection is FieldNode) {
            final fieldName = selection.name.value;
            expect(validMutationFields.contains(fieldName), isTrue,
                reason:
                    'Mutation $mutationName uses field "$fieldName" which should exist in mutation_root schema. '
                    'Available mutations: ${validMutationFields.join(", ")}. '
                    'If this fails, the schema may have changed or the mutation is no longer available.');
          }
        }
      }
    });

    test('All queries have expected structure and can be parsed', () {
      final expectedQueries = [
        'GetProfileByAddress',
        'GetProfilesByAddress',
        'GetProfileCount',
        'SearchProfileByTerm',
        'SearchProfiles',
      ];

      final operations =
          queriesDoc.definitions.whereType<OperationDefinitionNode>().toList();

      final queryNames = operations.map((op) => op.name?.value).toList();

      for (final expectedQuery in expectedQueries) {
        expect(queryNames.contains(expectedQuery), isTrue,
            reason:
                'Expected query "$expectedQuery" should exist in queries file');
      }
    });

    test('All mutations have expected structure and can be parsed', () {
      final expectedMutations = [
        'DeleteProfile',
        'MigrateProfile',
        'UpdateProfile',
      ];

      final operations = mutationsDoc.definitions
          .whereType<OperationDefinitionNode>()
          .toList();

      final mutationNames = operations.map((op) => op.name?.value).toList();

      for (final expectedMutation in expectedMutations) {
        expect(mutationNames.contains(expectedMutation), isTrue,
            reason:
                'Expected mutation "$expectedMutation" should exist in mutations file');
      }
    });

    test('Schema defines required mutation fields used by our mutations', () {
      expect(schemaTypes.containsKey('mutation_root'), isTrue,
          reason: 'Schema should define mutation_root type');

      final mutationRoot = schemaTypes['mutation_root'];
      expect(mutationRoot, isNotNull);

      if (mutationRoot is ObjectTypeDefinitionNode) {
        final mutationFields =
            mutationRoot.fields.map((f) => f.name.value).toList();

        // Verify our mutations exist in schema
        expect(mutationFields.contains('deleteProfile'), isTrue,
            reason: 'Schema should define deleteProfile mutation');
        expect(mutationFields.contains('migrateProfile'), isTrue,
            reason: 'Schema should define migrateProfile mutation');
        expect(mutationFields.contains('updateProfile'), isTrue,
            reason: 'Schema should define updateProfile mutation');
      }
    });

    test('Schema defines required query root type', () {
      expect(schemaTypes.containsKey('query_root'), isTrue,
          reason: 'Schema should define query_root type');

      final queryRoot = schemaTypes['query_root'];
      if (queryRoot is ObjectTypeDefinitionNode) {
        final queryFields = queryRoot.fields.map((f) => f.name.value).toList();

        // Verify key query fields exist
        expect(queryFields.contains('profiles'), isTrue,
            reason: 'Schema should define profiles query field');
        expect(queryFields.contains('profiles_aggregate'), isTrue,
            reason: 'Schema should define profiles_aggregate query field');
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

    test('No duplicate operation names in mutations', () {
      final operations = mutationsDoc.definitions
          .whereType<OperationDefinitionNode>()
          .toList();

      final names = operations.map((op) => op.name?.value).toList();
      final uniqueNames = names.toSet();

      expect(names.length, equals(uniqueNames.length),
          reason: 'All mutation names should be unique');
    });

    test('Schema contains expected response types', () {
      expect(schemaTypes.containsKey('DeleteProfileResponse'), isTrue,
          reason: 'Schema should define DeleteProfileResponse type');
      expect(schemaTypes.containsKey('MigrateProfileResponse'), isTrue,
          reason: 'Schema should define MigrateProfileResponse type');
      expect(schemaTypes.containsKey('UpdateProfileResponse'), isTrue,
          reason: 'Schema should define UpdateProfileResponse type');
    });
  });
}
