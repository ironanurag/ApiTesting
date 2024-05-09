import 'package:diff_match_patch/diff_match_patch.dart';
import 'package:flutter/material.dart';

import 'enum.dart';

class PrettyDiffText extends StatelessWidget {
  final String oldText;

  final String newText;

   final TextStyle defaultTextStyle;

  final TextStyle addedTextStyle;

  final TextStyle deletedTextStyle;

  final DiffCleanupType diffCleanupType;


  final double diffTimeout;


  final int diffEditCost;


  final TextAlign textAlign;
  final TextDirection? textDirection;
  final bool softWrap;
  final TextOverflow overflow;
  final double textScaleFactor;
  final int? maxLines;
  final Locale? locale;
  final StrutStyle? strutStyle;
  final TextWidthBasis textWidthBasis;
  final TextHeightBehavior? textHeightBehavior;

  const PrettyDiffText({
    Key? key,
    required this.oldText,
    required this.newText,
    this.defaultTextStyle = const TextStyle(color: Colors.black),
    this.addedTextStyle = const TextStyle(backgroundColor: Color.fromARGB(255, 139, 197, 139)),
    this.deletedTextStyle = const TextStyle(backgroundColor: Color.fromARGB(255, 255, 129, 129), decoration: TextDecoration.lineThrough),
    this.diffTimeout = 1.0,
    this.diffCleanupType = DiffCleanupType.SEMANTIC,
    this.diffEditCost = 4,
    this.textAlign = TextAlign.start,
    this.textDirection,
    this.softWrap = true,
    this.overflow = TextOverflow.clip,
    this.textScaleFactor = 1.0,
    this.maxLines,
    this.locale,
    this.strutStyle,
    this.textWidthBasis = TextWidthBasis.parent,
    this.textHeightBehavior,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DiffMatchPatch dmp = DiffMatchPatch();
    dmp.diffTimeout = diffTimeout;
    dmp.diffEditCost = diffEditCost;
    List<Diff> diffs = dmp.diff(oldText, newText);

    cleanupDiffs(dmp, diffs);

    final textSpans = List<TextSpan>.empty(growable: true);

    for (var diff in diffs) {
      TextStyle? textStyle = getTextStyleByDiffOperation(diff);
      textSpans.add(TextSpan(text: diff.text, style: textStyle));
    }

    return RichText(
      text: TextSpan(
        text: '',
        style: defaultTextStyle,
        children: textSpans,
      ),
      textAlign: textAlign,
      textDirection: textDirection,
      softWrap: softWrap,
      overflow: overflow,
      maxLines: maxLines,
      textScaler: TextScaler.linear(textScaleFactor),
      locale: locale,
      strutStyle: strutStyle,
      textWidthBasis: textWidthBasis,
      textHeightBehavior: textHeightBehavior,
    );
  }

  TextStyle getTextStyleByDiffOperation(Diff diff) {
    switch (diff.operation) {
      case DIFF_INSERT:
        return addedTextStyle;

      case DIFF_DELETE:
        return deletedTextStyle;

      case DIFF_EQUAL:
        return defaultTextStyle;

      default:
        throw "Unknown diff operation. Diff operation should be one of: [DIFF_INSERT], [DIFF_DELETE] or [DIFF_EQUAL].";
    }
  }

  void cleanupDiffs(DiffMatchPatch dmp, List<Diff> diffs) {
    switch (diffCleanupType) {
      case DiffCleanupType.SEMANTIC:
        dmp.diffCleanupSemantic(diffs);
        break;
      case DiffCleanupType.EFFICIENCY:
        dmp.diffCleanupEfficiency(diffs);
        break;
      case DiffCleanupType.NONE:
      // No clean up, do nothing.
        break;
      default:
        throw "Unknown DiffCleanupType. DiffCleanupType should be one of: [SEMANTIC], [EFFICIENCY] or [NONE].";
    }
  }
}