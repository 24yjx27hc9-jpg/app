import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget{
  final String chapterText;
  final String titleText;
  final VoidCallback? onPrevious;
  const CustomAppBar({super.key, required this.titleText, required this.chapterText, this.onPrevious});
  
  Widget _arrowedButton(BuildContext context, {required VoidCallback? onPressed, required IconData icon}){
    return IconButton(
        icon: Icon(icon, size: 18, color: Colors.white),
        onPressed: onPressed);
  }

  Widget _checkArrow(BuildContext context) {
    if (onPrevious != null){
      return Row(
        spacing: 3,
        children: [
          Center(child: _arrowedButton(context, onPressed: onPrevious, icon: Icons.arrow_back_ios_new_outlined)),
          Text(chapterText, style: Theme.of(context).textTheme.labelMedium)
        ],
      );
    }
    else{
      return Text(chapterText, style: Theme.of(context).textTheme.labelMedium);
    }
  }

  Widget _chapterPill(BuildContext context, String text){
    return Container(
      height: 44,
      padding: EdgeInsets.symmetric(horizontal: 22, vertical: 13),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.tertiary,
        borderRadius: BorderRadius.only(topRight: Radius.circular(10), bottomLeft: Radius.circular(10))
      ),
      child: _checkArrow(context)
    );
  }

  Widget _titlePill(BuildContext context, String text){
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 22, vertical: 13),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(10)),
        child: Text(
            titleText, style: Theme.of(context).textTheme.labelMedium)
        );
  }

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    return Stack(
      children: [
        Positioned(
          top: topPadding + 60,
          height: 30,
          left: 0,
          right: 0,
          child: IgnorePointer(
            child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withValues(alpha: 0.15),
                      Colors.transparent
                    ]
                  )
                )
            ),
          )
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
              _chapterPill(context, chapterText),
              _titlePill(context, titleText)
            ],
          ),
        ),
      ],
    );
  }
}