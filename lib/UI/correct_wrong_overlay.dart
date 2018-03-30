import 'dart:math';
import 'package:flutter/material.dart';

class  CorrectWrongOverlay extends StatefulWidget {

  final bool _isCorrect;
  final VoidCallback _onTap;

  CorrectWrongOverlay(this._isCorrect, this._onTap);

  @override
  State createState() => new CorrectWrongOverlayState();
}

class CorrectWrongOverlayState extends State<CorrectWrongOverlay> with SingleTickerProviderStateMixin {

  Animation<double> _iconAnimation;
  AnimationController _iconAnimationController;

  @override
  void initState() {
    super.initState();
    _iconAnimationController = new AnimationController(
      duration: new Duration(
        seconds: 2
      ),
      vsync: this
    );
    _iconAnimation = new CurvedAnimation(
      parent: _iconAnimationController,
      curve: Curves.elasticIn
    );
    _iconAnimation.addListener(() => this.setState(() {}));
    _iconAnimationController.forward();
  }

  @override
  void dispose() {
    _iconAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Material(
      color: Colors.black54,
      child: new InkWell(
        onTap: () => widget._onTap(),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Container(
              decoration: new BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle
              ),
              child: new Transform.rotate(
                angle: _iconAnimation.value * 2 * PI,
                child: new Icon(widget._isCorrect ? Icons.done : Icons.cancel,
              size: 50.0,
              color: widget._isCorrect ? Colors.green : Colors.red),
              ),
            ),
            new Padding(
              padding: new EdgeInsets.only(bottom: 10.0),
            ),
            new Text(widget._isCorrect ? "Correct!" : "Wrong!",
            style: new TextStyle(
              color: Colors.white,
              fontSize: 30.0
            ),
            )
          ],
        ),
      ),
    );
  }
}