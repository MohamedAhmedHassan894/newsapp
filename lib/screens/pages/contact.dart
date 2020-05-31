import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/utilities/data_utilities.dart';
class Contact extends StatefulWidget {
  @override
  _ContactState createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  TextEditingController nameController ;
  TextEditingController messageConrtoller ;
  TextEditingController emailController ;
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false ;
  @override
  void initState() {
    nameController =TextEditingController();
    messageConrtoller=TextEditingController();
    emailController=TextEditingController();
    super.initState();
  }
  @override
  void dispose() {
    nameController.dispose();
    messageConrtoller.dispose();
    emailController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact Us"),
      ),
      body: Padding(
        padding: EdgeInsets.all(18),
        child:(isLoading?loading():contactForm()),
      ),
    );
  }
  Widget contactForm (){
    return  Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration (
                labelText: "Your Name",
              ),
              validator: (value){
                if (value.isEmpty){
                  return "please ,Enter Your Name";
                }
                else{
                  return null;
                }
              },
            ),
            SizedBox(height: 24,),
            TextFormField(
              decoration: InputDecoration (
                labelText: "Email",
              ),
              validator: (value){
                if (value.isEmpty){
                  return "please ,Enter Your Email";
                }
                else{
                  return null;
                }
              },
            ),
            SizedBox(height: 24,),
            TextFormField(
              decoration: InputDecoration (
                labelText: "Message",
              ),
              validator: (value){
                if (value.isEmpty){
                  return "please ,Enter Your message";
                }
                else{
                  return null;
                }
              },
            ),
            SizedBox(
              width: double.infinity,
              child: RaisedButton(
                  child: Text(
                    "Send Message",
                    style: TextStyle(color: Colors.white),),
                  onPressed: (){
                    if(_formKey.currentState.validate()){

                      String name = nameController.text;
                      String email = emailController.text;
                      String mesage = messageConrtoller.text;
                      // send data to contact api
                      setState(() {
                        isLoading=true ;
                      });
                    }
                    else{
                      isLoading=false;
                    }
                  }),
            ),
          ],));
  }
}
