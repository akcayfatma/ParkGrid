import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkgrid_y/features/auth/controller/auth_controller.dart';
import 'package:parkgrid_y/features/router/route_names.dart';
import 'package:parkgrid_y/models/user_model.dart';
import 'package:parkgrid_y/temaBilesenleri/renkler.dart';

class SignUpInfo extends StatefulWidget {
  const SignUpInfo({
    super.key,
    required this.email,
  });
  final String email;

  @override
  State<SignUpInfo> createState() => _SignUpInfoState();
}

class _SignUpInfoState extends State<SignUpInfo> {
 final TextEditingController _nameController=TextEditingController();
 final TextEditingController _surnameController=TextEditingController();
 final TextEditingController _fuelTypeController=TextEditingController();
 final _formKey=GlobalKey<FormState>();
 String? selectedFuelType; // Seçilen yakıt türü
List<String> fuelTypes = ['Elektrikli', 'Fosil Yakıt', 'Hibrit'];

  
  @override
  void dispose(){
    _nameController.dispose();
    _surnameController.dispose();
    _fuelTypeController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context){
    return PopScope(
      canPop: false,
      child: Scaffold(
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
                          const Text("Hesap Olustur",  style: TextStyle(fontSize: 30,color: yazi, fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: TextFormField(
                                controller: _nameController,
                                validator: (value){
                                  if(value!.isEmpty){
                                    return "Isim is required";
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  fillColor: acikYazi,
                                  filled: true,
                                  hintText: "Isim",
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
                              controller: _surnameController,
                              validator: (value){
                                if(value!.isEmpty){
                                  return "Soyisim is required";
                                }
                                return null;
                              },
                            
                              decoration: InputDecoration(
                                fillColor: acikYazi,
                                  filled: true,
                                  hintText: "Soyisim",
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
                            child: DropdownButtonFormField<String>(

                              value: selectedFuelType,
                              items:fuelTypes.map((String fuel){
                                return DropdownMenuItem<String>(
                                  value: fuel, 
                                  child: Text(fuel), 
                                );
                                
                                }).toList(),
                                onChanged: (String? newValue){
                                  setState((){
                                    selectedFuelType=newValue;
                                  });
                                },
                          
                              validator: (value){
                                if(value==null || value.isEmpty){
                                  return "Yakıt türünü seçiniz";
                                }
                                return null;
                              },
                            
                              decoration: InputDecoration(
                                fillColor: acikYazi,
                                  filled: true,
                                  hintText: " Yakıt türünüzü seçin",
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
                                     UserModel userModel = UserModel(
                                        name: _nameController.text,
                                        surname: _surnameController.text,
                                        email: widget.email,
                                        fuelType: _fuelTypeController.text);
                                    ref
                                    .read(authControllerProvider)
                                    .storeUserInfoToFirebase(userModel)
                                    .whenComplete(
                                      ()=> Navigator.pushNamedAndRemoveUntil(
                                        context,
                                        AppRouteNames.home,
                                        (route) => false),
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
                                      "Olustur!",
                                      style: TextStyle(
                                        color: butonYazi,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
    ),
  );
} 
}

