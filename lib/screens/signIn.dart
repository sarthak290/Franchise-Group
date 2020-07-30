import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:toast/toast.dart';
import 'package:franchisegroup/screens/home.dart';

class signIn extends StatefulWidget {
  signIn({Key key}) : super(key: key);
  @override
  _signInState createState() => _signInState();
}

class _signInState extends State<signIn> {
  
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String email, password;
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "SignIn",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 15.0,
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
                child: Text(
                  "SignIn",
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: "Montserat",
                      fontWeight: FontWeight.bold,
                      fontSize: 32.0),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: TextFormField(
                  controller: _emailController,
                  onChanged: (value) {
                    email = value;
                  },
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
                  controller: _passwordController,
                  onChanged: (value) {
                    password = value;
                  },
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
                  validator: (_) {},
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0.0,
        child: Icon(Icons.check),
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
        onPressed: () async {
          print(email);
          print(password);
          Toast.show("Wait ..", context,
      duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
          try {
            final user = await _auth.signInWithEmailAndPassword(
                email: email, password: password);
            if (user != null) {
              print("success signin");
              Toast.show("Success", context,
      duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
              Navigator.push(context,
                      MaterialPageRoute(builder: (context) => home(email: email,password: password,)));
            }
          } catch (e) {
            print(e);
            Toast.show("Invalid Password", context,duration: Toast.LENGTH_LONG,gravity: Toast.BOTTOM);
            
          }
        },
      ),
    );
  }
}
