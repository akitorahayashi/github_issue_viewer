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
  // owner data
  static const String fetchOwnerDataQuery = '''
    query(\$login: String!) {
      user(login: \$login) {
        name
        login
        avatarUrl
        repositories(first: 100, privacy: PUBLIC) {
          nodes {
            name
            description
            updatedAt
            primaryLanguage {
              name
            }
          }
        }
      }
    }
  ''';
  // labels
  static const String fetchLabelsQuery = """
    query(\$owner: String!, \$name: String!) {
      repository(owner: \$owner, name: \$name) {
        labels(first: 100) {
          nodes {
            name
          }
        }
      }
    }
    """;
  // issues
  static const String fetchIssuesForLabelQuery = '''
          query GetIssues(\$login: String!, \$name: String!, \$label: String!) {
            repository(owner: \$login, name: \$name) {
              issues(labels: [\$label], first: 10) {
                edges {
                  node {
                    title
                    body
                    url
                    createdAt
                    author {
                      login
                    }
                    state
                  }
                }
              }
            }
          }
        ''';
  static const String fetchAllIssuesQuery = '''
          query GetAllIssues(\$login: String!, \$name: String!) {
            repository(owner: \$login, name: \$name) {
              issues(first: 20) {
                edges {
                  node {
                    title
                    body
                    url
                    createdAt
                    author {
                      login
                    }
                    state
                  }
                }
              }
            }
          }
        ''';
}
