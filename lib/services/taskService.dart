import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rtc_app/model/objects.dart';
import '../auth/token.dart';

var url = '127.0.0.1:8000';

List<Task> tasks = [];
Future<List<Task>> getTask(int projectId) async {
  tasks.clear();
  var accessToken = await TokenStorage.getAccessToken();
  try {
    var response = await http.get(
      Uri.http('$url', 'task/'),
      headers: {HttpHeaders.authorizationHeader: 'Bearer $accessToken'},
    );
    // print('task  --- $response.body');
    if (response.statusCode == 200) {
      var tasksJson = jsonDecode(response.body);

      for (var eachTask in tasksJson) {
        List<dynamic> assingedTo = eachTask['assigned_to'];

        final task = Task(
            taskId: eachTask['id'],
            title: eachTask['title'],
            assignedTo: assingedTo,
            description: eachTask['description'],
            updatedDate: eachTask['updated_time'],
            status: eachTask['status'],
            projectId: eachTask['project']);
        tasks.add(task);
      }
    } else {
      print('error $response');
    }
  } catch (e) {
    print('2 $e');
  }
  tasks = tasks.where((task)=> task.projectId == projectId).toList();
  return tasks;
}

Future<bool> createTask(Task task) async {
  var accessToken = await TokenStorage.getAccessToken();
  bool created = false;

  // final String apiUrl = 'http:///';
  List<int> assignedTo = task.assignedTo.map((user) => user.userId).toList().cast<int>();
  for(var i in assignedTo){
    print('ass $i');
  }

  final Map<String, dynamic> requestBody = {
    "title": task.title,
    "description": task.description,
    "status": task.status,
    "assigned_to": assignedTo,
    "project": task.projectId
  };

  print(jsonEncode(requestBody));

  try {
    // print('workd until object');
    final response = await http.post(
      Uri.http('$url','task/'),
      headers: {
        'Content-Type': 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $accessToken'
      },
      body: jsonEncode(requestBody),
    );


    if (response.statusCode == 201 || response.statusCode == 200) {
      // final responseBody = jsonDecode(response.body);
      created = true;
      // print('task created successfully: ${responseBody.toString()}');
    } else {
      throw Exception('Failed to Create tasks!');
    }
  } catch (e) {
    print('Error sending POST request: $e');
  }
  return created;
}

Future<bool> updateTaskStatus(int taskId, String status) async {
  var accessToken = await TokenStorage.getAccessToken();
  bool created = false;

  final String apiUrl = 'http://$url/task/$taskId/';

  final Map<String, dynamic> requestBody = {'status': status};

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
      created = true;
    } else {
      throw Exception('Failed to Update task!');
    }
  } catch (e) {
    print('Error sending Patch request: $e');
  }
  return created;
}
