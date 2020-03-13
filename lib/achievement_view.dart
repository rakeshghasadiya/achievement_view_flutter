import 'package:achievement_view/achievement_widget.dart';
import 'package:flutter/material.dart';

class AchievementView {
  final BuildContext _context;
  final AlignmentGeometry alignment;
  final Duration duration;
  final GestureTapCallback onTab;
  final Function(AchievementState) listener;
  final bool isCircle;
  final Widget icon;
  final AnimationTypeAchievement typeAnimationContent;
  final double borderRadius;
  final Color color;
  final TextStyle textStyleTitle;
  final TextStyle textStyleSubTitle;
  final String title;
  final String subTitle;
   double widthPercent;

  OverlayEntry _overlayEntry;

  AchievementView(
    this._context, {
    this.onTab,
    this.listener,
    this.isCircle = false,
    this.icon = const Icon(
      Icons.insert_emoticon,
      color: Colors.white,
    ),
    this.typeAnimationContent = AnimationTypeAchievement.fadeSlideToUp,
    this.borderRadius = 5.0,
    this.color = Colors.blueGrey,
    this.textStyleTitle,
    this.textStyleSubTitle,
    this.alignment = Alignment.topRight,
    this.duration = const Duration(seconds: 3),
    this.title = "",
    this.subTitle = "",
    this.widthPercent = 40
  });

  OverlayEntry _buildOverlay() {

    return OverlayEntry(builder: (context) {
      if(widthPercent>95){
        widthPercent = 95;
      }else if(widthPercent<=30){
        widthPercent = 30;
      }
      var size = MediaQuery.of(context).size;
      var  width = (size.width*widthPercent)/100;

      return Align(
        alignment: alignment,
        child: AchievementWidget(
          title: title,
          subTitle: subTitle,
          width:width,
          duration: duration,
          listener: listener,
          onTab: onTab,
          isCircle: isCircle,
          textStyleSubTitle: textStyleSubTitle,
          textStyleTitle: textStyleTitle,
          icon: icon,
          typeAnimationContent: typeAnimationContent,
          borderRadius: borderRadius,
          color: color,
          finish: () {
            _hide();
          },
        ),
      );
    });
  }

  void show() {
    if (_overlayEntry == null) {
      _overlayEntry = _buildOverlay();
      Overlay.of(_context).insert(_overlayEntry);
    }
  }

  void _hide() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}
