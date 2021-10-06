import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:js_event_app/constants.dart';
import 'package:js_event_app/models/event_model.dart';

import 'package:js_event_app/services/event_services.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Event> listOfEvents = [];

  void getEvents() async {
    EventService eventService = EventService();
    Future<List<Event>> events = eventService.getEvents();
    events.then((value) {
      setState(() {
        listOfEvents = value;
      });
    });
  }

  @override
  void initState() {
    getEvents();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(listOfEvents);
    //final args = ModalRoute.of(context)!.settings.arguments as Map;
    //User logedInUser = args['logedUser'];
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: size.height * .1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Current location",
                          style: TextStyle(
                              color: Color(0xFF8E8E8E),
                              fontWeight: FontWeight.bold),
                        ),
                        Row(children: const [
                          Icon(
                            Icons.location_on,
                            color: Color(0xffFE6C04),
                          ),
                          Text("Bizerte, Tunis",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                        ]),
                      ],
                    ),
                    Row(
                      children: const [
                        Icon(
                          Icons.bookmark,
                          size: 30.0,
                          color: Color(0xffFE6C04),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        CircleAvatar(
                          backgroundImage: AssetImage("assets/img/profile.jpg"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const TextField(
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  filled: false,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  icon: Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  hintText: 'Search',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(boxShadow: [kDefaultShadow]),
                height: size.height * .5,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: listOfEvents.length <= 5 ? listOfEvents.length : 5,
                  itemBuilder: (BuildContext context, int index) {
                    final event = listOfEvents[index];
                    return GestureDetector(
                      onTap: () => Navigator.of(context)
                          .pushNamed("details", arguments: {"event": event}),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        margin: const EdgeInsets.all(10.0),
                        height: size.height * .5,
                        width: size.width * .6,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              height: size.height * .4,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(event.eventimg),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  "${event.goingMembers} Joined",
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  event.name,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Event For you",
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                      onPressed: () => {print('presed')},
                      child: const Text('see more'),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: size.height * .5,
                child: ListView.builder(
                  itemCount: listOfEvents.length,
                  itemBuilder: (BuildContext context, int index) {
                    final event = listOfEvents[index];
                    return ListTile(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed("details", arguments: {"event": event});
                      },
                      trailing: const Icon(
                        Icons.arrow_right,
                        color: Colors.grey,
                        size: 30,
                      ),
                      leading: Container(
                          width: size.width * .1,
                          height: size.height * .1,
                          child: Image(
                            image: NetworkImage(event.eventimg),
                            fit: BoxFit.fill,
                          )),
                      title: Text(
                        event.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        event.eventdate.toLocal().toString(),
                        style: const TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.w600),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
