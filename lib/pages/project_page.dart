import 'dart:async';

import 'package:rtc_app/components/co_createProjectForm.dart';
import 'package:flutter/material.dart';
import 'package:rtc_app/components/co_updateProjectForm.dart';
import 'package:rtc_app/pages/appflowly.dart';
// import 'package:rtc_app/pages/project_detail_page.dart';
import 'package:rtc_app/services/projectService.dart';
import 'package:rtc_app/services/userService.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ProjectPage extends StatefulWidget {
  ProjectPage({super.key});
  @override
  _ProjectPageState createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  Future<void> _onRefresh() async {
    setState(() {});
    await getUserFromPrefs(context);
  }

  void doNothing(BuildContext context) {
    print('nothing');
  }

  @override
  Widget build(BuildContext context) {
    _onRefresh();
    return Scaffold(
        appBar: AppBar(
          title: Text('Projects'),
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
                      return FractionallySizedBox(
                        heightFactor: 0.8,
                        child: CreateProjectForm(
                          onCreate: () => _onRefresh(),
                        ),
                      );
                    });
              },
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        body: RefreshIndicator(
          key: refreshIndicatorKey,
          onRefresh: _onRefresh,
          child: FutureBuilder(
            future: getProjects(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return ListView.builder(
                  key: ValueKey<DateTime>(DateTime.now()),
                  itemCount: projects.length,
                  itemBuilder: (context, index) {
                    return (user[0].userId ==
                            projects[projects.length - index - 1].createdBy)
                        ? Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 4,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Slidable(
                                key: const ValueKey(0),
                                startActionPane: ActionPane(
                                  motion: const ScrollMotion(),
                                  children: [
                                    SlidableAction(
                                      onPressed: (BuildContext context) async {
                                        print(
                                            "delete ${projects[projects.length - index - 1].projectId}");
                                        final confirm = await showDialog<bool>(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: const Text("Confirm"),
                                              content: const Text(
                                                  "Are you sure you want to delete this project?"),
                                              actions: [
                                                TextButton(
                                                  child: const Text("Cancel"),
                                                  onPressed: () =>
                                                      Navigator.of(context)
                                                          .pop(false),
                                                ),
                                                TextButton(
                                                  child: const Text("Delete"),
                                                  onPressed: () =>
                                                      Navigator.of(context)
                                                          .pop(true),
                                                ),
                                              ],
                                            );
                                          },
                                        );

                                        if (confirm ?? false) {
                                          await deleteProject(projects[
                                                  projects.length - index - 1]
                                              .projectId);
                                          setState(() {});
                                        }
                                      },
                                      backgroundColor: Color(0xFFFE4A49),
                                      foregroundColor: Colors.white,
                                      icon: Icons.delete,
                                      label: 'Delete',
                                    ),
                                    SlidableAction(
                                      flex: 2,
                                      onPressed: (context) {
                                        showModalBottomSheet(
                                            elevation: 10,
                                            context: context,
                                            isScrollControlled: true,
                                            builder: (context) {
                                              return FractionallySizedBox(
                                                heightFactor: 0.8,
                                                child: UpdateProjectForm(
                                                    context: context,
                                                    onUpdate: () {},
                                                    project: projects[
                                                        projects.length -
                                                            index -
                                                            1]),
                                              );
                                            });
                                      },
                                      backgroundColor: Color(0xFF7BC043),
                                      foregroundColor: Colors.white,
                                      icon: Icons.update_rounded,
                                      label: 'Update',
                                    ),
                                  ],
                                ),
                                child: ListTile(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => TaskBoard(
                                            project: projects[
                                                projects.length - index - 1]),
                                      ),
                                    );
                                  },
                                  title: Text(
                                      projects[projects.length - index - 1]
                                          .title),
                                  subtitle: Text(
                                      "${projects[projects.length - index - 1].description}  ccreated_by ${projects[projects.length - index - 1].createdBy}  id = ${projects[projects.length - index - 1].projectId}"),
                                ),
                              ),
                            ),
                          )
                        : Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 4,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ListTile(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => TaskBoard(
                                          project: projects[
                                              projects.length - index - 1]),
                                    ),
                                  );
                                },
                                title: Text(
                                    projects[projects.length - index - 1]
                                        .title),
                                subtitle: Text(
                                    "${projects[projects.length - index - 1].description} created_by ${projects[projects.length - index - 1].createdBy}"),
                              ),
                            ),
                          );
                  },
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ));
  }
}
