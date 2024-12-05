import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:github_issues_viewer/model/giv_graphql_client.dart';

final graphQLClientProvider =
    StateNotifierProvider<GraphQLClientNotifier, GraphQLClient>((ref) {
  return GraphQLClientNotifier();
});

class GraphQLClientNotifier extends StateNotifier<GraphQLClient> {
  GraphQLClientNotifier() : super(GIVGraphqlClient().client);

  void updateClient(GraphQLClient newClient) {
    state = newClient;
  }
}
