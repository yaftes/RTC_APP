import 'package:flutter/material.dart';
import 'package:rtc_app/components/createTaskForm.dart';
import 'package:rtc_app/model/objects.dart';
import 'package:rtc_app/services/taskService.dart';
import 'package:rtc_app/services/userService.dart';

class TaskBoard extends StatefulWidget {
  final Project project;
  TaskBoard({Key? key, required this.project}) : super(key: key);
  @override
  _TaskBoardState createState() => _TaskBoardState();
}

class _TaskBoardState extends State<TaskBoard> {
  List<Task> todoTasks = [];
  List<Task> inProgressTasks = [];
  List<Task> doneTasks = [];
  List<User> users = [];

  Future<void> getUser(BuildContext context) async {
    user = await getUserFromPrefs(context);
  }

  Future<void> _getTasks() async {
    inProgressTasks.clear();
    todoTasks.clear();
    tasks.clear();
    getUser(context);
    try {
      List<Task> tasks = await getTask(widget.project.projectId);
      for (var task in tasks) {
        print(task.status);
        if (task.status == "N") {
          todoTasks.add(task);
        } else {
          inProgressTasks.add(task);
        }
        // } else if (task.status == "O") {
        //   doneTasks.add(task);
        // }
      }
    } catch (e) {
      print('error getting task $e');
    }

    try {
      users = await getUsersInProject(widget.project.projectId);
    } catch (e) {
      print('user dfsdfds $e');
    }
    setState(() {});
  }

  Future<void> _updateTask(int taskId, String status) async {
    try {
      bool update = await updateTaskStatus(taskId, status);
      if (update) {
        _getTasks();
      }
      print('task updated');
    } catch (e) {
      print('error updating task $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _getTasks();
  }

  void _addNewTask(String taskType) {
    setState(() {
      if (taskType == "To Do") {
        todoTasks.add(
          Task(
              taskId: 9,
              title: 'title 9',
              description: 'description 9',
              projectId: 1,
              status: 'N',
              assignedTo: [1]),
        );
      } else if (taskType == "In Progress") {
        inProgressTasks.add(
          Task(
              taskId: 10,
              title: 'title 10',
              description: 'description 10',
              projectId: 1,
              status: 'N',
              assignedTo: [1]),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.project.title),
        backgroundColor: Colors.blue,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                elevation: 10,
                context: context,
                isScrollControlled: true,
                builder: (context) {
                  return CreateTaskFormModal(
                      assignees: users,
                      onSubmit: (title, description, status, assignedTo) {
                        try {
                          Task task = Task(
                              taskId: 0,
                              title: title,
                              description: description,
                              projectId: widget.project.projectId,
                              status: status,
                              assignedTo: assignedTo);
                          setState(() {
                            createTask(task);
                            _getTasks();
                            print('object');
                          });
                        } catch (e) {
                          print('add object $e');
                        }
                        // setState(() {});
                      });
                },
              );
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Row(
        children: <Widget>[
          Expanded(
            child: buildTaskColumn('N', "To Do", todoTasks, inProgressTasks),
          ),
          Expanded(
            child:
                buildTaskColumn('O', "In Progress", inProgressTasks, todoTasks),
          )
        ],
      ),
    );
  }

  Widget buildTaskColumn(
      String status, String title, List<Task> tasks, List<Task> oppositeTasks) {
    return DragTarget<Task>(
      onWillAccept: (data) => data != null && data.status != status,
      onAccept: (data) {
        _updateTask(data.taskId, status);
      },
      builder: (context, candidateData, rejectedData) {
        return Container(
          margin: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(0, 1),
                blurRadius: 6.0,
              ),
            ],
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    topRight: Radius.circular(8.0),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      onPressed: () => _addNewTask(status),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    print('${user[0].userId} ${tasks[index].title} ${tasks[index].assignedTo}');
                    return (tasks[index].assignedTo.contains(user[0].userId) )? Draggable<Task>(
                      data: tasks[index],
                      feedback: Card(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                tasks[index].title,
                                style: const TextStyle(fontSize: 14),
                                textAlign: TextAlign.left,
                              ),
                              const SizedBox(height: 10),
                              Text(
                                tasks[index].description,
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.grey),
                              )
                            ],
                          ),
                        ),
                      ),
                      childWhenDragging: const Card(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '',
                                style: TextStyle(fontSize: 14),
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(height: 10),
                              Text(
                                '',
                                style:
                                    TextStyle(fontSize: 12, color: Colors.grey),
                              )
                            ],
                          ),
                        ),
                      ),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                tasks[index].title,
                                style: const TextStyle(fontSize: 14),
                                textAlign: TextAlign.left,
                              ),
                              const SizedBox(height: 10),
                              Text(
                                tasks[index].description,
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.grey),
                              )
                            ],
                          ),
                        ),
                      ),
                    ) : Card(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                tasks[index].title,
                                style: const TextStyle(fontSize: 14),
                                textAlign: TextAlign.left,
                              ),
                              const SizedBox(height: 10),
                              Text(
                                tasks[index].description,
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.grey),
                              )
                            ],
                          ),
                        ),
                      );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
