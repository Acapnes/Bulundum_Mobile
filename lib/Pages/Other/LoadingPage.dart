import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class mainLoadingPage extends StatefulWidget {
  @override
  _mainLoadingPageState createState() => _mainLoadingPageState();
}

class _mainLoadingPageState extends State<mainLoadingPage> with TickerProviderStateMixin {
  PageController pageController = PageController(initialPage: 0);
  AnimationController _controller;
  bool animRunn = false;

  @override
  void initState() {
    if (animRunn == false) {
      _controller = AnimationController(
        duration: const Duration(seconds: 1),
        vsync: this,
      )..forward();
      animRunn = false;
    }
    //getData();
  }

  @override
  dispose() {
    _controller.dispose(); // you need this
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Animation<RelativeRect> _animation = RelativeRectTween(
      begin: RelativeRect.fromLTRB(0, 0, 0, MediaQuery.of(context).size.height),
      end: RelativeRect.fromLTRB(
          0, 0, 0, MediaQuery.of(context).size.height / 3),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    Animation<RelativeRect> _animation2 = RelativeRectTween(
      begin:
          RelativeRect.fromLTRB(0, 0, 0, -MediaQuery.of(context).size.height),
      end: RelativeRect.fromLTRB(
          0, 0, 0, -MediaQuery.of(context).size.height / 4),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
        child: Stack(
          children: <Widget>[
            PositionedTransition(
              rect: _animation,
              child: FadeTransition(
                opacity: _controller,
                child: Container(
                  margin: EdgeInsets.only(top: 200),
                  child: Image(
                    image: AssetImage("assets/lost_item.png"),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
