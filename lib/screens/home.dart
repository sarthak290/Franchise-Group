import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:toast/toast.dart';
import 'package:franchisegroup/widgets/image_picker.dart';
class home extends StatefulWidget {
  String email, password;

  home({Key key, this.email, this.password}) : super(key: key);
  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _auth = FirebaseAuth.instance;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "The Franchise Group",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Color(0xFF6991C7)),
        elevation: 0.0,
      ),
      body: new Padding(
        padding: EdgeInsets.all(20.0),
        child: Form(
          child: ListView(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 20,
                ),
                child: Center(
                  child: Text(
                    "Welcome",
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Montserat",
                        fontWeight: FontWeight.bold,
                        fontSize: 32.0),
                  ),
                ),
              ),
              UserImagePicker(),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: TextFormField(
                  controller: null,
                  initialValue: widget.email,
                  onChanged: (value) {},
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: "Email",
                    suffix: _emailController.text == "" ||
                            _emailController.text == null
                        ? Container(
                            height: 0.0,
                            width: 0.0,
                          )
                        : GestureDetector(
                            child: Icon(
                              Icons.close,
                              size: 16.0,
                            ),
                            onTap: () {
                              _emailController.text = "";
                            },
                          ),
                  ),
                  validator: (value) {
                    return value.length > 3 ? 'Invalid Email' : null;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: TextFormField(
                  controller: null,
                  initialValue: widget.password,
                  onChanged: (value) {},
                  decoration: InputDecoration(
                    labelText: 'Password',
                    suffix: _passwordController.text == "" ||
                            _passwordController.text == null
                        ? Container(
                            height: 0.0,
                            width: 0.0,
                          )
                        : GestureDetector(
                            child: Icon(
                              Icons.close,
                              size: 16.0,
                            ),
                            onTap: () {
                              _passwordController.text = "";
                            },
                          ),
                  ),
                  obscureText: true,
                  
                ),
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: RaisedButton(
                    onPressed: () {
                      Toast.show("Saved", context,
      duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.blue)),
                    color: Colors.blue,
                    textColor: Colors.white,
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Update",
                      style: TextStyle(fontSize: 15.0),
                    ),
                  )),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0.0,
        child: Text(
          "Logout",
          style: TextStyle(fontSize: 8.0),
        ),
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
        onPressed: () {
          _auth.signOut();
          Navigator.pop(context);
        },
      ),
    );
  }
}
