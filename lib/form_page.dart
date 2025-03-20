import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final TextEditingController todoController = TextEditingController();
  final todoKey = GlobalKey<FormState>();
  String? selectedDate;
  List<Map<String, dynamic>> daftarTodo = [];

   void addTodo() {
    if (selectedDate == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Please select a date')));
      return;
    }

    if (todoController.text.isNotEmpty) {
      setState(() {
        daftarTodo.add({
          'task': todoController.text,
          'deadline': selectedDate,
          'isDone': false,
        });
        todoController.clear();
        selectedDate = null;
      });
    }
  }

    Future<void> chooseDateTime(BuildContext context) async {
    DateTime tempPickedDate = DateTime.now();

    final pickedDateTime = await showCupertinoModalPopup<DateTime>(
      context: context,
      builder: (_) {
        return Material(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.4,
            color: Colors.white,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Set Task Date & Time',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.close),
                      ),
                    ],
                  ),
                ),

                Divider(height: 1),

                Expanded(
                  child: CupertinoTheme(
                    data: CupertinoThemeData(
                      textTheme: CupertinoTextThemeData(
                        dateTimePickerTextStyle: TextStyle(fontSize: 18),
                      ),
                    ),

                    child: CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.dateAndTime,
                      initialDateTime: DateTime.now(),
                      onDateTimeChanged: (DateTime value) {
                        setState(() {
                          selectedDate = DateFormat(
                            'dd-MM-yyyy HH:mm',
                          ).format(value);
                        });
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16, right: 16, bottom: 33),
                  child: SizedBox(
                    height: 40,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop(tempPickedDate);
                      },
                      child: Text(
                        'Select',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
    if (pickedDateTime != null) {
      setState(() {
        selectedDate = DateFormat('dd-MM-yyyy HH:mm').format(pickedDateTime);
      });
    }
  }
