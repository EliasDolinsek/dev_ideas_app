import 'package:flutter/material.dart';

class DevIdeasErrorWidget extends StatelessWidget {

  final String message;

  const DevIdeasErrorWidget({Key key, this.message = "SOMETHING BAD HAPPENDED"}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Icon(
            Icons.error_outline,
            color: Colors.red,
            size: 60.0,
          ),
          SizedBox(
            height: 16.0,
          ),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500
            ),
          )
        ],
      ),
    );
  }
}
