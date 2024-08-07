import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'student.dart';

class AddEditStudentPage extends StatefulWidget {
  final Student? student;
  final Function(Student) addStudent;
  final Function(Student) updateStudent;

  const AddEditStudentPage({
    super.key,
    this.student,
    required this.addStudent,
    required this.updateStudent,
  });

  @override
  AddEditStudentPageState createState() => AddEditStudentPageState();
}

class AddEditStudentPageState extends State<AddEditStudentPage> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late int _age;
  late String _studentCourse;
  File? _profilePic;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    if (widget.student != null) {
      _name = widget.student!.name;
      _age = widget.student!.age;
      _studentCourse = widget.student!.studentCourse;
      _profilePic = File(widget.student!.profilePic);
    } else {
      _name = '';
      _age = 0;
      _studentCourse = '';
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profilePic = File(pickedFile.path);
      });
    }
  }

  void _saveStudent() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (_profilePic != null) {
        final newStudent = Student(
          id: widget.student?.id,
          name: _name,
          age: _age,
          studentCourse: _studentCourse,
          profilePic: _profilePic!.path,
        );
        if (widget.student == null) {
          widget.addStudent(newStudent);
        } else {
          widget.updateStudent(newStudent);
        }
        Navigator.pop(context, true); // Return true to indicate success
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select a profile picture.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.student == null ? 'Add Student' : 'Edit Student'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 80,
                  backgroundImage:
                      _profilePic == null ? null : FileImage(_profilePic!),
                  child: _profilePic == null
                      ? const Icon(Icons.add_a_photo,
                          size: 50, color: Colors.grey)
                      : null,
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                initialValue: _name,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _name = value!;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                initialValue: _age.toString(),
                decoration: const InputDecoration(
                  labelText: 'Age',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an age';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
                onSaved: (value) {
                  _age = int.parse(value!);
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                initialValue: _studentCourse,
                decoration: const InputDecoration(
                  labelText: 'Course',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a Course';
                  }
                  return null;
                },
                onSaved: (value) {
                  _studentCourse = value!;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveStudent,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: const TextStyle(fontSize: 16),
                ),
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
