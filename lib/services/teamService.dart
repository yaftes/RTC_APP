import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rtc_app/model/objects.dart';
import '../auth/token.dart';

var url = '127.0.0.1:8000';

final List<Team> teams = [];
Future<List<Team>> getTeams() async {
  var accessToken = await TokenStorage.getAccessToken();
  teams.clear();
  try {
    var response = await http.get(
      Uri.http('$url', 'team'),
      headers: {HttpHeaders.authorizationHeader: 'Bearer $accessToken'},
    );
    if (response.statusCode == 200) {
      var projectsJson = jsonDecode(response.body);

      for (var eachTeam in projectsJson) {
        List<dynamic> members = eachTeam['members'];

        final team = Team(
          owner: eachTeam['owner'],
          teamId: eachTeam['id'],
          name: eachTeam['name'],
          members: members,
        );
        teams.add(team);
      }
    } else {
      print('error $response');
    }
  } catch (e) {
    print('2 $e');
  }
  print(teams);

  return teams;
}

Future<bool> updateTeam(int teamId, String name) async {
  var accessToken = await TokenStorage.getAccessToken();
  try {
    var response = await http.put(
      Uri.http('$url', 'team/$teamId'),
      headers: {HttpHeaders.authorizationHeader: 'Bearer $accessToken'},
      body: jsonEncode({'name': name, 'members': teams[teamId].members}),
    );
    if (response.statusCode == 200) {
      print('team updated');
      return true;
    } else {
      print('error $response');
      return false;
    }
  } catch (e) {
    print('2 $e');
    return false;
  }
}
