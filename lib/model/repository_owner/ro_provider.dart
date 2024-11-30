import 'package:flutter_riverpod/flutter_riverpod.dart';
import './repository_owner.dart';

// プロバイダー
final repositoryOwnerProvider =
    StateNotifierProvider<RepositoryOwnerNotifier, RepositoryOwner?>(
  (ref) => RepositoryOwnerNotifier(),
);

class RepositoryOwnerNotifier extends StateNotifier<RepositoryOwner?> {
  RepositoryOwnerNotifier() : super(null);

  // データを取得して状態を更新する
  Future<void> fetchOwnerData(String ownerLogin) async {
    try {
      final owner =
          await RepositoryOwner.fetchOwnerData(ownerLogin: ownerLogin);
      state = owner; // 状態を更新
    } catch (e) {
      print('Failed to fetch RepositoryOwner: $e');
      state = null; // エラー時は null に戻す
      rethrow;
    }
  }
}
