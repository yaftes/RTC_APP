import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:rtc_app/model/objects.dart';

class CreateTeamFormModal extends StatefulWidget {
  final Function(String name, List<User> selectedMembers) onSubmit;
  final List<User> members;

  const CreateTeamFormModal(
      {required this.onSubmit, required this.members, Key? key})
      : super(key: key);

  @override
  _CreateTeamFormModalState createState() => _CreateTeamFormModalState();
}

class _CreateTeamFormModalState extends State<CreateTeamFormModal> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  List<User> _selectedMembers = [];

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
              const Text(
                'Add New Team',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Team name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a Team name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 40),
              MultiSelectDialogField(
                items: widget.members
                    .map((user) => MultiSelectItem(user, user.name))
                    .toList(),
                title: Text("Add members"),
                searchable: true,
                selectedColor: Colors.blue,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  border: Border.all(
                    color: Colors.grey,
                  ),
                ),
                buttonText: Text(
                  "Select members",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
                listType: MultiSelectListType.CHIP,
                onConfirm: (results) {
                  _selectedMembers = results.cast<User>();
                },
                validator: (value) {
                  if (_selectedMembers.isEmpty) {
                    return 'Please select at least one user';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    widget.onSubmit(
                      _nameController.text,
                      _selectedMembers,
                    );
                    Navigator.of(context).pop();
                  }
                },
                child: Text('Add Team'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
