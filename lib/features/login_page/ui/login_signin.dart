import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'create.dart';
class Loginscreen extends StatefulWidget {

  @override
  _LoginscreenState createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Stack(
          children:<Widget> [
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end:Alignment.bottomCenter,
                  colors: [
                    Color(0xff121739),
                    Color(0xff0b0e24),
                    Color(0xff090b1c),
                  ]
                )
              ),
              child:Column(
                crossAxisAlignment:CrossAxisAlignment.start,
                children:<Widget> [
                  const Padding(
                    padding:EdgeInsets.fromLTRB(8, 100, 8, 8),
                    child: Center(
                      child: Text(
                        'PULZION\'23',
                         style:TextStyle(
                          color: Colors.white,
                           fontSize: 40,
                           fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 70),
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Please Sign in to continue',
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize:18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 6,
                            offset: Offset(0,2)
                          )
                        ]
                      ),
                      height: 60,
                      child: const TextField(
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(
                          color:Colors.black87,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(top: 14),
                          prefixIcon: Icon(
                            Icons.email,
                            color: Color(0xff121739),
                          ),
                            hintText:'Email',
                          hintStyle: TextStyle(
                            color: Colors.black,
                          )
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.black26,
                                blurRadius: 6,
                                offset: Offset(0,2)
                            )
                          ]
                      ),
                      height: 60,
                      child: const TextField(
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(
                          color:Colors.black87,
                        ),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(top: 14),
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Color(0xff121739),
                            ),
                            hintText:'Password',
                            hintStyle: TextStyle(
                              color: Colors.black,
                            )
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 60),
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),

                      height: 60,
                     width: 150,
                     child: ElevatedButton(
                       onPressed: (){
                       },
                       style: ElevatedButton.styleFrom(
                         backgroundColor: Colors.cyan,
                       ),
                       child:const Text(
                         'Login',
                         style: TextStyle(
                           fontSize: 36,
                           fontWeight: FontWeight.normal,
                           color: Colors.black87

                         ),
                       ),

                     ),
                    ),
                  ),
                   Center(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextButton(
                        onPressed:(){
                        },
                        child:const Text(
                        'Forgot password?',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                        ),
                      ),
                    ),

                  ),
                  const SizedBox(height:20),
                  Padding(
                    padding:EdgeInsets.fromLTRB(50, 0, 50, 0),
                    child: Row(
                      children:<Widget> [
                        const Text(
                          'Dont have an account?',
                          style: TextStyle(
                            fontWeight:FontWeight.normal,
                            color: Colors.white,
                          ),
                        ),
                        TextButton(
                        child: const Text("Create New Account ",
                        style: TextStyle(
                          color: Colors.cyan,
                        )
                        ),
                          onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>const CreateAccount()));
                        },
                    ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
