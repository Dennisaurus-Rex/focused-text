# Focused Text

## Description

A text widget that focuses on a specific paragraph or phrase.
Inspired by the lyrics view in Apple Music.

## Usage

### `FocusedTextWidget.fromString`

```dart
// Example
FocusedTextWidget.fromString(
  text: _text,
  autoPlay: true,
  autoPlayDuration: const Duration(seconds: 3),
)

// Using the fromString factory
factory FocusedTextWidget.fromString({
  Key? key,
  required String text,
  String separator = '.',
  int maxParagraphLines = 3,
  bool showSeparator = false,
  bool autoPlay = false,
  double resizeFactor = 0.4,
  Duration autoPlayDuration = const Duration(seconds: 5),
  TextStyle? textStyle,
})
```

### `FocusedTextWidget.fromList`

```dart
// Example
FocusedTextWidget.fromList(
  textList: _textList,
),

// Using the fromList factory
factory FocusedTextWidget.fromList({
  Key? key,
  required List<String> textList,
  int maxParagraphLines = 3,
  bool autoPlay = false,
  double resizeFactor = 0.4,
  Duration autoPlayDuration = const Duration(seconds: 5),
  TextStyle? textStyle,
})
```

## Sneak Peek

|![Mouse Pointer](https://github.com/Dennisaurus-Rex/focused-text/raw/main/gif/focused_text_mouse.gif)|![Auto Play](https://github.com/Dennisaurus-Rex/focused-text/raw/main/gif/focused_text_auto.gif)|
|:---:|:---:|
