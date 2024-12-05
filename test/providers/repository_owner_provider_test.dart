import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_issues_viewer/model/repository_owner.dart';
import 'package:github_issues_viewer/view_model/repository_owner_provider.dart';

import 'package:shared_preferences/shared_preferences.dart';

class FakeRepositoryOwnerNotifier extends RepositoryOwnerNotifier {
  FakeRepositoryOwnerNotifier(super.ref, this.mockResponse, this.shouldThrow);

  final Map<String, dynamic>? mockResponse;
  final bool shouldThrow;

  @override
  Future<void> fetchOwnerData(String ownerLogin) async {
    if (shouldThrow) {
      state = state.copyWith(owner: null, isLoading: false);
      throw Exception('Simulated GraphQL Error');
    }

    if (mockResponse == null) {
      state = state.copyWith(owner: null, isLoading: false);
      return;
    }

    final owner = RepositoryOwner.fromJson(mockResponse!);
    state = state.copyWith(owner: owner, isLoading: false);
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('RepositoryOwnerNotifier Tests', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
      SharedPreferences.setMockInitialValues({
        'ownerLogin': 'testUser', // 必要に応じて初期値を設定
      });
    });

    tearDown(() {
      container.dispose();
    });

    test('fetchOwnerData fetches data successfully', () async {
      const mockResponse = {
        'user': {
          'name': 'Test User',
          'login': 'testUser',
          'avatarUrl': 'https://example.com/avatar.png',
          'repositories': {
            'nodes': [
              {
                'name': 'Repo 1',
                'description': 'A sample repo',
                'updatedAt': '2023-01-01T00:00:00Z',
                'primaryLanguage': {'name': 'Dart'},
              },
            ],
          },
        },
      };

      container = ProviderContainer(
        overrides: [
          repositoryOwnerProvider.overrideWith((ref) {
            return FakeRepositoryOwnerNotifier(ref, mockResponse, false);
          }),
        ],
      );

      final notifier = container.read(repositoryOwnerProvider.notifier);
      await notifier.fetchOwnerData('testUser');

      final state = container.read(repositoryOwnerProvider);

      expect(state.owner?.name, 'Test User');
      expect(state.owner?.login, 'testUser');
      expect(state.owner?.repositories.length, 1);
      expect(state.owner?.repositories.first.name, 'Repo 1');
      expect(state.isLoading, false);
    });

    test('fetchOwnerData handles errors', () async {
      container = ProviderContainer(
        overrides: [
          repositoryOwnerProvider.overrideWith((ref) {
            return FakeRepositoryOwnerNotifier(ref, null, true);
          }),
        ],
      );

      final notifier = container.read(repositoryOwnerProvider.notifier);
      await expectLater(
        () async => await notifier.fetchOwnerData('testUser'),
        throwsA(isA<Exception>()),
      );

      final state = container.read(repositoryOwnerProvider);

      expect(state.owner, isNull);
      expect(state.isLoading, false);
    });
  });
}
