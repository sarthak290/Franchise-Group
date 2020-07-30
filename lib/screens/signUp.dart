import 'package:flutter/material.dart';
import 'package:franchisegroup/screens/signIn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:toast/toast.dart';


import 'package:franchisegroup/screens/home.dart';

class Auth extends StatefulWidget {
  Auth({Key key}) : super(key: key);
  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  String email, password, name;
  bool spinner = false;
  
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
    title: Text(
      "SignUp",
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
        body: Padding(
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
              "SignUp",
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
              controller: _nameController,
              // textAlign: TextAlign.center,
              onChanged: (value) {
                name = value;
                print(name);
              },
              decoration: InputDecoration(
                labelText: "Name",
                suffix: _nameController.text == "" ||
                        _nameController.text == null
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
                          _nameController.text = "";
                        },
                      ),
              ),
              validator: (value) {
                return value.length > 3 ? 'Invalid name' : null;
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) {
                email = value;
                print(email);
              },
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
                print(password);
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
          GestureDetector(
            onTap: () {
              
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => signIn()));
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: RichText(
                text: TextSpan(children: [
                  TextSpan(
                    text: "Already a Member ",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                        fontFamily: "Nunito",
                        fontWeight: FontWeight.w600),
                  ),
                  TextSpan(
                    text: "SignIn.",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.blue,
                        fontFamily: "Nunito",
                        fontWeight: FontWeight.bold),
                  )
                ]),
              ),
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
        print(name);
        print(email);
        Toast.show("Wait..", context,
      duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);

        try {
        final newUser = await _auth.createUserWithEmailAndPassword(
      email: email, password: password);
        if (newUser != null) {
    print("success");
    Toast.show("Success", context,
      duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => home(
                  email: email,
                  password: password,
                )));
        }
        
        } catch (e) {
        print(e);
        Toast.show("Email exist", context,
      duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        }
      },
    ),
      );
  }
}
