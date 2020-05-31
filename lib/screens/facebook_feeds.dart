import 'package:flutter/material.dart';
import 'package:newsapp/shared_ui/navigation_drawer.dart';

class FacebookFeeds extends StatefulWidget {
  @override
  _FacebookFeedsState createState() => _FacebookFeedsState();
}

class _FacebookFeedsState extends State<FacebookFeeds> {

  TextStyle _hashTagStyle = TextStyle(
    color: Colors.orange,
  );

  List<int> buttonColor =[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    buttonColor=[0,2,7];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Facebook Feeds'),
        centerTitle: false,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search),
              iconSize: 30.0,
              color: Colors.white60,
              onPressed: () {}),
        ],
      ),
      drawer: NavigationDrawer(),
      body: ListView.builder(
        padding: EdgeInsets.all(8.0),
        itemBuilder: (context, position) {
          return Padding(
            padding: const EdgeInsets.only(bottom:8.0),
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _drawHeader(position),
                  _drawTitle(),
                  _drawHashTags(),
                  _drawBody(),
                  _drawFooter(),

                ],
              ),
            ),
          );
        },
        itemCount: 20,
      ),
    );
  }
  Widget _drawHeader(int position) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CircleAvatar(
                backgroundColor: Colors.purple,
                radius: 24,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Christina Meyers ',
                  style: TextStyle(
                      color: Colors.grey.shade900,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  width: 8.0,
                ),
                SizedBox(
                  height: 8.0,
                ),
                Text(
                  'Fri, 21 May 2017 * 14.30',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],),
        Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right:7.0),
              child: IconButton(icon:Icon(Icons.favorite,
                color:((buttonColor.contains(position)? Colors.red.shade300 : Colors.grey.shade400)),),
                  onPressed:(){
                if(buttonColor.contains(position)){
                  buttonColor.remove(position);
                }
                else{
                  buttonColor.add(position);
                }
                setState(() {

                });
                  }),
            ),
            Transform.translate(
                offset: Offset(-12,0),
                child: Text("25",style: TextStyle(color: Colors.grey.shade400,fontSize: 16.0,),))
          ],),
      ],
    );
  }

  Widget _drawTitle() {
    return Padding(
      padding: const EdgeInsets.only(bottom:8.0,left: 16.0,right: 16.0,),
      child: Text('We also talk about the future of work as the robots',style: TextStyle(color: Colors.grey.shade900),),
    );
  }

  Widget _drawHashTags() {
    return Container(
      child: Wrap(
        children: <Widget>[
          FlatButton(onPressed:(){}, child:Text('#advance',style: _hashTagStyle,),),
          FlatButton(onPressed:(){}, child:Text('#advance',style: _hashTagStyle,),),
          FlatButton(onPressed:(){}, child:Text('#advance',style: _hashTagStyle,),),
        ],
      ),
    );
  }

  Widget _drawBody() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height*0.25,
      child: Image(image: ExactAssetImage('assets/images/place_holder_img.jpg'),fit: BoxFit.cover,),
    );
  }

  Widget _drawFooter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        FlatButton(onPressed:(){}, child:Text('10 COMMENTS',style: _hashTagStyle,),),
        Row(children: <Widget>[
          FlatButton(onPressed:(){}, child:Text('SHARE',style: _hashTagStyle,),),
          FlatButton(onPressed:(){}, child:Text('OPEN',style: _hashTagStyle,),),
        ],),
      ],
    );
  }
}
