import 'package:flutter/material.dart';
import 'package:js_event_app/constants.dart';

class TextFieldName extends StatelessWidget {
  const TextFieldName({
    Key? key,
    required this.fieldText,
  }) : super(key: key);

  final String fieldText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          bottom: defaultPadding / 3, top: defaultPadding / 3),
      child: Text(
        fieldText,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          color: Colors.black54,
        ),
      ),
    );
  }
}
