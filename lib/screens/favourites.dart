import 'dart:math';
import 'package:flutter/material.dart';

class Favourites extends StatefulWidget {
  @override
  _FavouritesState createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  List<Color> lifeStyleColors = [
    Colors.red,
    Colors.teal,
    Colors.blue,
    Colors.green,
    Colors.amber,
  ];

  Color _getRandomColor (){
    Random random = Random();
    return lifeStyleColors[random.nextInt(lifeStyleColors.length)];
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder:(context , position){
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              child: Column(children: <Widget>[
                _authorRow(),
                SizedBox(height: 16.0,),
                _newsItemRow(),
              ],),
            ),
          ),
        );
      } ,
      itemCount:20,
    );
  }
  Widget _authorRow(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              decoration: BoxDecoration (
                image: DecorationImage(
                  image: ExactAssetImage('assets/images/place_holder_img.jpg'),
                  fit: BoxFit.cover,
                ),
                shape: BoxShape.circle,
              ),
              width: 50,
              height: 50,
              margin: EdgeInsets.only(right: 16.0,),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Mohamed Hassan',style: TextStyle(color: Colors.grey,),),
                SizedBox(height: 8,),
                Row(children: <Widget>[
                  Text('15 min',style: TextStyle(color: Colors.grey,),),
                  SizedBox(width: 8.0,),
                  Text('Life Style',style: TextStyle(color:_getRandomColor(), ),),
                ],),
              ],),
          ],
        ),
        IconButton(
          icon: Icon(Icons.bookmark_border,size:30,),
          onPressed:(){} ,
          color: Colors.grey,
        ),
      ],
    );
  }
  Widget _newsItemRow(){
    return Row(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: ExactAssetImage('assets/images/place_holder_img.jpg'),fit: BoxFit.cover,),
          ),
          width: 120,
          height: 120,
          margin: EdgeInsets.only(right: 16.0,),
        ),
        Expanded(
          child: Column(
            children: <Widget>[
              Text(
                  'Tech Tent : Old Phones and Safe Social',
                style: TextStyle(fontSize: 16.5 , fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 10.0,),
              Text(
                'We also Talk about The Future of Work as The Robots advance,and we ask whether a refo phone',
                style: TextStyle(color: Colors.grey , fontSize: 14.0,height: 1.50),
              ),
          ],),
        ),
      ],
    );
  }
}
