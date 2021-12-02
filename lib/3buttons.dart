
import 'package:finance_app/datEntery.dart';
import 'package:flutter/material.dart';

class MainAction extends StatefulWidget {


  @override
  _MainActionState createState() => _MainActionState();
}

class _MainActionState extends State<MainAction> with SingleTickerProviderStateMixin {


  bool isOpened = false;
  late AnimationController _animationController;
  late Animation<Color?> _buttonColor;
  late Animation<double> _animateIcon;
  late Animation<double> _translateButton;
  Curve _curve = Curves.easeOut;
  double _fabHeight = 56.0;

  @override
  initState() {
    _animationController =
    AnimationController(vsync: this, duration: Duration(milliseconds: 500))
      ..addListener(() {
        setState(() {});
      });
    _animateIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _buttonColor = ColorTween(
      begin: Colors.deepPurpleAccent,
      end: Colors.red,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.00,
        1.00,
        curve: Curves.linear,
      ),
    ));
    _translateButton = Tween<double>(
      begin: _fabHeight,
      end: -14.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.0,
        0.75,
        curve: _curve,
      ),
    ));
    super.initState();
  }



  animate() {
    if (!isOpened) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    isOpened = !isOpened;
  }
  void showEnterData(List<String> subCategories,String category){
    showModalBottomSheet(

        context: context,
        isScrollControlled: true,
        builder: (context)=>SingleChildScrollView(
          //controller:ModalScrollController.of(context),
            child:Container(
                padding:EdgeInsets.symmetric(
                    vertical:15.0,
                    horizontal:30.0,

                ),
                child:formData(subCategories:subCategories, category: category)
            )
        ));
  }
  Widget needs() {
    return Container(
      child: FloatingActionButton(
        backgroundColor: Colors.deepPurpleAccent,
        onPressed:()=>showEnterData(['Housing','Transportation','Food','Utilities','Bill'],'Needs'),
        tooltip: 'Needs',
        child: Icon(Icons.home, color: Theme.of(context).backgroundColor,),
      ),
    );
  }

  Widget miscellaneous() {
    return Container(
      child: FloatingActionButton(
        backgroundColor: Colors.deepPurpleAccent,
        onPressed: ()=> showEnterData(['Shopping','Entertainment','Gifts','Hobbies'], 'Miscellaneous'),
        tooltip: 'miscellaneous',
        child: Icon(Icons.shopping_bag_outlined, color: Theme.of(context).backgroundColor,),
      ),
    );
  }

  Widget emergency() {
    return Container(
      child: FloatingActionButton(
        backgroundColor: Colors.deepPurpleAccent,
        onPressed: ()=> showEnterData(['Emergency','Regular'], 'Emergency'),
        tooltip: 'Emergency',
        child: Icon(Icons.local_hospital, color: Theme.of(context).backgroundColor,),
      ),
    );
  }

  Widget toggle() {
    return Container(
      child: FloatingActionButton(
        backgroundColor: _buttonColor.value,
        onPressed: animate,
        tooltip: 'Toggle',
        child: AnimatedIcon(
          icon: AnimatedIcons.menu_close,
          progress: _animateIcon,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value * 3.0,
            0.0,
          ),
          child: needs(),
        ),
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value * 2.0,
            0.0,
          ),
          child: miscellaneous(),
        ),
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value,
            0.0,
          ),
          child: emergency(),
        ),
        toggle(),
      ],
    );
  }
}

