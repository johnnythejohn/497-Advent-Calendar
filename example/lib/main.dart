import 'package:example/activity_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_week/flutter_calendar_week.dart';
import 'package:intl/intl.dart';
import 'login_page.dart';
import 'activity_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Ann Arbor Advent',
        home: LoginPage(),
      );
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

const List<String> Activities = [
  'Build a Snowman in the Diag!',
  'Spin the Cube!',
  'Explore the Nichols Arboretum!',
  'Visit the Law Library',
  'Visit the Museum of Natural History',
  'Have a sandwich at Zingermans',
  'Visit the UMMA!'
];

class _HomePageState extends State<HomePage> {
  final CalendarWeekController _controller = CalendarWeekController();
  DateTime? selectedDate;
  Map<String, String> completedActivities = {};

  void updateCompletedActivities(String activity) {
    setState(() {
      completedActivities[activity] = 'Completed!';
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _controller.jumpToDate(DateTime.now());
            setState(() {});
          },
          child: Icon(Icons.today),
        ),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.blue,
          title: Text('Ann Arbor Advent'),
        ),
        body: Column(children: [
          Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    spreadRadius: 1)
              ]),
              child: CalendarWeek(
                controller: _controller,
                height: 100,
                showMonth: true,
                minDate: DateTime.now().add(
                  Duration(days: -365),
                ),
                maxDate: DateTime.now().add(
                  Duration(days: 365),
                ),
                onDatePressed: (DateTime datetime) {
                  // Do something
                  setState(() {
                    selectedDate = datetime;
                  });
                },
                onDateLongPressed: (DateTime datetime) {
                  // Do something
                },
                onWeekChanged: () {
                  // Do something
                },
                monthViewBuilder: (DateTime time) => Align(
                  alignment: FractionalOffset.center,
                  child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      child: Text(
                        DateFormat.yMMMM().format(time),
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.w600),
                      )),
                ),
                decorations: [
                  DecorationItem(
                      decorationAlignment: FractionalOffset.bottomRight,
                      date: DateTime.now(),
                      decoration: Icon(
                        Icons.today,
                        color: Colors.blue,
                      )),
                  DecorationItem(
                      date: DateTime.now().add(Duration(days: 3)),
                      decoration: Text(
                        'Holiday',
                        style: TextStyle(
                          color: Colors.brown,
                          fontWeight: FontWeight.w600,
                        ),
                      )),
                ],
              )),
          Expanded(
            child: Center(
                child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ActivityPage(
                      activity: Activities[_controller.selectedDate.day % 7],
                      onActivityCompleted: updateCompletedActivities,
                    ),
                  ),
                );
              },
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text:
                          '${_controller.selectedDate.day}/${_controller.selectedDate.month}/${_controller.selectedDate.year}' +
                              "\n\n" +
                              '${Activities[_controller.selectedDate.day % 7]}' +
                              "\n\n",
                      style: TextStyle(fontSize: 30, color: Colors.black),
                    ),
                    TextSpan(
                      text:
                          '${completedActivities[Activities[_controller.selectedDate.day % 7]] ?? ""}',
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
            )),
          )
        ]),
      );
}
