import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkgrid_y/features/auth/controller/auth_controller.dart';
import 'package:parkgrid_y/features/router/route_names.dart';
import 'package:parkgrid_y/temaBilesenleri/renkler.dart';


class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
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
                          const Text("Hoşgeldiniz!",  style: TextStyle(fontSize: 30,color: yazi, fontWeight: FontWeight.bold),
                          
                          ),
                          customSizedBox(),

                          //email kutucuğu
                          TextFormField(
                            controller: _emailController,
                            validator: (value){
                              if(value!.isEmpty){
                                return "Email is required";
                              }
                              return null;
                            },
                            decoration: customInputDecoration("E-mail"),
                            style: const TextStyle(color:yazi), 
                          ), 
                          customSizedBox(),

                          //password kutucuğu
                          TextFormField(
                            controller: _passwordController,
                            validator: (value){
                              if(value!.isEmpty){
                                return "Password is required";
                              }
                              return null;
                            },
                            obscureText: true,
                            decoration: customInputDecoration("Sifre"),
                            style: const TextStyle(color: yazi),
                          ),
                          customSizedBox(),


                          Center(
                            child: TextButton(
                              onPressed: () {}, child: const Text("Sifremi Unuttum", style:TextStyle(color:pembis),
                              ),
                            ),
                          ),
                          customSizedBox(),

                          
                          Consumer( 
                            builder: (context,ref,child){
                              return Center(
                                child: TextButton(
                                  onPressed: () {
                                    if(_formKey.currentState!.validate()) {
                                      ref
                                      .read(authControllerProvider)
                                      .signInWithEmailAndPassword(
                                        email: _emailController.text, 
                                        password: _passwordController.text,
                                      )
                                      .then(
                                          (value) =>
                                              Navigator.pushNamedAndRemoveUntil(context, 
                                              AppRouteNames.home,
                                              (route) => false),
                                        );
                                    }
                      
                                  }, 
                                  child:Container(
                                    height:50,
                                    width:150,
                                    margin:const EdgeInsets.symmetric(horizontal:60),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color:butonRengi
                                    ),
                                    child: const Center(
                                      child: Text(
                                        "Giris Yap", style:TextStyle(color: butonYazi),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                      
                          customSizedBox(),
                          Center(
                            child: TextButton(
                              onPressed: () => Navigator.pushNamed(context, 
                              AppRouteNames.signUp), 
                              child: const Text("Kullanici Hesabi Olustur", style:TextStyle(color:pembis),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )  
              ],    
            ),
          ),
      ),
      );
    
  }
  Widget customSizedBox() => const SizedBox(height:20,);
  InputDecoration customInputDecoration(String hintText){
    return InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(color: acikYazi),
      enabledBorder:const UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.grey,
          ), 
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
          color: Colors.grey,
        ),
      ),
    );
  } 
}

