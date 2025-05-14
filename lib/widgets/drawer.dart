import 'dart:typed_data';

import 'package:app/cubit/user_cubit.dart';
import 'package:app/cubit/user_state.dart';
import 'package:app/models/user_model.dart';
import 'package:app/widgets/drawer_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../pages/history_page.dart';
import '../pages/about_us_page.dart';
import '../pages/change_password_page.dart';
import '../pages/feedback_page.dart';
import '../pages/notifications_page.dart';
import '../pages/settings_page.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  static const Color drawerColor = Color.fromARGB(255, 43, 183, 204);
  static const Color headerColor = Color.fromARGB(255, 116, 184, 243);

  @override
  CustomDrawerState createState() => CustomDrawerState();
}

class CustomDrawerState extends State<CustomDrawer> {
    UserModel user= UserModel();
Future<void> _pickImage() async {
  final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

  if (pickedFile != null) {
    if(mounted){
      context.read<UserCubit>().selectedImage = File(pickedFile.path);
      context.read<UserCubit>().uploadProfilePic();
    }
  }
}
@override
void initState() {
  super.initState();
  context.read<UserCubit>().getProfilePic();
}
  // Build the header with user info and image
  Widget buildHeader() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(vertical: 24),
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF6DC6E7), Color(0xFF3A9BD9)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: _pickImage,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(70, 0, 0, 0),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child:BlocBuilder<UserCubit,UserState>(builder:(context,state){
              if(state is GetProfilePicSuccess){
              return ClipOval(
              child: Image.memory(
          state.profileImage.image,
          width: 100,
          height: 100,
          fit: BoxFit.cover,
        ),
              
              ); }else if(state is UploadProfilePicSuccess){
                return ClipOval(
                  child: Image.file(
                    context.read<UserCubit>().selectedImage!,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                );

              }
                  else{return ClipOval(child: Image.asset(
                      'asset/Image/Anonymous.png',
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
            );}
            }) 
          ),
        ),
        const SizedBox(height: 10),
        Text(
          '${user.firstname} ${user.lastname}',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    ),
  );
}



  // Build menu items in the drawer
  Widget _buildMenuItems(BuildContext context) {
    return ListView(
      children: [
        if (context.read<UserCubit>().loggedIn) ...[
          buildDrawerItem(
            context,
            icon: Icons.history,
            text: 'History',
            page: HistoryPage(),
          ),
          buildDrawerItem(
            context,
            icon: Icons.password,
            text: 'Change Password',
            page: const ChangePasswordPage(),
          ),
          buildDrawerItem(
            context,
            icon: Icons.feedback,
            text: 'Feedback',
            page: const FeedbackPage(),
          ),
          buildDrawerItem(
            context,
            icon: Icons.notifications,
            text: 'Notifications',
            page: const NotificationsPage(),
          ),
        ],
        buildDrawerItem(
          context,
          icon: Icons.settings,
          text: 'Settings',
          page: SettingsPage(),
        ),
        buildDrawerItem(
          context,
          icon: Icons.info,
          text: 'About Us',
          page: const AboutUsPage(),
        ),
        buildLogoutItem(context),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    bool logedIn = context.read<UserCubit>().loggedIn;
    if(logedIn){
    context.read<UserCubit>().getUserProfile();}

    return BlocConsumer<UserCubit, UserState>(listener: (context, state) {
      if (state is GetUserFailure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error fetching user data: ${state.errMessage}'),
            backgroundColor: Colors.red,
          ),
        );
      }
      if(state is GetUserSuccess) {
        user = state.user;
      }
    }, builder: (context, state) {

      return Drawer(
        backgroundColor: CustomDrawer.drawerColor,
        child:
              state is GetUserLoading?
         const Center(child: CircularProgressIndicator())
              :Column(
          
          children: [
            buildHeader(),
            Expanded(child: _buildMenuItems(context)),
          ],
        ),
              
        
         
      );
    });
  }
}