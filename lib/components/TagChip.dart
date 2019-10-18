import 'package:flutter/material.dart';

class TagChip extends StatefulWidget {
  TagChip({Key key, @required this.label}) : super(key: key);

  final String label;

  _TagChipState createState() => _TagChipState();
}

class _TagChipState extends State<TagChip> {
  bool pressedDown = false;

  void tapDown(TapDownDetails details) {
    setState(() {
      pressedDown = true;
    });
  }

  void tap() {
    setState(() {
      debugPrint('on tap');
      pressedDown = false;
    });
  }

  void tapUp(TapUpDetails details) {
    setState(() {
      pressedDown = false;
    });
  }

  void tapCancel() {
    setState(() {
      pressedDown = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: tapDown,
      onTapUp: tapUp,
      onTapCancel: tapCancel,
      onTap: tap,
      child: Container(
        decoration: BoxDecoration(
            color: pressedDown ? Colors.purple : Colors.grey[850],
            borderRadius: BorderRadius.circular(16.0)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
          child: Text(
            widget.label,
            style: Theme.of(context)
                .textTheme
                .caption
                .copyWith(color: Colors.white, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
