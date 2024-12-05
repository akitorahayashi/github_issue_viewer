import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_issues_viewer/model/giv_graphql_client.dart';
import 'package:github_issues_viewer/view_model/graphql_client_provider.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:github_issues_viewer/view_model/repository_owner_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FakeGraphQLClient extends Fake implements GIVGraphqlClient {
  final Map<String, dynamic>? mockResponse;
  final bool shouldThrow;

  FakeGraphQLClient({this.mockResponse, this.shouldThrow = false});

  @override
  Future<QueryResult<TParsed>> query<TParsed>(
      QueryOptions<TParsed> options) async {
    if (shouldThrow) {
      throw Exception('Simulated GraphQL Error');
    }

    return QueryResult<TParsed>(
      options: options,
      data: mockResponse,
      source: QueryResultSource.network,
    );
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  group('RepositoryOwnerNotifier Tests with FakeGraphQLClient', () {
    late ProviderContainer container;
    late FakeGraphQLClient fakeClient;

    setUp(() {
      SharedPreferences.setMockInitialValues({
        'ownerLogin': 'testUser',
      });

      container = ProviderContainer();
    });

    test('fetchOwnerData fetches owner data successfully', () async {
      fakeClient = FakeGraphQLClient(
        mockResponse: {
          'user': {
            'name': 'Test User',
            'login': 'testUser',
            'avatarUrl': 'https://example.com/avatar.png',
            'repositories': {
              'nodes': [
                {
                  'name': 'Test Repo',
                  'description': 'Test Description',
                  'updatedAt': '2023-01-01T00:00:00Z',
                  'primaryLanguage': {'name': 'Dart'},
                },
              ],
            },
          },
        },
      );

      container = ProviderContainer(
        overrides: [
          givGraphQLClientProvider.overrideWithValue(fakeClient),
        ],
      );

      final notifier = container.read(repositoryOwnerProvider.notifier);
      await notifier.fetchOwnerData('testUser');

      final state = container.read(repositoryOwnerProvider);

      expect(state.owner?.login, 'testUser');
      expect(state.owner?.name, 'Test User');
      expect(state.isLoading, false);
    });

    test('fetchOwnerData handles errors gracefully', () async {
      fakeClient = FakeGraphQLClient(shouldThrow: true);

      container = ProviderContainer(
        overrides: [
          givGraphQLClientProvider.overrideWithValue(fakeClient),
        ],
      );

      final notifier = container.read(repositoryOwnerProvider.notifier);

      await notifier.fetchOwnerData('testUser');

      final state = container.read(repositoryOwnerProvider);

      expect(state.owner, isNull);
      expect(state.isLoading, false);
    });
  });
}
