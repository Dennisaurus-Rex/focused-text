import 'package:flutter/material.dart';
import 'package:focused_text/src/focused_text_widget.dart';

/// Demonstating using [FocusedTextWidget] from a [String].
/// The [String] is split into a list of [String]s using the [separator].
/// Where the [separator] = `.`.
class FocusedTextFromText extends StatelessWidget {
  /// Demo text.
  final String _text = """
    I had a vision of you
    And just like that.
    I was left to live without it
    Left to live without it.
    I found a version of love
    And just like that.
    I was left to live without it
    Left to live without it.

    Waiting for this storm to pass.
    Waiting on this side of the glass.
    But I see my reflection in you
    See your reflection in me.
    How could it be?.
    How could it be?.
    """;

  /// Creates a [FocusedTextWidget] from a [String].
  const FocusedTextFromText({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: SizedBox(
            width: 300,
            height: 300,
            child: FocusedTextWidget.fromString(
              text: _text,
              resizeFactor: 0.4,
              autoPlay: true,
              autoPlayDuration: const Duration(seconds: 3),
            ),
          ),
        ),
      );
}
