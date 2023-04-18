import 'package:example/main.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ActivityPage extends StatefulWidget {
  final String activity;
  final Function onActivityCompleted;
  const ActivityPage(
      {Key? key, required this.activity, required this.onActivityCompleted})
      : super(key: key);

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  late String activity;
  DateTime? selectedDate;
  List<File?> images = [null, null, null];

  Future<void> _imageTaker(int index) async {
    final imageOption = ImagePicker();
    final chosenImage =
        await imageOption.pickImage(source: ImageSource.gallery);

    if (chosenImage != null) {
      setState(() {
        images[index] = File(chosenImage.path);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    activity = widget.activity;
  }

  Widget _activityImage(int index) {
    return InkWell(
      onTap: () => _imageTaker(index),
      child: Container(
        width: 200,
        height: 200,
        margin: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(10),
        ),
        child: images[index] == null
            ? Icon(Icons.add_a_photo)
            : Image.file(images[index]!),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Activity of the Day'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue[300],
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.all(20),
                child: Text(
                  'Activity: ${widget.activity}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Pictures

            Text('Pictures: ', style: TextStyle(fontSize: 20)),
            SizedBox(height: 10),

            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _activityImage(0),
                _activityImage(1),
                _activityImage(2),
              ],
            ),
            SizedBox(height: 10),

            // Complete Button

            Column(
              children: [
                TextButton(
                    onPressed: () {
                      widget.onActivityCompleted(widget.activity);
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 100),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.blue[300],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Text(
                            'Complete!',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 24,
                            ),
                          ),
                        ),
                      ),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
