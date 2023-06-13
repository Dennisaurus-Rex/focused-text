import 'package:flutter/material.dart';
import 'package:focused_text/focused_text_widget.dart';

void main() {
  // debugPaintSizeEnabled = true;
  runApp(const MainApp());
}

const String _text = """
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

There is something between us
Between me and you.
There is something between us
I see right through
I see right through.

I had a version of home
And just like that.
I was left to live without it
Left to live without it.
I had a person I loved
And just like that.
I was left to live without him
Left to live without him.

Waiting for this storm to pass.
Waiting on this side of the glass.
But I see my reflection in you
See your reflection in me.
How can it be?.
How can it be?.

There is something between us
Between me and you.
There is something between us
I see right through
I see right through.

There is something between us
Between me and you.
There is something between us
I see right through
I see right through.

I had a vision of you
And just like that.
I was left to live without it
Left to live without it.
Waiting on this side of the glass.
""";

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: SizedBox(
            width: 300,
            height: 300,
            child: FocusedTextWidget.fromString(
              text: _text,
              resizeFactor: 0.4,
            ),
          ),
        ),
      ),
    );
  }
}
