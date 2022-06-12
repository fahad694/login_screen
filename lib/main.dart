import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:my_login_screen/utils/popups.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const MyHomePage(title: 'Login screen'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: const Text(
                "Hello There!",
                style: TextStyle(
                  fontFamily: "Roboto",
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 60,
              width: 300,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: const Text(
                  "automatic identity verification which enable you to verify your identity",
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: SizedBox(
                  height: 250,
                  width: 250,
                  // ignore: avoid_unnecessary_containers
                  child: Container(
                      child: Image.asset(
                    'assets/unnamed.jpg',
                    width: 200,
                    height: 200,
                  ))),
            ),
            const SizedBox(height: 90),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: SizedBox(
                height: 50,
                width: 300,
                child: TextButton(
                  child: const Text(
                    "Login",
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.blueAccent),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ))),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginActivity()),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: SizedBox(
                height: 50,
                width: 300,
                child: TextButton(
                    child: const Text(
                      "Register",
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.red),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterActivity()));
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// this activity made for login

// ignore: use_key_in_widget_constructors
class LoginActivity extends StatelessWidget {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  TextEditingController _email = new TextEditingController();

  TextEditingController _password = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable

    return Scaffold(
        appBar: AppBar(
          title: const Text("Login"),
        ),
        body: Form(
          key: formkey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 230,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 140),
                  child: const Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 70),
                  child: const Text(
                    "Wellcome back! Login with your credentials",
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: const Text(
                    "Email",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: SizedBox(
                    height: 70,
                    width: 380,
                    child: TextFormField(
                      validator: (value) =>
                          value!.isEmpty ? "Email can't be empty" : null,
                      controller: _email,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter your name',
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: const Text(
                    "Password",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: SizedBox(
                    height: 70,
                    width: 380,
                    child: TextFormField(
                      validator: (value) =>
                          value!.isEmpty ? "pasworrd can't be empty" : null,
                      controller: _password,
                      obscureText: true,
                      decoration: const InputDecoration(
                          hintText: 'Password', border: OutlineInputBorder()),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 60),
                  child: SizedBox(
                    height: 50,
                    width: 280,
                    child: TextButton(
                        child: const Text(
                          "Login",
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.blueAccent),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ))),

                        // ignore: avoid_returning_null_for_void
                        // this code used for behave of button for access the firebase authentication
                        onPressed: () async {
                          final FormState formstate = formkey.currentState!;

                          if (formstate.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Loading')));
                            try {
                              email = _email.text;
                              password = _password.text;
                              final user = await FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                email: email,
                                password: password,
                              );

                              if (user.user != null) {
                                PopupUtils.showSnackbarSuccess(
                                    context, "Logged In");
                              }
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'wrong-password') {
                                print('The password provided is too weak.');
                                PopupUtils.showSnackbar(
                                    context, "Invalid Password");
                              } else if (e.code == 'email-already-in-use') {
                                print(
                                    'The account already exists for that email.');
                              }
                            } catch (e) {
                              print(e);
                            }
                          }
                        }),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 98),
                  child: RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: "Dont have an account?",
                        style: TextStyle(color: Colors.black)),
                    TextSpan(
                        text: "Sign Up",
                        style: TextStyle(color: Colors.blue),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RegisterActivity()));
                          })
                  ])),
                )
              ],
            ),
          ),
        ));
  }
}

class RegisterActivity extends StatelessWidget {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  final TextEditingController _email = TextEditingController();

  final TextEditingController _password = TextEditingController();
  final TextEditingController _newPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //   String email = "";
    // String password = "";
    // String newPassword = "";
    return Scaffold(
        appBar: AppBar(
          title: const Text("Register"),
        ),
        body: Form(
          key: formkey,
          child: SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 80,
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 145,
                  vertical: 10,
                ),
                child: const Text(
                  "Sign up!",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 120),
                child: const Text(
                  "Create an Account,its free",
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  child: const Text(
                    "Email",
                  )),
              SizedBox(
                height: 70,
                width: 390,
                child: TextFormField(
                  validator: (value) =>
                      value!.isEmpty ? "email can't be empty" : null,
                  controller: _email,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter your email",
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 5,
                  vertical: 5,
                ),
                child: const Text("Password"),
              ),
              SizedBox(
                height: 70,
                width: 390,
                child: TextFormField(
                  validator: (value) =>
                      value!.isEmpty ? "password cant be empty" : null,
                  controller: _password,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter password",
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  child: const Text("Confirm Password")),
              SizedBox(
                height: 70,
                width: 390,
                child: TextFormField(
                  validator: (value) => value!.isEmpty
                      ? "write password again"
                      : _password.text != value
                          ? "Passwords don't match"
                          : null,
                  controller: _newPassword,
                  obscureText: true,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "write again password"),
                ),
              ),
              const SizedBox(height: 30),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 50),
                child: SizedBox(
                  height: 50,
                  width: 280,
                  child: TextButton(
                    child: const Text(
                      "Sign up",
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.red),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)))),
                    // ignore: avoid_returning_null_for_void
                    onPressed: () async {
                      if (formkey.currentState != null &&
                          formkey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Registering')));
                        try {
                          final email = _email.text;
                          final userCred = await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                            email: email,
                            password: _password.text,
                          );
                          if (userCred.user != null) {
                            PopupUtils.showSnackbarSuccess(
                                context, "Registered");
                          } else {
                            PopupUtils.showSnacbaremail(
                                context, "user is null");
                          }
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'weak-password') {
                            print('The password provided is too weak.');
                          } else if (e.code == 'email-already-in-use') {
                            PopupUtils.showSnacbaremail(
                                context, "Email is already in use");
                            print('The account already exists for that email.');
                          }
                        } catch (e) {
                          print(e);
                        }
                      }
                    },
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 90),
                child: RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: "Already have an account?",
                      style: TextStyle(color: Colors.black)),
                  TextSpan(
                      text: "Login",
                      style: TextStyle(color: Colors.blue),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginActivity()));
                        })
                ])),
              )
            ],
          )),
        ));
  }
}
