import 'package:appflowy_board/appflowy_board.dart';
import 'package:rtc_app/components/createTaskForm.dart';
import 'package:rtc_app/model/objects.dart';
import 'package:flutter/material.dart';
import 'package:rtc_app/services/taskService.dart';
import 'package:rtc_app/services/userService.dart';

class ProjectDetailPage extends StatefulWidget {
  final Project project;
  ProjectDetailPage({Key? key, required this.project}) : super(key: key);

  @override
  _ProjectDetailPageState createState() => _ProjectDetailPageState();
}

class _ProjectDetailPageState extends State<ProjectDetailPage> {
  final AppFlowyBoardController controller = AppFlowyBoardController(
    onMoveGroup: (fromGroupId, fromIndex, toGroupId, toIndex) {
      debugPrint('Move item from $fromIndex to $toIndex');
    },
    onMoveGroupItem: (groupId, fromIndex, toIndex) {
      debugPrint('Move $groupId:$fromIndex to $groupId:$toIndex');
    },
    onMoveGroupItemToGroup: (fromGroupId, fromIndex, toGroupId, toIndex) {
      debugPrint('Move $fromGroupId:$fromIndex to $toGroupId:$toIndex');
    },
  );
  late AppFlowyBoardScrollController boardController;

  List<RichTextItem> newTask = [];
  List<RichTextItem> ongoingTask = [];
  List<RichTextItem> terminatedTask = [];
  List<User> users = [];

  @override
  void initState() {
    super.initState();
    initializeTasks();
  }

  @override
  Widget build(BuildContext context) {
    // final Object? arguments = ModalRoute.of(context)?.settings.arguments;
    // if (arguments != null && arguments is Project) {
    //   project = arguments;
    // }

    final config = AppFlowyBoardConfig(
      groupBackgroundColor: HexColor.fromHex('#F7F8FC'),
      stretchGroupHeight: false,
    );
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
                        onSubmit: (title, description, status,  assignedTo) {
                          try {
                            createTask(Task(
                                taskId: 0,
                                title: title,
                                description: description,
                                projectId: widget.project.projectId,
                                status: status,
                                assignedTo: assignedTo));
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
        body: AppFlowyBoard(
            controller: controller,
            cardBuilder: (context, group, groupItem) {
              return AppFlowyGroupCard(
                key: ValueKey(groupItem.id),
                // child: _buildCard(groupItem),
              );
            },
            boardScrollController: boardController,
            footerBuilder: (context, columnData) {
              return AppFlowyGroupFooter(
                icon: const Icon(Icons.add, size: 20),
                title: const Text('New'),
                height: 50,
                margin: config.groupBodyPadding,
                onAddButtonClick: () {
                  boardController.scrollToBottom(columnData.id);
                },
              );
            },
            headerBuilder: (context, columnData) {
              return AppFlowyGroupHeader(
                icon: const Icon(Icons.lightbulb_circle),
                title: SizedBox(
                  width: 60,
                  child: TextField(
                    controller: TextEditingController()
                      ..text = columnData.headerData.groupName,
                    onSubmitted: (val) {
                      controller
                          .getGroupController(columnData.headerData.groupId)!
                          .updateGroupName(val);
                    },
                  ),
                ),
                addIcon: const Icon(Icons.add, size: 20),
                moreIcon: const Icon(Icons.more_horiz, size: 20),
                height: 50,
                margin: config.groupBodyPadding,
              );
            },
            groupConstraints: const BoxConstraints.tightFor(width: 240),
            config: config));
  }

  Widget _buildCard(AppFlowyGroupItem item) {
    if (item is TextItem) {
      return Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Text(item.s),
        ),
      );
    }

    if (item is RichTextItem) {
      return RichTextCard(item: item);
    }

    throw UnimplementedError();
  }

  void initializeTasks() async {
    boardController = AppFlowyBoardScrollController();
    try {
      users = await getUsersInProject(widget.project.projectId);
      print('users');
    } catch (e) {
      print('user dfsdfds $e');
    }
    try {
      List<Task> tasks = await getTask(widget.project.projectId);
      for (Task task in tasks) {
        if (task.status == 'N') {
          newTask.add(RichTextItem(task: task));
        } else if (task.status == 'O') {
          ongoingTask.add(RichTextItem(task: task));
        } else if (task.status == 'N') {
          terminatedTask.add(RichTextItem(task: task));
        }
      }
      boardController = AppFlowyBoardScrollController();
      final group1 =
          AppFlowyGroupData(id: "To Do", name: "To Do", items: newTask);

      final group2 = AppFlowyGroupData(
          id: "In Progress", name: "In Progress", items: ongoingTask);

      final group3 = AppFlowyGroupData(
          id: "Terminated", name: "Terminated", items: terminatedTask);

      controller.addGroup(group1);
      controller.addGroup(group2);
      controller.addGroup(group3);
    } catch (e) {
      print(e.toString());
    }
  }
}

class RichTextCard extends StatefulWidget {
  final RichTextItem item;
  const RichTextCard({
    required this.item,
    Key? key,
  }) : super(key: key);

  @override
  State<RichTextCard> createState() => _RichTextCardState();
}

class _RichTextCardState extends State<RichTextCard> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.item.task.title,
              style: const TextStyle(fontSize: 14),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 10),
            Text(
              widget.item.task.description,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            )
          ],
        ),
      ),
    );
  }
}

class TextItem extends AppFlowyGroupItem {
  final String s;

  TextItem(this.s);

  @override
  String get id => s;
}

class RichTextItem extends AppFlowyGroupItem {
  final Task task;

  RichTextItem({required this.task});

  @override
  String get id => task.taskId.toString();
}

extension HexColor on Color {
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
