import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_issues_viewer/model/giv_graphql_client.dart';

final givGraphQLClientProvider = Provider<GIVGraphqlClient>((ref) {
  return GIVGraphqlClient();
});
