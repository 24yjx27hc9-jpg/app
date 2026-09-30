import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget{
  final String chapterText;
  final String titleText;
  const CustomAppBar({super.key, required this.titleText, required this.chapterText});
  
  Widget _arrowedButton(BuildContext context, {IconData icon = Icons.arrow_back_ios_new_rounded}){
    return Icon(icon, size: 18, color: Colors.white);
  }

  Widget _checkArrow(BuildContext context) {
    String? page = ModalRoute.of(context)?.settings.name;
    switch(page){
      case '/':
      case '/notes':
      case '/settings':
        return Text(chapterText, style: Theme.of(context).textTheme.titleSmall, textAlign: TextAlign.center);
      default:
        return Row(
          spacing: 3,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _arrowedButton(context),
            Text(chapterText, style: Theme.of(context).textTheme.titleSmall)
          ],
        );
    }
  }

  Widget _chapterPill(BuildContext context, String text){
    String? page = ModalRoute.of(context)?.settings.name;
    Widget chapterPill = Container(
        height: 44,
        padding: EdgeInsets.symmetric(horizontal: 22, vertical: 13),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.tertiary,
            borderRadius: BorderRadius.only(topRight: Radius.circular(10), bottomLeft: Radius.circular(10))
        ),
        child: _checkArrow(context)
    );
    switch(page){
      case '/':
      case '/notes':
      case '/settings':
        return chapterPill;
      default:
        return GestureDetector(
          onTap: () => Navigator.pop(context),
          child: chapterPill,
        );
    }
  }

  Widget _titlePill(BuildContext context, String text){
    return Container(
      height: 44,
        padding: EdgeInsets.symmetric(horizontal: 22, vertical: 13),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withValues(alpha: 1),
            borderRadius: BorderRadius.circular(10)),
        child: Text(
            titleText, style: Theme.of(context).textTheme.titleSmall, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center)
        );
  }

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    return SizedBox(
      height: topPadding + 74,
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
                      Colors.lightBlue.withValues(alpha: 1.00),
                      Colors.lightBlue.withValues(alpha: 0.90),
                      Colors.lightBlue.withValues(alpha: 0.70),
                      Colors.lightBlue.withValues(alpha: 0.50),
                      Colors.lightBlue.withValues(alpha: 0),
                    ],
                    stops: const [
                      0.0,
                      0.20,
                      0.40,
                      0.70,
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
                _chapterPill(context, chapterText),
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