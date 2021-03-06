import "package:flutter/material.dart";

class QuestionText extends StatefulWidget {

  final String _question;
  final int _questionNumber;

  QuestionText(this._question, this._questionNumber);

  @override
  State createState() => new QuestionTextState();
}

class QuestionTextState extends State<QuestionText> with SingleTickerProviderStateMixin {

  Animation<double> _fontSizeAnimation;
  AnimationController _fontSizeAnimationController;

  @override
  void initState() {
    super.initState();
    _fontSizeAnimationController = new AnimationController(
      duration: new Duration(
        milliseconds: 500
      ),
      vsync: this
    );
    _fontSizeAnimation = new CurvedAnimation(
      parent: _fontSizeAnimationController,
      curve: Curves.bounceOut
    );
    _fontSizeAnimation.addListener(() => this.setState(() {})); // to rebuild the text
    _fontSizeAnimationController.forward();
  }

  @override
  void dispose() { // animation page should have this dispose functionality
    _fontSizeAnimationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(QuestionText oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    if(oldWidget._question != widget._question) {
      _fontSizeAnimationController.reset();
      _fontSizeAnimationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Material(
      color: Colors.white,
      child: new Padding(
        padding: new EdgeInsets.symmetric(vertical: 20.0),
        child: new Center(
          child: new Text("${widget._questionNumber.toString()}. ${widget._question}",
            style: new TextStyle(
              color: Colors.blue,
              fontSize: _fontSizeAnimation.value * 15,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
      ),
    );
  }
}