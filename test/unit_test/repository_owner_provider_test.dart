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

  group('RepositoryOwnerNotifierのテスト', () {
    late ProviderContainer container;
    late FakeGraphQLClient fakeClient;

    setUp(() {
      SharedPreferences.setMockInitialValues({
        'ownerLogin': 'testUser',
      });

      container = ProviderContainer();
    });

    test('fetchOwnerDataが正常にデータを取得できる', () async {
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

    test('fetchOwnerDataがエラーを正しく処理する', () async {
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

    test('空のリポジトリリストが返ってきた場合、データが正しく処理される', () async {
      fakeClient = FakeGraphQLClient(
        mockResponse: {
          'user': {
            'name': 'Test User',
            'login': 'testUser',
            'avatarUrl': 'https://example.com/avatar.png',
            'repositories': {
              'nodes': [], // 空のリポジトリリスト
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

      expect(state.owner?.repositories, isEmpty);
      expect(state.isLoading, false);
    });

    test('ユーザーデータが返ってこなかった場合、エラーが正しく処理される', () async {
      fakeClient = FakeGraphQLClient(
        mockResponse: {
          'user': null, // userデータがない
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

      expect(state.owner, isNull);
      expect(state.isLoading, false);
    });

    test('特定のフィールドがnullの場合でもデータが正しく処理される', () async {
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
                  'description': null, // descriptionがnull
                  'updatedAt': '2023-01-01T00:00:00Z',
                  'primaryLanguage': null, // primaryLanguageがnull
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
      final repositories = state.owner?.repositories ?? [];

      expect(repositories.first.description, '');
      expect(repositories.first.primaryLanguage, 'Unknown');
      expect(state.isLoading, false);
    });

    test('複数のリポジトリがある場合でも正しくデータが処理される', () async {
      fakeClient = FakeGraphQLClient(
        mockResponse: {
          'user': {
            'name': 'Test User',
            'login': 'testUser',
            'avatarUrl': 'https://example.com/avatar.png',
            'repositories': {
              'nodes': [
                {
                  'name': 'Repo 1',
                  'description': 'Description 1',
                  'updatedAt': '2023-01-01T00:00:00Z',
                  'primaryLanguage': {'name': 'Dart'},
                },
                {
                  'name': 'Repo 2',
                  'description': 'Description 2',
                  'updatedAt': '2023-01-02T00:00:00Z',
                  'primaryLanguage': {'name': 'Flutter'},
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
      final repositories = state.owner?.repositories ?? [];

      expect(repositories.length, 2);
      expect(repositories[0].name, 'Repo 1');
      expect(repositories[1].name, 'Repo 2');
      expect(state.isLoading, false);
    });

    test('ログアウト時にSharedPreferencesが正しく削除される', () async {
      final notifier = container.read(repositoryOwnerProvider.notifier);

      await notifier.logout();

      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getString('ownerLogin'), isNull);
      expect(container.read(repositoryOwnerProvider).owner, isNull);
      expect(container.read(repositoryOwnerProvider).isLoading, false);
    });

    test('初期状態が正しく設定されている', () {
      final state = container.read(repositoryOwnerProvider);
      expect(state.owner, isNull);
      expect(state.isLoading, true);
    });
  });
}
