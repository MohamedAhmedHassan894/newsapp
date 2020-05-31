import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:newsapp/pagemodel.dart';
import 'package:page_view_indicator/page_view_indicator.dart';
import 'package:newsapp/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoarding extends StatefulWidget {
  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {

  List <PageModel> pages ;

  ValueNotifier <int> _pageViewNotifier = ValueNotifier(0);

  void _addPages() {
    pages = List<PageModel>();
    pages.add(PageModel('assets/images/img.jpg', Icons.ac_unit, 'Welcome !',
        '1-making friends is easy as waving your hand back and forth in easy step'));
    pages.add(PageModel('assets/images/img1.jpg', Icons.access_alarm, 'Alarm !',
        '2-making friends is easy as waving your hand back and forth in easy step'));
    pages.add(PageModel('assets/images/img2.jpg', Icons.print, 'Print !',
        '3-making friends is easy as waving your hand back and forth in easy step'));
    pages.add(PageModel('assets/images/img3.jpg', Icons.map, 'Map !',
        '4-making friends is easy as waving your hand back and forth in easy step '));
  }

  @override
  Widget build(BuildContext context) {
    _addPages();
    return Stack(
      children: <Widget>[
        Scaffold(
          body: PageView.builder(
            itemBuilder: (context, index) {
              return Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: ExactAssetImage(pages[index].image),
                          fit: BoxFit.cover
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Transform.translate(
                        child: Icon(
                          pages[index].icon, color: Colors.white, size: 100,),
                        offset: Offset(0, -35),),
                      Text(pages[index].title,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 30,),
                        textAlign: TextAlign.center,),

                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16, right: 16, top: 24),
                        child: Text(pages[index].description,
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ), textAlign: TextAlign.center,),
                      ),
                    ],
                  ),
                ],
              );
            },
            itemCount: pages.length,
            onPageChanged: (index){
              _pageViewNotifier.value=index;
            },
          ),
        ),
        Transform.translate(
            offset: Offset(0, 175),
            child: Align(
              alignment: Alignment.center,
              child: _displayPageIndicator(pages.length),
            )
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 24, left: 16, right: 16),
            child: SizedBox(
              width: double.infinity,
              height: 45,
              child: RaisedButton(
                color: Colors.red,
                child: Text("Get Started", style: TextStyle(
                    color: Colors.white, fontSize: 20, letterSpacing: 1.5),),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute (
                      builder: (context) {
                        return HomeScreen() ;
                      }
                    )
                  );
                },
              ),
            ),
          ),
        ),


      ],
    );
  }

 Widget  _displayPageIndicator(int length) {
    return PageViewIndicator(
      pageIndexNotifier: _pageViewNotifier ,
      length: length,
      normalBuilder: (animationController , index){
        return Circle(size: 8.0 , color:Colors.grey,) ;
      },
      highlightedBuilder: ( animationController, index){
        return ScaleTransition(
          scale : CurvedAnimation (
            parent: animationController,
            curve: Curves.ease ,
          ),
          child: Circle(
            size: 12.0,
            color: Colors.red,
          ),
        );
      },
    );

  }
}
