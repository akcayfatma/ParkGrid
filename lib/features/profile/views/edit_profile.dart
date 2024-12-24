import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:parkgrid_y/temaBilesenleri/temaBilesenleri_firebase_storage.dart';
import 'package:parkgrid_y/temaBilesenleri/sizes.dart';
import 'package:parkgrid_y/features/profile/controller/profile_controller.dart';
import 'package:parkgrid_y/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import 'package:parkgrid_y/temaBilesenleri/renkler.dart';
import 'package:parkgrid_y/temaBilesenleri/utils.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key, required this.currentUser});
  final UserModel currentUser;

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _fuelTypeController = TextEditingController();
  XFile? _image;
String? selectedFuelType; // Seçilen yakıt türü
List<String> fuelTypes = ['Elektrikli', 'Fosil Yakıt', 'Hibrit'];

  void selectImage() async {
    _image = await pickImageFromGallery();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.currentUser.name;
    _surnameController.text = widget.currentUser.surname;
    _emailController.text = widget.currentUser.email;
    _fuelTypeController.text=widget.currentUser.fuelType;
    selectedFuelType = widget.currentUser.fuelType; 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: acikYazi,
          ),
        ),
        title: const Text(
          "Profilini Duzenle",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: acikYazi,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: scaffoldPadding,
          child: Column(
            children: [
              Padding(
                padding: vertical10,
                child: GestureDetector(
                  onTap: () => selectImage(),
                  child: CircleAvatar(
                    backgroundColor: iconRenk,
                    radius: 70,
                    backgroundImage: _image != null
                        ? FileImage(File(_image!.path)) as ImageProvider
                        : CachedNetworkImageProvider(
                            widget.currentUser.profilePhoto!,
                          ),
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                      child: InputField(
                    controller: _nameController,
                    title: 'Name',
                    value: widget.currentUser.name,
                  )),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: InputField(
                      controller: _surnameController,
                      title: 'Surname',
                      value: widget.currentUser.surname,
                    ),
                  ),
                ],
              ),

              InputField(
                controller: _emailController,
                title: 'E-Mail',
                value: widget.currentUser.email,
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
                decoration: InputDecoration(
                  fillColor: acikYazi,
                    filled: true,

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
                    padding: vertical10,
                    child: MaterialButton(
                      onPressed: () async {
                        widget.currentUser.name = _nameController.text;
                        widget.currentUser.surname = _surnameController.text;
                        widget.currentUser.email = _emailController.text;
                        widget.currentUser.fuelType = selectedFuelType ?? widget.currentUser.fuelType;


                        if (_image != null) {
                          widget.currentUser.profilePhoto = await ref
                              .read(temaBilesenleriFSRepositoryProvider)
                              .storeFileToFirebase(
                                "profilePhotos/${widget.currentUser.uid}",
                                File(_image!.path),
                              );
                        } else {
                          widget.currentUser.profilePhoto =
                              widget.currentUser.profilePhoto;
                        }
                        UserModel userModel = widget.currentUser;
                        await ref
                            .read(profileControllerProvider)
                            .updateProfile(userModel)
                            .whenComplete(
                              () => Navigator.pop(context),
                            );
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      color: butonRengi,
                      minWidth: double.infinity,
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 10,
                        ),
                        child: Text(
                          "Kaydet",
                          style: TextStyle(
                            color: butonRengi,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class InputField extends StatelessWidget {
  const InputField({
    super.key,
    required TextEditingController controller,
    required this.title,
    required this.value,
  }) : _controller = controller;
  final String title;
  final String? value;
  final TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        controller: _controller,
        validator: (value) {
          return null;
        },
        decoration: InputDecoration(
          contentPadding: all5,
          fillColor: acikYazi,
          filled: true,
          hintText: title,
          hintStyle: const TextStyle(
            color: acikYazi,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: const BorderSide(
              color: acikYazi,
            ),
          ),
        ),
      ),
    );
  }
}