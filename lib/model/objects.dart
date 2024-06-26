class Project {
  final int projectId;
  final String title;
  final String description;
  final String? createdDate;
  final String? status;
  final int? createdBy;
  final List<dynamic> teams;

  Project(
      {required this.projectId,
      required this.title,
      required this.description,
      this.createdDate,
      this.createdBy,
      this.status,
      required this.teams});
}

class Task {
  final int taskId;
  final String title;
  final String description;
  final String? createdDate;
  final String? updatedDate;
  final String status;
  final int projectId;
  final List<dynamic> assignedTo;

  Task(
      {required this.taskId,
      required this.title,
      required this.description,
      this.createdDate,
      this.updatedDate,
      required this.projectId,
      required this.status,
      required this.assignedTo});
}

class Team {
  final int teamId;
  final int owner;
  final String name;
  final List<dynamic> members;

  Team(
      {required this.owner,
      required this.teamId,
      required this.name,
      required this.members});
  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      teamId: json['id'] is int ? json['id'] : int.parse(json['id']),
      name: json['name'],
      members: json['members'],
      owner: json['owner'] is int ? json['owner'] : int.parse(json['owner']),
    );
  }
}

class User {
  final int userId;
  final String name;
  final String email;

  User({
    required this.userId,
    required this.name,
    required this.email,
  });
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['id'] is int ? json['id'] : int.parse(json['id']),
      name: json['name'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': userId,
        'name': name,
        'email': email,
      };
}

class TeamInvitation {
  final int invitationId;
  final Team team;
  final User user;
  final bool isAccepted;

  TeamInvitation( 
      {required this.invitationId,required this.team, required this.user, required this.isAccepted});
}

class DropdownItem {
  final int id;
  final String name;

  DropdownItem(this.id, this.name);
}
