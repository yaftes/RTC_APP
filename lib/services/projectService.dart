import 'dart:convert';
import 'dart:io';

import 'package:rtc_app/auth/token.dart';
import 'package:rtc_app/model/objects.dart';
import 'package:http/http.dart' as http;

var url = '127.0.0.1:8000';

final List<Project> projects = [];

Future getProjects() async {
  var accessToken = await TokenStorage.getAccessToken();
  projects.clear();
  try {
    var response = await http.get(
      Uri.http('$url', 'project/'),
      headers: {HttpHeaders.authorizationHeader: 'Bearer $accessToken'},
    );

    if (response.statusCode == 200) {
      var projectsJson = jsonDecode(response.body);

      for (var eachProject in projectsJson) {
        List<int> teams = eachProject['teams'].cast<int>();

        final project = Project(
          projectId: eachProject['id'],
          title: eachProject['title'],
          description: eachProject['description'],
          createdDate: eachProject['created_date'],
          createdBy: eachProject['created_by'],
          status: eachProject['status'],
          teams: teams,
        );
        projects.add(project);
      }
    } else {
      throw Exception('Failed to Fetch projects!');
    }
  } catch (e) {
    print(e);
  }
  return projects;
}

Future<bool> createProject(Project project) async {
  var created = false;
  var accessToken = await TokenStorage.getAccessToken();

  final String apiUrl = 'http://$url/project/';
  List<int> teams =
      project.teams.map((team) => team.teamId).toList().cast<int>();
  for (var team in teams) {
    print('The object $team');
  }
  final Map<String, dynamic> requestBody = {
    'title': project.title,
    'description': project.description,
    'teams': teams
  };

  var responseBody;
  try {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $accessToken'
      },
      body: jsonEncode(requestBody),
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      created = true;
      responseBody = jsonDecode(response.body);
      print('Project created successfully: ${responseBody}');
    } else {
      throw Exception('Failed to Create projects!');
    }
  } catch (e) {
    print('Error sending POST request: $e');
  }
  return created;
}

Future<bool> updateProject(Project project) async {
  var accessToken = await TokenStorage.getAccessToken();
  bool created = false;
  final projectId = project.projectId;

  final String apiUrl = 'http://$url/project/$projectId';

  final Map<String, dynamic> requestBody = {'status': project.status};

  try {
    final response = await http.patch(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $accessToken'
      },
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      created = true;
      print('project updated successfully: ${responseBody.toString()}');
    } else {
      throw Exception('Failed to Update project!');
    }
  } catch (e) {
    print('Error sending Patch request: $e');
  }
  return created;
}

Future<void> deleteProject(int projectId) async {
  var accessToken = await TokenStorage.getAccessToken();

  final String apiUrl = 'http://$url/project/$projectId';

  try {
    final response = await http.delete(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $accessToken'
      },
    );

    if (response.statusCode == 200 || response.statusCode == 204) {
      print('Project deleted successfully');
    } else {
      throw Exception('Failed to Delete project!');
    }
  } catch (e) {
    print('Error sending DELETE request: $e');
  }
}
