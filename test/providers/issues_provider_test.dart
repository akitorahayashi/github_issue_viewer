// import 'package:flutter_test/flutter_test.dart';
// import 'package:github_issues_viewer/view_model/issues_provider.dart';
// import 'package:mockito/mockito.dart';
// import 'package:graphql_flutter/graphql_flutter.dart';
// import 'package:github_issues_viewer/model/giv_graphql_client.dart';

// class MockGraphQLClient extends Mock implements GraphQLClient {}

// void main() {
//   group('IssuesProvider Tests', () {
//     late IssuesNotifier issuesNotifier;
//     late MockGraphQLClient mockClient;

//     setUp(() {
//       mockClient = MockGraphQLClient();
//       GIVGraphqlClient.client = mockClient; // MockGraphQLClientを使用するように設定
//       issuesNotifier = IssuesNotifier();
//     });

//     test('fetchIssues fetches issues without label', () async {
//       when(mockClient.query(any)).thenAnswer((_) async => QueryResult(
//             options: QueryOptions(document: gql('')),
//             data: {
//               'repository': {
//                 'issues': {
//                   'edges': [
//                     {
//                       'node': {
//                         'title': 'Test Issue',
//                         'body': 'Issue Body',
//                         'url': 'http://example.com',
//                         'createdAt': '2023-12-05',
//                         'author': {'login': 'testAuthor'},
//                         'state': 'OPEN',
//                       }
//                     }
//                   ]
//                 }
//               }
//             },
//           ));

//       await issuesNotifier.fetchIssues(login: 'owner', name: 'repo');
//       final issues = issuesNotifier.state.value!;
//       expect(issues.length, 1);
//       expect(issues[0].title, 'Test Issue');
//     });

//     test('fetchIssues sets error state on failure', () async {
//       when(mockClient.query(any)).thenThrow(Exception('GraphQL Error'));

//       await issuesNotifier.fetchIssues(login: 'owner', name: 'repo');
//       expect(issuesNotifier.state.hasError, true);
//     });
//   });
// }
