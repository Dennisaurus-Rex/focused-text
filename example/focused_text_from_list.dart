import 'package:flutter/material.dart';
import 'package:focused_text/src/focused_text_widget.dart';

/// Demonstating using [FocusedTextWidget] from a [List].
class FocusedTextFromList extends StatelessWidget {
  /// Demo text.
  final List<String> _textList = const [
    """I had a vision of you
    And just like that.""",
    """I was left to live without it
    Left to live without it.""",
    """I found a version of love
    And just like that.""",
    """I was left to live without it
    Left to live without it.""",
    """Waiting for this storm to pass.
    Waiting on this side of the glass.""",
    """But I see my reflection in you
    See your reflection in me.""",
    "How could it be?.",
    "How could it be?.",
  ];

  /// Creates a [FocusedTextWidget] from a [List].
  const FocusedTextFromList({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: SizedBox(
            width: 300,
            height: 300,
            child: FocusedTextWidget.fromList(
              textList: _textList,
            ),
          ),
        ),
      );
}
