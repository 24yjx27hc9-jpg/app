import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget{
  final String chapterText;
  final String titleText;
  final VoidCallback? onPrevious;
  const CustomAppBar({super.key, required this.titleText, required this.chapterText, this.onPrevious});
  
  Widget _arrowedButton(BuildContext context, {IconData icon = Icons.arrow_back_ios_new_rounded}){
    return Icon(icon, size: 18, color: Colors.white);
  }

  Widget _checkArrow(BuildContext context) {
    if (onPrevious != null){
      return Row(
        spacing: 3,
        children: [
          Center(child: _arrowedButton(context)),
          Text(chapterText, style: Theme.of(context).textTheme.labelMedium)
        ],
      );
    }
    else{
      return Text(chapterText, style: Theme.of(context).textTheme.labelMedium);
    }
  }

  Widget _chapterPill(BuildContext context, String text, VoidCallback? onPressed){
    Widget chapterPill = Container(
        height: 44,
        padding: EdgeInsets.symmetric(horizontal: 22, vertical: 13),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.tertiary,
            borderRadius: BorderRadius.only(topRight: Radius.circular(10), bottomLeft: Radius.circular(10))
        ),
        child: _checkArrow(context)
    );
    if (onPrevious != null){
      return GestureDetector(
        onTap: onPressed,
        child: chapterPill,
      );
    }
    else{
      return chapterPill;
    }
  }

  Widget _titlePill(BuildContext context, String text){
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 22, vertical: 13),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withValues(alpha: 1),
            borderRadius: BorderRadius.circular(10)),
        child: Text(
            titleText, style: Theme.of(context).textTheme.labelMedium, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center)
        );
  }

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    return SizedBox(
      height: topPadding + 54,
      child: Stack(
        children: [
          Positioned.fill(
            child: IgnorePointer(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.lightBlue.withValues(alpha: 0.95),
                      Colors.lightBlue.withValues(alpha: 0.80),
                      Colors.lightBlue.withValues(alpha: 0.70),
                      Colors.lightBlue.withValues(alpha: 0.60),
                      Colors.lightBlue.withValues(alpha: 0.40),
                      Colors.transparent,
                    ],
                    stops: const [
                      0.0,
                      0.20,
                      0.40,
                      0.60,
                      0.80,
                      1
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: topPadding + 8,
              left: 16,
              right: 16,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _chapterPill(context, chapterText, onPrevious),
                Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: _titlePill(context, titleText),
                    )
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}