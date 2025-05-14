import 'dart:io';

import 'package:app/controller/authintication.dart';
import 'package:app/controller/user_controller.dart';
import 'package:app/models/message_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/cubit/user_state.dart';
import 'package:app/models/sign_in_model.dart';
import 'package:image_picker/image_picker.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit(this.authinticationController ,this.userController, this.token) : super(UserInitial());
  AuthinticationController authinticationController;
  UserController 
  userController;
  //Sign in Form key
  GlobalKey<FormState> signInFormKey = GlobalKey();
  //Sign in email
  TextEditingController signInEmail = TextEditingController();

  //Sign in password
  TextEditingController signInPassword = TextEditingController();
  //Sign Up Form key
  GlobalKey<FormState> signUpFormKey = GlobalKey();
  //Profile Pic
  XFile? profilePic;
  //Sign up name
  TextEditingController signUpFirstName = TextEditingController();
  //Sign up phone number
  TextEditingController signUpLastName = TextEditingController();
  //Sign up email
  TextEditingController signUpEmail = TextEditingController();
  //Sign up password
  TextEditingController signUpPassword = TextEditingController();
  //Sign up confirm password
  TextEditingController signUpConfirmPassword = TextEditingController();
  TextEditingController feedbackController = TextEditingController();
  TextEditingController updatPasswordCont = TextEditingController();
  TextEditingController confirmUpdatPassowrdCont = TextEditingController();
  TextEditingController resetCode = TextEditingController();
  TextEditingController resetEmail = TextEditingController();
  TextEditingController resetPasswd = TextEditingController();
  File? selectedImage;

  String token;
  bool loggedIn = false;
  //Sign up confirm password
  SignInModel? user;


  signUp()  {
    if(signUpPassword.text != signUpConfirmPassword.text){
      emit(SignUpFailure(message: "Password does not match"));
    }else{
      emit(SignUpFailure(message: "Password does not match"));
emit(SignUpLoading());
final response = authinticationController.register(getMapRegister());

    response.then((value) {
      value.fold(
        (errMessage) => emit(SignUpFailure(message: errMessage.message)),
        (signUpModel)=> emit(SignUpSuccess(message: signUpModel.message)),
        );
  });}

    }
    
  

  Map<String, dynamic> getMapRegister(){
   Map<String, dynamic> registerRequste = {
  'email': signUpEmail.text,
  'password': signUpPassword.text,
  'firstname': signUpFirstName.text,
  'lastname': signUpLastName.text,
};
signUpPassword.text = "";
signUpConfirmPassword.text = "";
signUpEmail.text = "";
signUpFirstName.text = "";
signUpLastName.text = "";
return registerRequste;
  }
    Map<String, dynamic> getMapLogIn(){
   Map<String, dynamic> registerRequste = {
  'email': signInEmail.text,
  'password': signInPassword.text,

};
signInEmail.text = "";
signInPassword.text = "";

return registerRequste;
  }
  logIn(){
    emit(SignInLoading());
    final response =  authinticationController.login(getMapLogIn());
    
    response.then((value) {
      value.fold(
        (message) => emit(SignInFailure(message: message.message)),
        (signInModel) => emit(SignInSuccess( message: signInModel.message)),
      );
    });
  }
    getUserProfile() async {
    emit(GetUserLoading());
    
    final response =await userController.getUserProfile();
    response.fold(
      (errMessage) => emit(GetUserFailure(errMessage: errMessage.message)),
      (user) => emit(GetUserSuccess(user: user)),
    );
    
  }

  deleteAcc()async{
    emit(DeleteAccLoading());
    final response = await userController.deleteAccount();
    response.fold(
        (errMessage) => emit(DeleteAccFailure(message: errMessage.message)),
        (respons) => emit(DeleteAccSuccess(message: respons.message)),
      );
    
  }
  sentHistory(Map<String,dynamic> history)async{
    emit(SentHistoryLoading());
    final response =await userController.sentHistory(history);
    response.fold(
        (errMessage) => emit(DeleteAccFailure(message: errMessage.message)),
        (respons) => emit(DeleteAccSuccess(message: respons.message)),
      );
  
  }
    sentNotification(String notification)async{
    emit(SentNotificationLoading());
    final response =await userController.sentNotification(notification);
    response.fold(
        (errMessage) => emit(DeleteAccFailure(message: errMessage.message)),
        (respons) => emit(DeleteAccSuccess(message: respons.message)),
      );
    
  }
  sentFeedBack()async{
    emit(SentFeedBackLoading());
    final response =await userController.sentFeedBack(feedbackController.text);
    feedbackController.text = "";
      response.fold(
        (errMessage) => emit(SentFeedBackFailure(message: errMessage.message)),
        (respons) {
          if (respons.success == false) {
            emit(SentFeedBackFailure(message: respons.message));
            return;
          }
          emit(SentFeedBackSuccess(message: respons.message));
        
        },
      );
      
  }
    
    getFeedBack() async {
      emit(GetFeedBackLoading());
      final response =await userController.getFeedBack();
      
        response.fold(
          (errMessage) => emit(GetFeedBackFailure(errMessage: errMessage.message)),
          (respons) => emit(GetFeedBackSuccess(feedback: respons)),
        );
     

    }
    getHistory() async {
      emit(GetHistoryLoading());
      final response = await userController.getHistory();
      response.fold(
        (errMessage) => emit(GetHistoryFailure(errMessage: errMessage)),
        (respons) => emit(GetHistorySuccess(history: respons)),
      );
    }
    getNotification() async {
      emit(GetNotificationLoading());
      final response =await userController.getNotification();
      
        response.fold(
          (errMessage) => emit(GetNotificationFailure(message: errMessage)),
          (respons) => emit(GetNotificationSuccess(notification: respons)),
        );
      
    }

    feedBackCheck() async {
      emit(FeedBackCheckLoading());
      final response = await userController.feedBackCheck();
      if (response){
        emit(FeedBackCheckSuccess(feedback: "You have already sent feedback", isCheck: true));
      }
      else {
        emit(FeedBackCheckSuccess(feedback: "You can send feedback", isCheck: false));
      }
    }
      updatePassword(){
    emit(UpdatePasswordLoading());
    if(updatPasswordCont.text != confirmUpdatPassowrdCont.text){
      emit(UpdatePasswordFailure(message:MessageModel(message:"Password does not match")));
    }
    final response = authinticationController.updatePassword(updatPasswordCont.text);
    updatPasswordCont.text = "";
    confirmUpdatPassowrdCont.text = "";
    response.then((value) {
      value.fold(
        (errMessage) => emit(UpdatePasswordFailure(message: errMessage)),
        (signInModel) => emit(UpdatePasswordSuccess(message: signInModel)),
      );
    });
  }
  forgotPassword(){
    emit(ForgotPasswordLoading());
    final response = authinticationController.forgotPassword(resetEmail.text);
    resetEmail.text = "";
    response.then((value) {
      value.fold(
        (errMessage) => emit(ForgotPasswordFailure(message: errMessage)),
        (signInModel) => emit(ForgotPasswordSuccess(message: signInModel)),
      );
    });
  }
  resetPasswordRequest(){
    emit(ResetPasswordRequestLoading());
    final resetPasswdRequest = {
      'email': resetEmail.text,
      'password': resetPasswd.text,
      'code': resetCode.text,
    };
    resetEmail.text = "";
    resetPasswd.text = "";
    resetCode.text = "";
    final response = authinticationController.resetPasswordRequest(resetPasswdRequest);
    response.then((value) {
      value.fold(
        (errMessage) => emit(ResetPasswordRequestFailure(message: errMessage)),
        (signInModel) => emit(ResetPasswordRequestSuccess(message: signInModel)),
      );
    });
  }

    uploadProfilePic(){
    emit(UploadProfilePicLoading());
    final response = userController.uploadProfilePic(selectedImage);
    response.then((value) {
      value.fold(
        (errMessage) => emit(UploadProfilePicFailure(message: errMessage)),
        (signInModel) => emit(UploadProfilePicSuccess(message: signInModel)),
      );
    });
  }
  getProfilePic() async {
    emit(GetProfilePicLoading());
    final response = await userController.getProfilePic();
    response.fold(
      (errMessage) => emit(GetProfilePicFailure(message: errMessage)),
      (respons) => emit(GetProfilePicSuccess(profileImage: respons)),
    );
  }
  
}

  

/*
  signIn() async {
    emit(SignInLoading());
    final response = await userRepository.signIn(
      email: signInEmail.text,
      password: signInPassword.text,
    );
    response.fold(
      (errMessage) => emit(SignInFailure(errMessage: errMessage)),
      (signInModel) => emit(SignInSuccess()),
    );
  }

*/