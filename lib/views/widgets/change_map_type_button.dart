import 'package:flutter/material.dart';

class ChangeMapTypeButton extends StatelessWidget {
  const ChangeMapTypeButton({this.changeMapType});
  final Function changeMapType;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Align(
        alignment: Alignment.topRight,
        child: FloatingActionButton(
          onPressed: changeMapType,
          materialTapTargetSize: MaterialTapTargetSize.padded,
          backgroundColor: Colors.black,
          child: Icon(Icons.map),
        ),
      ),
    );
  }
}
