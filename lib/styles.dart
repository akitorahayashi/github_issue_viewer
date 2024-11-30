import 'package:intl/intl.dart';

// 日付を「yyyy年MM月dd日」の形式でフォーマットする関数
String formatDate(String dateString) {
  try {
    // 文字列の日付をDateTimeに変換
    final DateTime date = DateTime.parse(dateString);

    // 日付を「yyyy年MM月dd日」形式にフォーマット
    return DateFormat('yyyy年MM月dd日').format(date);
  } catch (e) {
    // フォーマットに失敗した場合、エラーメッセージを返す
    return 'Invalid Date';
  }
}
