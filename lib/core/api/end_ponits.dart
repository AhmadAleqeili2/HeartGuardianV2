class EndPoint {
  static String baseUrl = "https://f5cf-109-107-253-53.ngrok-free.app/";
  static String login = "login";
  static String register = "register";
  static String updatePassword = "updatepasswd";
  static String deleteAccount = "deleteacc";
  static String forgotPassword = "forgotpassword";
  static String resetPasswordRequest = "resetPasswordRequest";
  static String userprofile="user";
  static String history = "history";
  static String notification = "notification";
  static String feedback = "feedback";

  static String uploadProfilePic = "uploadimage";
  
}

class ApiKey {
  static String code = "code";
  static String message = "message";
  static String feedback = "feedback";
  static String history = "history";
  static String notification = "notification";
  static String newPassword = "newPassword";
  static String emailRe = "Email";
  static String email = "email";
  static String password = "password";
  static String token = "Authorization";
  static String id = "id";
  static String firstName = "firstname";
  static String lastName = "lastname";
  static String date = "date";
  static String profilePic = "profilePic";
  static String lastDiagnosis = "lastDiagnosis";
  static String lastLogin = "lastLogin";

  static String image = "image";
}
/*
post
"/login"
{
email
password
}
******************************
put
/updatepasswd"
{
newPassword
}
******************************
post
"/register"
{
Email
password
firstname
lastname
}
******************************
delete
"/deleteacc"
{

}
******************************
post
"/forgotpassword"
{
Email
}
******************************
put
"/resetPasswordRequest"
{
Email
code
newPassword
}
******************************
get
"/user"
{

}
******************************
post get
"/feedback"
{
feedback
}
******************************
post get
"/history"
{
history
message
}
******************************
post get 
"/notification"
{
message
}*/