import 'package:flutter/material.dart';

class MPLogo extends StatelessWidget {
  const MPLogo({
    Key key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Padding(
        padding: const EdgeInsets.only(bottom: 40 / 3.5),
        child: Text(
          'My Place',
          style: TextStyle(
            fontSize: 37,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Text(
            'admin',
            style: TextStyle(
              fontSize: 40 / 2.5,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).accentColor,
            ),
          ),
        ),
    ]);
  }
}
