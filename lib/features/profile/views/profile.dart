import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:parkgrid_y/features/auth/views/sign_in.dart';
import 'package:parkgrid_y/features/router/route_names.dart';
import 'package:parkgrid_y/temaBilesenleri/paths.dart';
import 'package:parkgrid_y/temaBilesenleri/renkler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkgrid_y/models/user_model.dart';
import '../../profile/controller/profile_controller.dart';
import '../../profile/repository/profile_repository.dart';
import 'package:parkgrid_y/temaBilesenleri/sizes.dart';
import 'package:parkgrid_y/models/user_model.dart';


class Profile extends ConsumerWidget{
  const Profile({superkey});

  @override
  Widget build(BuildContext context, WidgetRef ref){
    return Scaffold(
      backgroundColor: arkaplan,
      body: FutureBuilder<UserModel>(
        future: ref.read(profileControllerProvider).getUser(),
        builder: (context ,snapshot){
          if(snapshot.hasData){
            final userModel=snapshot.data!;
            return SafeArea(
              child: Padding(
                padding: scaffoldPadding,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [ 
                      Text(
                        "Profil", 
                        style: const TextStyle(
                        fontSize: 30, 
                        fontWeight: FontWeight.bold, 
                        color:yazi,
                        ),
                      ),
                     Padding(
                      padding: vertical10,
                      child: CircleAvatar(
                      backgroundColor: acikYazi,
                      radius: 20,
                      backgroundImage: CashedNetworkImageProvider(
                        userModel.profilePhoto!,
                      ),
                     ),
                    )
                  ],
                ),
                MenuItem(
                  title: "Profil bilgilerini duzenle",
                  onTap: () {}, 
                  leadingAsset: duzenleSvg,
                ),
                
                MenuItem(
                  title: "Cikis Yap",
                  onTap: () {
                   Navigator.pushNamed(context,
                   AppRouteNames.signIn,
                   );
                  }, 
                  leadingAsset: cikisSvg,
                ),


              ],
              ),
              )
            );
          } else if(snapshot.connectionState== ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator(),);
          }else{
            return const Center(child: Text("ERROR"));
          }

        }),
    );
  }

}

class MenuItem extends StatelessWidget {
  const MenuItem({
    Key? key,
    this.onTap,
    required this.title,
    required this.leadingAsset,
  }): super(key: key);
  final Function()? onTap;
  final String title;
  final String leadingAsset;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child:Padding(
        padding:vertical5,
        child: Card(
          color: iconRenk,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 5,
          child: ListTile(
            leading: SvgPicture.asset(
              leadingAsset,
              ),
              title: Text(
               title, 
                style: TextStyle(
                  color: butonYazi, 
                  fontSize: 16,
                  ),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: butonYazi,
                ),
          ),
        ),
      )
    );
  }
} 
