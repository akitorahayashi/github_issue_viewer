import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_issues_viewer/view/login_form/login_form.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:github_issues_viewer/view_model/repository_owner_provider.dart';

import 'login_form_test.mocks.dart';

@GenerateMocks([RepositoryOwnerNotifier]) // モッククラスを自動生成
void main() {
  late MockRepositoryOwnerNotifier mockNotifier;

  setUp(() {
    // 各テストの前にモックを初期化
    mockNotifier = MockRepositoryOwnerNotifier();
  });

  group('LoginFormウィジェットの動作確認', () {
    testWidgets('テキストフィールドとボタンが表示されているか', (WidgetTester tester) async {
      // ProviderScopeでウィジェットをラップ
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            repositoryOwnerProvider.overrideWith((ref) => mockNotifier),
          ],
          child: MaterialApp(
            home: Scaffold(
              body: LoginForm(),
            ),
          ),
        ),
      );

      // テキストフィールドが存在するか
      expect(find.byType(TextField), findsOneWidget);

      // ボタンが存在するか
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('テキストフィールドに入力できるか', (WidgetTester tester) async {
      // ProviderScopeでウィジェットをラップ
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            repositoryOwnerProvider.overrideWith((ref) => mockNotifier),
          ],
          child: MaterialApp(
            home: Scaffold(
              body: LoginForm(),
            ),
          ),
        ),
      );

      // テキストフィールドにGitHub IDを入力
      const testGitHubID = 'testUser';
      await tester.enterText(find.byType(TextField), testGitHubID);

      // 入力値が反映されているか確認
      expect(find.text(testGitHubID), findsOneWidget);
    });

    testWidgets('ボタンを押すとfetchOwnerDataが呼び出されるか', (WidgetTester tester) async {
      // fetchOwnerDataがFuture<void>を返すよう設定
      when(mockNotifier.fetchOwnerData(any)).thenAnswer((_) async {});

      // ProviderScopeでウィジェットをラップ
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            repositoryOwnerProvider.overrideWith((ref) => mockNotifier),
          ],
          child: MaterialApp(
            home: Scaffold(
              body: LoginForm(),
            ),
          ),
        ),
      );

      // テキストフィールドにGitHub IDを入力
      const testGitHubID = 'testUser';
      await tester.enterText(find.byType(TextField), testGitHubID);

      // ボタンをタップ
      await tester.tap(find.byType(ElevatedButton));

      // 非同期操作が完了するのを待つ
      await tester.pump();

      // fetchOwnerDataが正しい引数で1回呼び出されたかを検証
      verify(mockNotifier.fetchOwnerData(testGitHubID)).called(1);
    });
  });
}
