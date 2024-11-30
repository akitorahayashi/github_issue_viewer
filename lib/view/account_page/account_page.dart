import 'package:flutter/material.dart';
import 'package:github_issues_viewer/model/repository_owner.dart';
import 'package:github_issues_viewer/model/giv_graphql_client.dart'; // GIVGraphqlClientをインポート

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final TextEditingController _controller = TextEditingController();
  String? _ownerLogin;
  RepositoryOwner? _ownerData;
  bool _isLoading = false;
  String? _errorMessage;

  // ユーザーIDを入力後、データを取得する関数
  Future<void> _fetchOwnerData() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final ownerLogin = _controller.text;
      if (ownerLogin.isNotEmpty) {
        // GIVGraphqlClientのトークンとエンドポイントを使用
        final owner =
            await RepositoryOwner.fetchOwnerData(ownerLogin: ownerLogin);
        setState(() {
          _ownerData = owner;
        });
      } else {
        setState(() {
          _errorMessage = "Please enter a GitHub username.";
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = "Failed to fetch data: $e";
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GitHub User Info'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter GitHub Username',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _fetchOwnerData,
              child: Text('Fetch Data'),
            ),
            if (_isLoading) CircularProgressIndicator(),
            if (_errorMessage != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  _errorMessage!,
                  style: TextStyle(color: Colors.red),
                ),
              ),
            if (_ownerData != null) ...[
              SizedBox(height: 16),
              Text('Name: ${_ownerData!.name}'),
              Text('ID: ${_ownerData!.id}'),
              Text('Avatar: ${_ownerData!.avatarUrl}'),
              SizedBox(height: 16),
              Text('Repositories:'),
              ..._ownerData!.repositories.map((repo) => Text(repo)).toList(),
            ],
          ],
        ),
      ),
    );
  }
}
