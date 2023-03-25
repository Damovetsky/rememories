import 'package:flutter/material.dart';

import '../screens/add_place_screen.dart';

class AddNewPlaceButton extends StatelessWidget {
  const AddNewPlaceButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () =>
          Navigator.of(context).pushNamed(AddPlaceScreen.routeName),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.add),
          SizedBox(width: 4),
          Text(
            'Add new place',
            style: TextStyle(fontSize: 20),
          )
        ],
      ),
      style: ButtonStyle(
        shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}
