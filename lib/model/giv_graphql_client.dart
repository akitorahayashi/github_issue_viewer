import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class GIVGraphqlClient extends GraphQLClient {
  GIVGraphqlClient()
      : super(
          link: HttpLink(
            'https://api.github.com/graphql',
            defaultHeaders: {
              'Authorization':
                  'Bearer ${dotenv.env['GITHUB_PERSONAL_ACCESS_TOKEN']}',
            },
          ),
          cache: GraphQLCache(store: InMemoryStore()),
        );
}
