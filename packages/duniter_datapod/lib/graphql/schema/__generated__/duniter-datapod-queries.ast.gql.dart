// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:gql/ast.dart' as _i1;

const GetProfileByAddress = _i1.OperationDefinitionNode(
  type: _i1.OperationType.query,
  name: _i1.NameNode(value: 'GetProfileByAddress'),
  variableDefinitions: [
    _i1.VariableDefinitionNode(
      variable: _i1.VariableNode(name: _i1.NameNode(value: 'pubkey')),
      type: _i1.NamedTypeNode(
        name: _i1.NameNode(value: 'String'),
        isNonNull: true,
      ),
      defaultValue: _i1.DefaultValueNode(value: null),
      directives: [],
    )
  ],
  directives: [],
  selectionSet: _i1.SelectionSetNode(selections: [
    _i1.FieldNode(
      name: _i1.NameNode(value: 'profiles'),
      alias: null,
      arguments: [
        _i1.ArgumentNode(
          name: _i1.NameNode(value: 'where'),
          value: _i1.ObjectValueNode(fields: [
            _i1.ObjectFieldNode(
              name: _i1.NameNode(value: 'pubkey'),
              value: _i1.ObjectValueNode(fields: [
                _i1.ObjectFieldNode(
                  name: _i1.NameNode(value: '_eq'),
                  value: _i1.VariableNode(name: _i1.NameNode(value: 'pubkey')),
                )
              ]),
            )
          ]),
        )
      ],
      directives: [],
      selectionSet: _i1.SelectionSetNode(selections: [
        _i1.FieldNode(
          name: _i1.NameNode(value: 'avatar'),
          alias: null,
          arguments: [],
          directives: [],
          selectionSet: null,
        ),
        _i1.FieldNode(
          name: _i1.NameNode(value: 'pubkey'),
          alias: null,
          arguments: [],
          directives: [],
          selectionSet: null,
        ),
        _i1.FieldNode(
          name: _i1.NameNode(value: 'description'),
          alias: null,
          arguments: [],
          directives: [],
          selectionSet: null,
        ),
        _i1.FieldNode(
          name: _i1.NameNode(value: 'title'),
          alias: null,
          arguments: [],
          directives: [],
          selectionSet: null,
        ),
        _i1.FieldNode(
          name: _i1.NameNode(value: 'city'),
          alias: null,
          arguments: [],
          directives: [],
          selectionSet: null,
        ),
        _i1.FieldNode(
          name: _i1.NameNode(value: 'data_cid'),
          alias: null,
          arguments: [],
          directives: [],
          selectionSet: null,
        ),
        _i1.FieldNode(
          name: _i1.NameNode(value: 'geoloc'),
          alias: null,
          arguments: [],
          directives: [],
          selectionSet: null,
        ),
        _i1.FieldNode(
          name: _i1.NameNode(value: 'index_request_cid'),
          alias: null,
          arguments: [],
          directives: [],
          selectionSet: null,
        ),
        _i1.FieldNode(
          name: _i1.NameNode(value: 'pubkey'),
          alias: null,
          arguments: [],
          directives: [],
          selectionSet: null,
        ),
        _i1.FieldNode(
          name: _i1.NameNode(value: 'socials'),
          alias: null,
          arguments: [],
          directives: [],
          selectionSet: null,
        ),
        _i1.FieldNode(
          name: _i1.NameNode(value: 'time'),
          alias: null,
          arguments: [],
          directives: [],
          selectionSet: null,
        ),
        _i1.FieldNode(
          name: _i1.NameNode(value: 'title'),
          alias: null,
          arguments: [],
          directives: [],
          selectionSet: null,
        ),
      ]),
    )
  ]),
);
const GetProfilesByAddress = _i1.OperationDefinitionNode(
  type: _i1.OperationType.query,
  name: _i1.NameNode(value: 'GetProfilesByAddress'),
  variableDefinitions: [
    _i1.VariableDefinitionNode(
      variable: _i1.VariableNode(name: _i1.NameNode(value: 'pubkeys')),
      type: _i1.ListTypeNode(
        type: _i1.NamedTypeNode(
          name: _i1.NameNode(value: 'String'),
          isNonNull: true,
        ),
        isNonNull: true,
      ),
      defaultValue: _i1.DefaultValueNode(value: null),
      directives: [],
    )
  ],
  directives: [],
  selectionSet: _i1.SelectionSetNode(selections: [
    _i1.FieldNode(
      name: _i1.NameNode(value: 'profiles'),
      alias: null,
      arguments: [
        _i1.ArgumentNode(
          name: _i1.NameNode(value: 'where'),
          value: _i1.ObjectValueNode(fields: [
            _i1.ObjectFieldNode(
              name: _i1.NameNode(value: 'pubkey'),
              value: _i1.ObjectValueNode(fields: [
                _i1.ObjectFieldNode(
                  name: _i1.NameNode(value: '_in'),
                  value: _i1.VariableNode(name: _i1.NameNode(value: 'pubkeys')),
                )
              ]),
            )
          ]),
        )
      ],
      directives: [],
      selectionSet: _i1.SelectionSetNode(selections: [
        _i1.FieldNode(
          name: _i1.NameNode(value: 'avatar'),
          alias: null,
          arguments: [],
          directives: [],
          selectionSet: null,
        ),
        _i1.FieldNode(
          name: _i1.NameNode(value: 'pubkey'),
          alias: null,
          arguments: [],
          directives: [],
          selectionSet: null,
        ),
        _i1.FieldNode(
          name: _i1.NameNode(value: 'description'),
          alias: null,
          arguments: [],
          directives: [],
          selectionSet: null,
        ),
        _i1.FieldNode(
          name: _i1.NameNode(value: 'title'),
          alias: null,
          arguments: [],
          directives: [],
          selectionSet: null,
        ),
        _i1.FieldNode(
          name: _i1.NameNode(value: 'city'),
          alias: null,
          arguments: [],
          directives: [],
          selectionSet: null,
        ),
        _i1.FieldNode(
          name: _i1.NameNode(value: 'data_cid'),
          alias: null,
          arguments: [],
          directives: [],
          selectionSet: null,
        ),
        _i1.FieldNode(
          name: _i1.NameNode(value: 'geoloc'),
          alias: null,
          arguments: [],
          directives: [],
          selectionSet: null,
        ),
        _i1.FieldNode(
          name: _i1.NameNode(value: 'index_request_cid'),
          alias: null,
          arguments: [],
          directives: [],
          selectionSet: null,
        ),
        _i1.FieldNode(
          name: _i1.NameNode(value: 'pubkey'),
          alias: null,
          arguments: [],
          directives: [],
          selectionSet: null,
        ),
        _i1.FieldNode(
          name: _i1.NameNode(value: 'socials'),
          alias: null,
          arguments: [],
          directives: [],
          selectionSet: null,
        ),
        _i1.FieldNode(
          name: _i1.NameNode(value: 'time'),
          alias: null,
          arguments: [],
          directives: [],
          selectionSet: null,
        ),
        _i1.FieldNode(
          name: _i1.NameNode(value: 'title'),
          alias: null,
          arguments: [],
          directives: [],
          selectionSet: null,
        ),
      ]),
    )
  ]),
);
const GetProfileCount = _i1.OperationDefinitionNode(
  type: _i1.OperationType.query,
  name: _i1.NameNode(value: 'GetProfileCount'),
  variableDefinitions: [],
  directives: [],
  selectionSet: _i1.SelectionSetNode(selections: [
    _i1.FieldNode(
      name: _i1.NameNode(value: 'profiles_aggregate'),
      alias: null,
      arguments: [],
      directives: [],
      selectionSet: _i1.SelectionSetNode(selections: [
        _i1.FieldNode(
          name: _i1.NameNode(value: 'aggregate'),
          alias: null,
          arguments: [],
          directives: [],
          selectionSet: _i1.SelectionSetNode(selections: [
            _i1.FieldNode(
              name: _i1.NameNode(value: 'count'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: null,
            )
          ]),
        )
      ]),
    )
  ]),
);
const SearchProfileByTerm = _i1.OperationDefinitionNode(
  type: _i1.OperationType.query,
  name: _i1.NameNode(value: 'SearchProfileByTerm'),
  variableDefinitions: [
    _i1.VariableDefinitionNode(
      variable: _i1.VariableNode(name: _i1.NameNode(value: 'pattern')),
      type: _i1.NamedTypeNode(
        name: _i1.NameNode(value: 'String'),
        isNonNull: true,
      ),
      defaultValue: _i1.DefaultValueNode(value: null),
      directives: [],
    )
  ],
  directives: [],
  selectionSet: _i1.SelectionSetNode(selections: [
    _i1.FieldNode(
      name: _i1.NameNode(value: 'profiles'),
      alias: null,
      arguments: [
        _i1.ArgumentNode(
          name: _i1.NameNode(value: 'where'),
          value: _i1.ObjectValueNode(fields: [
            _i1.ObjectFieldNode(
              name: _i1.NameNode(value: '_or'),
              value: _i1.ListValueNode(values: [
                _i1.ObjectValueNode(fields: [
                  _i1.ObjectFieldNode(
                    name: _i1.NameNode(value: 'title'),
                    value: _i1.ObjectValueNode(fields: [
                      _i1.ObjectFieldNode(
                        name: _i1.NameNode(value: '_iregex'),
                        value: _i1.VariableNode(
                            name: _i1.NameNode(value: 'pattern')),
                      )
                    ]),
                  )
                ]),
                _i1.ObjectValueNode(fields: [
                  _i1.ObjectFieldNode(
                    name: _i1.NameNode(value: 'description'),
                    value: _i1.ObjectValueNode(fields: [
                      _i1.ObjectFieldNode(
                        name: _i1.NameNode(value: '_iregex'),
                        value: _i1.VariableNode(
                            name: _i1.NameNode(value: 'pattern')),
                      )
                    ]),
                  )
                ]),
                _i1.ObjectValueNode(fields: [
                  _i1.ObjectFieldNode(
                    name: _i1.NameNode(value: 'pubkey'),
                    value: _i1.ObjectValueNode(fields: [
                      _i1.ObjectFieldNode(
                        name: _i1.NameNode(value: '_iregex'),
                        value: _i1.VariableNode(
                            name: _i1.NameNode(value: 'pattern')),
                      )
                    ]),
                  )
                ]),
              ]),
            )
          ]),
        )
      ],
      directives: [],
      selectionSet: _i1.SelectionSetNode(selections: [
        _i1.FieldNode(
          name: _i1.NameNode(value: 'avatar'),
          alias: null,
          arguments: [],
          directives: [],
          selectionSet: null,
        ),
        _i1.FieldNode(
          name: _i1.NameNode(value: 'pubkey'),
          alias: null,
          arguments: [],
          directives: [],
          selectionSet: null,
        ),
        _i1.FieldNode(
          name: _i1.NameNode(value: 'description'),
          alias: null,
          arguments: [],
          directives: [],
          selectionSet: null,
        ),
        _i1.FieldNode(
          name: _i1.NameNode(value: 'title'),
          alias: null,
          arguments: [],
          directives: [],
          selectionSet: null,
        ),
        _i1.FieldNode(
          name: _i1.NameNode(value: 'city'),
          alias: null,
          arguments: [],
          directives: [],
          selectionSet: null,
        ),
        _i1.FieldNode(
          name: _i1.NameNode(value: 'data_cid'),
          alias: null,
          arguments: [],
          directives: [],
          selectionSet: null,
        ),
        _i1.FieldNode(
          name: _i1.NameNode(value: 'geoloc'),
          alias: null,
          arguments: [],
          directives: [],
          selectionSet: null,
        ),
        _i1.FieldNode(
          name: _i1.NameNode(value: 'index_request_cid'),
          alias: null,
          arguments: [],
          directives: [],
          selectionSet: null,
        ),
        _i1.FieldNode(
          name: _i1.NameNode(value: 'pubkey'),
          alias: null,
          arguments: [],
          directives: [],
          selectionSet: null,
        ),
        _i1.FieldNode(
          name: _i1.NameNode(value: 'socials'),
          alias: null,
          arguments: [],
          directives: [],
          selectionSet: null,
        ),
        _i1.FieldNode(
          name: _i1.NameNode(value: 'time'),
          alias: null,
          arguments: [],
          directives: [],
          selectionSet: null,
        ),
        _i1.FieldNode(
          name: _i1.NameNode(value: 'title'),
          alias: null,
          arguments: [],
          directives: [],
          selectionSet: null,
        ),
      ]),
    )
  ]),
);
const SearchProfiles = _i1.OperationDefinitionNode(
  type: _i1.OperationType.query,
  name: _i1.NameNode(value: 'SearchProfiles'),
  variableDefinitions: [
    _i1.VariableDefinitionNode(
      variable: _i1.VariableNode(name: _i1.NameNode(value: 'searchTermLower')),
      type: _i1.NamedTypeNode(
        name: _i1.NameNode(value: 'String'),
        isNonNull: true,
      ),
      defaultValue: _i1.DefaultValueNode(value: null),
      directives: [],
    ),
    _i1.VariableDefinitionNode(
      variable: _i1.VariableNode(name: _i1.NameNode(value: 'searchTerm')),
      type: _i1.NamedTypeNode(
        name: _i1.NameNode(value: 'String'),
        isNonNull: true,
      ),
      defaultValue: _i1.DefaultValueNode(value: null),
      directives: [],
    ),
    _i1.VariableDefinitionNode(
      variable:
          _i1.VariableNode(name: _i1.NameNode(value: 'searchTermCapitalized')),
      type: _i1.NamedTypeNode(
        name: _i1.NameNode(value: 'String'),
        isNonNull: true,
      ),
      defaultValue: _i1.DefaultValueNode(value: null),
      directives: [],
    ),
  ],
  directives: [],
  selectionSet: _i1.SelectionSetNode(selections: [
    _i1.FieldNode(
      name: _i1.NameNode(value: 'profiles'),
      alias: null,
      arguments: [
        _i1.ArgumentNode(
          name: _i1.NameNode(value: 'where'),
          value: _i1.ObjectValueNode(fields: [
            _i1.ObjectFieldNode(
              name: _i1.NameNode(value: '_or'),
              value: _i1.ListValueNode(values: [
                _i1.ObjectValueNode(fields: [
                  _i1.ObjectFieldNode(
                    name: _i1.NameNode(value: 'title'),
                    value: _i1.ObjectValueNode(fields: [
                      _i1.ObjectFieldNode(
                        name: _i1.NameNode(value: '_iregex'),
                        value: _i1.VariableNode(
                            name: _i1.NameNode(value: 'searchTermLower')),
                      )
                    ]),
                  )
                ]),
                _i1.ObjectValueNode(fields: [
                  _i1.ObjectFieldNode(
                    name: _i1.NameNode(value: 'title'),
                    value: _i1.ObjectValueNode(fields: [
                      _i1.ObjectFieldNode(
                        name: _i1.NameNode(value: '_iregex'),
                        value: _i1.VariableNode(
                            name: _i1.NameNode(value: 'searchTerm')),
                      )
                    ]),
                  )
                ]),
                _i1.ObjectValueNode(fields: [
                  _i1.ObjectFieldNode(
                    name: _i1.NameNode(value: 'title'),
                    value: _i1.ObjectValueNode(fields: [
                      _i1.ObjectFieldNode(
                        name: _i1.NameNode(value: '_iregex'),
                        value: _i1.VariableNode(
                            name: _i1.NameNode(value: 'searchTermCapitalized')),
                      )
                    ]),
                  )
                ]),
                _i1.ObjectValueNode(fields: [
                  _i1.ObjectFieldNode(
                    name: _i1.NameNode(value: 'description'),
                    value: _i1.ObjectValueNode(fields: [
                      _i1.ObjectFieldNode(
                        name: _i1.NameNode(value: '_iregex'),
                        value: _i1.VariableNode(
                            name: _i1.NameNode(value: 'searchTermLower')),
                      )
                    ]),
                  )
                ]),
                _i1.ObjectValueNode(fields: [
                  _i1.ObjectFieldNode(
                    name: _i1.NameNode(value: 'description'),
                    value: _i1.ObjectValueNode(fields: [
                      _i1.ObjectFieldNode(
                        name: _i1.NameNode(value: '_iregex'),
                        value: _i1.VariableNode(
                            name: _i1.NameNode(value: 'searchTerm')),
                      )
                    ]),
                  )
                ]),
                _i1.ObjectValueNode(fields: [
                  _i1.ObjectFieldNode(
                    name: _i1.NameNode(value: 'description'),
                    value: _i1.ObjectValueNode(fields: [
                      _i1.ObjectFieldNode(
                        name: _i1.NameNode(value: '_iregex'),
                        value: _i1.VariableNode(
                            name: _i1.NameNode(value: 'searchTermCapitalized')),
                      )
                    ]),
                  )
                ]),
              ]),
            )
          ]),
        )
      ],
      directives: [],
      selectionSet: _i1.SelectionSetNode(selections: [
        _i1.FieldNode(
          name: _i1.NameNode(value: 'avatar'),
          alias: null,
          arguments: [],
          directives: [],
          selectionSet: null,
        ),
        _i1.FieldNode(
          name: _i1.NameNode(value: 'pubkey'),
          alias: null,
          arguments: [],
          directives: [],
          selectionSet: null,
        ),
        _i1.FieldNode(
          name: _i1.NameNode(value: 'description'),
          alias: null,
          arguments: [],
          directives: [],
          selectionSet: null,
        ),
        _i1.FieldNode(
          name: _i1.NameNode(value: 'title'),
          alias: null,
          arguments: [],
          directives: [],
          selectionSet: null,
        ),
        _i1.FieldNode(
          name: _i1.NameNode(value: 'city'),
          alias: null,
          arguments: [],
          directives: [],
          selectionSet: null,
        ),
        _i1.FieldNode(
          name: _i1.NameNode(value: 'data_cid'),
          alias: null,
          arguments: [],
          directives: [],
          selectionSet: null,
        ),
        _i1.FieldNode(
          name: _i1.NameNode(value: 'geoloc'),
          alias: null,
          arguments: [],
          directives: [],
          selectionSet: null,
        ),
        _i1.FieldNode(
          name: _i1.NameNode(value: 'index_request_cid'),
          alias: null,
          arguments: [],
          directives: [],
          selectionSet: null,
        ),
        _i1.FieldNode(
          name: _i1.NameNode(value: 'socials'),
          alias: null,
          arguments: [],
          directives: [],
          selectionSet: null,
        ),
        _i1.FieldNode(
          name: _i1.NameNode(value: 'time'),
          alias: null,
          arguments: [],
          directives: [],
          selectionSet: null,
        ),
      ]),
    )
  ]),
);
const document = _i1.DocumentNode(definitions: [
  GetProfileByAddress,
  GetProfilesByAddress,
  GetProfileCount,
  SearchProfileByTerm,
  SearchProfiles,
]);
