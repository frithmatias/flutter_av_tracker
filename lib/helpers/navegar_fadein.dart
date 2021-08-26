part of 'helpers.dart';

Route navegarMapaFadeIn(BuildContext context, Widget page) {
  return PageRouteBuilder(
      pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) => page,
      transitionDuration: const Duration(milliseconds: 1000),
      transitionsBuilder: (context, animation, _, child) => FadeTransition(
          child: child,
          opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(parent: animation, curve: Curves.easeOut))));
}
