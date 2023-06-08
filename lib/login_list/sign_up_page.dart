import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _obscureText = true;
  bool _value = false;
  @override
  void initState(){
    super.initState();

  }
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 300,
                child: Lottie.network(
                    "https://assets2.lottiefiles.com/private_files/lf30_fw6h59eu.json"),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 24, right: 24),
                    child: TextField(
                    
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xffE9E8E8),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10))),
                        hintText: 'Enter your username',
                        hintStyle: TextStyle(color: Color(0xff393053)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                   Padding(
                    padding: const EdgeInsets.only(left: 24, right: 24),
                    child: TextField(
                      controller:emailcontroller,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Color(0xffE9E8E8),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10))),
                        hintText: 'Enter your e-mail',
                        hintStyle: TextStyle(color: Color(0xff393053)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 24, right: 24),
                    child: TextField(
                      controller: passwordcontroller,
                      obscureText:!_obscureText,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xffE9E8E8),
                        border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10))),
                        hintText: 'Enter your password',
                        hintStyle: const TextStyle(color: Color(0xff393053)),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _obscureText = 
                             !_obscureText;
                            });
                          },
                          child: Icon(_obscureText
                              ? Icons.visibility
                              : Icons.visibility_off,color: Colors.black87,),//eye close & open
                             
                        ),
                      ),
                      
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 24),
                    child: Row(
                      children: [
                        Checkbox(value: this._value, onChanged: (value){setState(() { //check box
                          this._value = value!;
                        });}),
                        const Text('I agree with'),
                        TextButton(onPressed: (){}, child:const Text('Teams')),
                        const Text('and'),
                        TextButton(onPressed: (){}, child:const Text('Privicy')),
                        
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10,),
              Column(
                children: [
                  SizedBox(
                    width: 330,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {
                        print("Button signup");
                     userRegistration();
                      },
                      child: const Text('Sign Up'),
                      style: ElevatedButton.styleFrom(
                          primary: const Color(0xff0008C1)),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("I'm really an account.",
                  style: TextStyle(fontWeight: FontWeight.bold),),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Sign in'))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
 userRegistration() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailcontroller.text,
               password: passwordcontroller.text); 
               print("emial ${emailcontroller.text}");  
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }
}
