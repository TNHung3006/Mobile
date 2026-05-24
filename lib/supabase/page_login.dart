import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';
import 'package:get/get.dart';

class PageLogin extends StatelessWidget {
  const PageLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Page login Supabase"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SupaEmailAuth(
            onSignInComplete: (response) {
              if(response.user != null){
                Get.back();
              }
            },
            onSignUpComplete: (response) {
              if(response?.user!=null){
                Get.to(() => PageVertifyUser(email: response!.user!.email!));
              }
            },
            showConfirmPasswordField: true,
          )
        ],
      ),
    );
  }
}

class PageVertifyUser extends StatelessWidget {
  PageVertifyUser({super.key, required this.email});
  String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Xac thuc nguoi dung"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          OtpTextField(
              numberOfFields: 6,
              borderColor: Colors.black,
              showFieldAsBox: true,
              borderWidth: 4.0,
              fieldWidth: 45,
              onCodeChanged: (String code) {
              },
              onSubmit: (String verificationCode) async {
                var respone = await Supabase.instance.client.auth
                    .verifyOTP(
                  email: email,
                  token: verificationCode,
                  type: OtpType.email,
                );
                if (respone.session != null && respone.session?.user != null) {
                  Get.close(2);
                }
              }
          ),
        ],
      ),
    );
  }
}

class PageThongTinUser extends StatelessWidget {
  const PageThongTinUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Thong tin khach hang"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
    );
  }
}