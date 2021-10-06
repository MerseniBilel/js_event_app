import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:js_event_app/models/event_model.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

FlutterLocalNotificationsPlugin notificationPlugin =
    FlutterLocalNotificationsPlugin();

class Details extends StatefulWidget {
  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  void initState() {
    initializeSetting();
    tz.initializeTimeZones();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    Event event = args['event'];
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: size.height * .4,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(45),
                      bottomRight: Radius.circular(45),
                    ),
                    image: DecorationImage(
                        image: NetworkImage(event.eventimg), fit: BoxFit.cover),
                  ),
                ),
                Positioned(
                  top: 20,
                  left: 20,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                  ),
                ),
                Positioned(
                  right: 20,
                  top: 20,
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.bookmark_outline,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.name,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 25.0,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        event.eventLeader.leaderName +
                            " " +
                            event.eventLeader.leaderName,
                        style: const TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        event.eventdate.toLocal().toString(),
                        style: const TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    event.description,
                    style: const TextStyle(
                        letterSpacing: 1.2,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.black54),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: size.width * .6,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xffFE6C04),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          displayNotification(
                              event.name, "Event will start soon....");
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Join",
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> displayNotification(String title, String body) async {
    notificationPlugin.zonedSchedule(
      0,
      title,
      body,
      tz.TZDateTime.now(tz.local).add(
        const Duration(seconds: 5),
      ),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          "channel id",
          "channel name",
          importance: Importance.max,
          priority: Priority.max,
        ),
      ),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
    );
  }
}

void initializeSetting() async {
  var initializeAndroid = const AndroidInitializationSettings("my_logo");
  var initializeSettings = InitializationSettings(android: initializeAndroid);
  await notificationPlugin.initialize(initializeSettings);
}
