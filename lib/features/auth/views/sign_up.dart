import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkgrid_y/features/auth/controller/auth_controller.dart';
import 'package:parkgrid_y/features/auth/views/sign_up_info.dart';
import 'package:parkgrid_y/features/router/route_names.dart';
import 'package:parkgrid_y/temaBilesenleri/renkler.dart';
import 'package:parkgrid_y/features/router/route_names.dart';

import 'sign_in.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
 final TextEditingController _emailController=TextEditingController();
 final TextEditingController _passwordController=TextEditingController();
 final _formKey=GlobalKey<FormState>();

  
  @override
  void dispose(){
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: arkaplan,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),

                  child: Form(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:[
                          const Text("Hesap Olustur",  style: TextStyle(fontSize: 30,color:yazi, fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: TextFormField(
                                controller: _emailController,
                                validator: (value){
                                  if(value!.isEmpty){
                                    return "Email is required";
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  fillColor:acikYazi,
                                  filled: true,
                                  hintText: "Email",
                                  hintStyle: const TextStyle(
                                    color: Colors.deepPurple,
                                    ),
                                     border: OutlineInputBorder(
                                     borderRadius: BorderRadius.circular(4),
                                     borderSide: const BorderSide(
                                      color: butonRengi,
                                  ),
                                ), 
                              ),
                            ),
                          ), 


                          Padding(padding: const EdgeInsets.symmetric(vertical: 5),
                            child: TextFormField(
                              controller: _passwordController,
                              obscureText: true,
                              validator: (value){
                                if(value!.isEmpty){
                                  return "Password is required";
                                }
                                return null;
                              },
                            
                              decoration: InputDecoration(
                                fillColor: acikYazi,
                                  filled: true,
                                  hintText: "Sifre",
                                  hintStyle: const TextStyle(
                                    color: Colors.deepPurple,
                                    ),
                                    border: OutlineInputBorder(
                                     borderRadius: BorderRadius.circular(4),
                                     borderSide: const BorderSide(
                                      color: butonRengi,
                                    ),
                                  ),
                                ),
                              ),
                          ),

                          Consumer(
                            builder: (context, ref, child) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 5,
                                ),
                                child: MaterialButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      ref
                                          .read(authControllerProvider)
                                          .signUpWithEmailAndPassword(
                                            email: _emailController.text,
                                            password: _passwordController.text,
                                          )
                                          
                                          .then(
                                            (value) =>
                                                Navigator.pushNamedAndRemoveUntil(context,
                                                   AppRouteNames.signUpInfo,
                                                    (route) =>false,
                                                    arguments:{'email': _emailController.text}),
                                            
                                          );
                                          
                                    }
                                  },
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  color: yazi,
                                  minWidth: double.infinity,
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 10,
                                    ),
                                    child: Text(
                                      "Devam et",
                                      style: TextStyle(
                                        color: butonYazi,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 5,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Zaten bir hesabin var mi?",
                                  style: TextStyle(
                                  color: pembis,
                                    fontSize: 14,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    AppRouteNames.signIn,
                                    (route) =>false
                                    ),
                                
                                 child: const Text("Giris Yap",
                                    style: TextStyle(color: iconRenk, fontSize: 14,),),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                  ),
                ) ,
              ),
            ],
          ),
        ),
      ),
    );
  } 
}

