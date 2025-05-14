import 'package:app/colors.dart';
import 'package:app/cubit/user_cubit.dart';
import 'package:app/cubit/user_state.dart';
import 'package:app/models/user_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserInfoPage extends StatefulWidget {
  const UserInfoPage({super.key});

  @override
  State<UserInfoPage> createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  UserModel user = UserModel();

  @override
Widget build(BuildContext context) {
  bool loggedIn = context.read<UserCubit>().loggedIn;
  if (loggedIn) {
    context.read<UserCubit>().getUserProfile();
  }

  return BlocConsumer<UserCubit, UserState>(
    listener: (context, state) {
      if (state is GetUserFailure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error fetching user data: ${state.errMessage}'),
            backgroundColor: Colors.red,
          ),
        );
      }
      if (state is GetUserSuccess) {
        user = state.user;
      }
    },
    builder: (context, state) {
      if (state is GetUserFailure || !loggedIn) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Account Information".tr(), style: const TextStyle(color: Colors.white)),
            backgroundColor: primaryColor,
          ),
          body: Center(child: Text("No user signed in").tr()),
        );
      }

      return Scaffold(
        appBar: AppBar(
          title: Text("Account Information".tr(), style: const TextStyle(color: Colors.white)),
          backgroundColor: primaryColor,
        ),
        body: state is GetUserLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView(
                padding: const EdgeInsets.all(10.0),
                children: [
                  _buildInfoTile(title: "First Name".tr(), value: user.firstname),
                  _buildInfoTile(title: "Last Name".tr(), value: user.lastname),
                  _buildInfoTile(title: "Email".tr(), value: user.email),
                  _buildInfoTile(title: "Last Login Date".tr(), value: user.lastLogin),
                  _buildInfoTile(title: "Last Checkup Date".tr(), value: user.lastDiagnosis),
                ],
              ),
      );
    },
  );
}

Widget _buildInfoTile({required String title, required String value}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(171, 255, 255, 255),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(54, 0, 217, 255),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Color.fromARGB(255, 0, 9, 128)),
        ),
        subtitle: Text(
          value.isNotEmpty ? value : '-',
          style: const TextStyle(fontSize: 16, color: Colors.black87),
        ),
      ),
    ),
  );
}
}
