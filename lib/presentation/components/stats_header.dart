import 'package:flutter/material.dart';

import '../styles/texts.dart';

class BuildStatHeader extends StatelessWidget {
  final String headerText;
  final num value;
  const BuildStatHeader({
    Key? key,
    required this.headerText,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          headerText,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17,
              color: Colors.orange.shade300),
        ),
        const SizedBox(
          height: 12,
        ),
        Container(
          padding: const EdgeInsets.only(left: 50),
          child: Text(
            value.toStringAsFixed(2),
            style: body.copyWith(fontSize: 25),
          ),
        ),
        Divider(
          endIndent: MediaQuery.of(context).size.width / 2.5,
        ),
      ],
    );
  }
}
