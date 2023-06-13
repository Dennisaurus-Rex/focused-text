import 'dart:async';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';

/// A widget that displays the current text paragraph in a focused manner.
class FocusedTextWidget extends StatefulWidget {
  const FocusedTextWidget._({
    Key? key,
    required this.textList,
    this.maxParagraphLines = 3,
    this.autoPlay = false,
    this.resizeFactor = 0.3,
    this.autoPlayDuration = const Duration(seconds: 5),
    this.textStyle,
  }) : super(key: key);

  /// Creates a [FocusedTextWidget] from a list of [String]s.
  factory FocusedTextWidget.fromList({
    Key? key,
    required List<String> textList,
    int maxParagraphLines = 3,
    bool autoPlay = false,
    double resizeFactor = 0.4,
    Duration autoPlayDuration = const Duration(seconds: 5),
    TextStyle? textStyle,
  }) =>
      FocusedTextWidget._(
        key: key,
        textList: textList,
        maxParagraphLines: maxParagraphLines,
        autoPlay: autoPlay,
        resizeFactor: resizeFactor,
        autoPlayDuration: autoPlayDuration,
        textStyle: textStyle,
      );

  /// Creates a [FocusedTextWidget] from a [String].
  ///
  /// The [String] is split into a list of [String]s using the [separator].
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
  }) =>
      FocusedTextWidget._(
        key: key,
        textList: text.seperatedList(separator, showSeparator),
        maxParagraphLines: maxParagraphLines,
        autoPlay: autoPlay,
        resizeFactor: resizeFactor,
        autoPlayDuration: autoPlayDuration,
        textStyle: textStyle,
      );

  /// The list of [String]s to display.
  final List<String> textList;

  /// The maximum number of lines to display in a paragraph.
  /// The default value is 3.
  final int maxParagraphLines;

  /// Should the focused text be auto scrolled.
  /// Combine with [autoPlayDuration] to control the auto scroll speed.
  /// The default value is false.
  final bool autoPlay;

  /// The duration between each auto scroll.
  /// Only used if [autoPlay] is true.
  /// The default value is 5 seconds.
  final Duration autoPlayDuration;

  /// Text style for the focused text.
  /// If null, the default text style is used.
  final TextStyle? textStyle;

  /// The resize factor for the unfocused text.
  /// The default value is 0.4.
  /// Clamped value between 0.2 and 0.8.
  final double resizeFactor;

  @override
  State<FocusedTextWidget> createState() => _FocusedTextWidgetState();
}

class _FocusedTextWidgetState extends State<FocusedTextWidget> {
  late final PageController _controller;
  int _currentPage = 0;
  double _currentOffset = 0;
  final int _rowDimensionDivider = 3;

  Timer? _autoPlayTimer;

  @override
  initState() {
    super.initState();
    _controller = PageController(viewportFraction: 1 / 3);
    _controller.addListener(_scrollListener);
    _autoScrollIfNeeded();
  }

  @override
  void dispose() {
    _autoPlayTimer?.cancel();
    _autoPlayTimer = null;
    _controller.removeListener(_scrollListener);
    _controller.dispose();
    super.dispose();
  }

  void _scrollListener() {
    _currentOffset = _controller.offset;
    setState(() {});
  }

  double _animationFromControllerOffset(int index) {
    final offset = _currentOffset;
    final viewport = _controller.position.viewportDimension;
    final pageHeight = viewport / _rowDimensionDivider;
    final pageOffset = index * pageHeight;
    final pageOffsetDiff = offset - pageOffset;
    final pageOffsetDiffAbs = pageOffsetDiff.abs();
    final pageOffsetDiffAbsClamped = pageOffsetDiffAbs.clamp(0, pageHeight);
    final animation = 1 - (pageOffsetDiffAbsClamped / pageHeight);
    return max(animation, widget.resizeFactor);
  }

  void _setCurrentPage(int page) {
    _currentPage = page;
    setState(() {});
  }

  void _autoScrollIfNeeded() {
    if (!widget.autoPlay) return;

    _autoPlayTimer = Timer.periodic(
      widget.autoPlayDuration,
      (timer) {
        if (_currentPage == widget.textList.length - 1) {
          _controller.animateToPage(
            0,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOut,
          );
        } else {
          _controller.nextPage(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOut,
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: const ScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.touch,
          PointerDeviceKind.mouse,
          PointerDeviceKind.trackpad,
          PointerDeviceKind.stylus,
        },
      ),
      child: PageView.custom(
        controller: _controller,
        scrollDirection: Axis.vertical,
        onPageChanged: _setCurrentPage,
        childrenDelegate: SliverChildBuilderDelegate(
          (context, index) {
            final text = widget.textList.elementAt(index);
            final animation = _animationFromControllerOffset(index);
            return Transform.scale(
              scale: animation,
              child: Opacity(
                opacity: animation,
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    text,
                    maxLines: widget.maxParagraphLines,
                  ),
                ),
              ),
            );
          },
          childCount: widget.textList.length,
        ),
      ),
    );
  }
}

extension _SeperatedList on String {
  List<String> seperatedList(String separator, bool showSeparator) =>
      split(separator)
          .map(
            (e) => _formattedString(e, showSeparator, separator),
          )
          .toList();

  static String _formattedString(
      String rawString, bool showSeparator, String separator) {
    String processedString = rawString;
    if (rawString.startsWith('\n')) {
      processedString = rawString.replaceFirst('\n', '');
      return _formattedString(
        processedString,
        showSeparator,
        separator,
      );
    }
    processedString = rawString.trim();
    if (!showSeparator) {
      processedString = rawString.replaceAll(separator, '');
    }
    return processedString;
  }
}
