import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmptyView extends StatelessWidget {
  final String message;
  final Widget? callToAction;
  final Widget image;

  const EmptyView(
      {super.key,
      required this.message,
      this.callToAction,
      required this.image});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        image,
        Padding(
          padding:
              const EdgeInsets.only(left: 48, right: 48, top: 24, bottom: 16),
          child: Text(
            message,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(height: 1.3,fontSize: 20),
            textAlign: TextAlign.center,
          ),
        ),
        if (callToAction != null) callToAction!
      ],
    );
  }
}
