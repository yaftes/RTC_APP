import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:rtc_app/model/objects.dart';

class CreateTaskFormModal extends StatefulWidget {
  final Function(String title, String description, String status,
      List<User> assignedTo) onSubmit;
  final List<User> assignees;

  const CreateTaskFormModal(
      {required this.onSubmit, required this.assignees, Key? key})
      : super(key: key);

  @override
  _CreateTaskFormModalState createState() => _CreateTaskFormModalState();
}

class _CreateTaskFormModalState extends State<CreateTaskFormModal> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String _status = 'N';
  List<User> _selectedAssignees = [];

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.8,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add New Task',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Container(
                width: 300,
                margin: EdgeInsets.only(left: 20),
                child: DropdownButtonFormField<String>(
                  value: _status,
                  decoration: InputDecoration(labelText: 'Status'),
                  borderRadius: BorderRadius.circular(10),
                  dropdownColor: Colors.blue[100],
                  items: ['N', 'P', 'O', 'T', 'C']
                      .map((status) => DropdownMenuItem(
                            value: status,
                            child: Text(status),
                          ))
                      .toList(),
                  iconSize: 42.0,
                  onChanged: (value) {
                    setState(() {
                      _status = value!;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a status';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 20),
              MultiSelectDialogField(
                items: widget.assignees
                    .map((assignee) => MultiSelectItem(assignee, assignee.name))
                    .toList(),
                title: Text("Assigned To"),
                selectedColor: Colors.blue,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  border: Border.all(
                    color: Colors.grey,
                  ),
                ),
                buttonText: Text(
                  "Select Assignees",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
                listType: MultiSelectListType.CHIP,
                onConfirm: (results) {
                  _selectedAssignees = results.cast<User>();
                },
                validator: (value) {
                  if (_selectedAssignees.isEmpty) {
                    return 'Please select at least one assignee';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    widget.onSubmit(
                      _titleController.text,
                      _descriptionController.text,
                      _status,
                      _selectedAssignees,
                    );
                    Navigator.of(context).pop();
                  }
                },
                child: Text('Add Task'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
