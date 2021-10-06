import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:js_event_app/constants.dart';
import 'package:js_event_app/models/event_model.dart';

abstract class EventRepo {
  Future<void> getEvents();
}

class EventService extends EventRepo {
  // get all events
  Future<List<Event>> getEvents() async {
    const String eventUrl = baseUrl + "/api/events";
    Uri uri = Uri.parse(eventUrl);
    Response response = await http.get(uri);

    if (response.statusCode != 200) {
      print("no response");
      return [];
    }
    List<Event> eventList = eventFromJson(response.body);
    return eventList;
  }
}
