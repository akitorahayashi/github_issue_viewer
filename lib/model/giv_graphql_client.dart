import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class GIVGraphqlClient {
  static final String? token = dotenv.env['GITHUB_PERSONAL_ACCESS_TOKEN'];
  static const String apiEndpoint = 'https://api.github.com/graphql';

  static GraphQLClient getGraphQLClient() {
    final link = HttpLink(
      apiEndpoint,
      defaultHeaders: {
        'Authorization': 'Bearer $token',
      },
    );

    return GraphQLClient(
      link: link,
      cache: GraphQLCache(store: InMemoryStore()),
    );
  }
}
