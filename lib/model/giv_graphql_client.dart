import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class GIVGraphqlClient {
  final String? _token;
  final String _apiEndpoint;
  late final GraphQLClient _client;

  GIVGraphqlClient()
      : _token = dotenv.env['GITHUB_PERSONAL_ACCESS_TOKEN'],
        _apiEndpoint = 'https://api.github.com/graphql' {
    final link = HttpLink(
      _apiEndpoint,
      defaultHeaders: {
        'Authorization': 'Bearer $_token',
      },
    );

    _client = GraphQLClient(
      link: link,
      cache: GraphQLCache(store: InMemoryStore()),
    );
  }

  GraphQLClient get client => _client;
}
