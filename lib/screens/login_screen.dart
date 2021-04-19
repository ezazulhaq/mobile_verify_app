import 'package:flutter/material.dart';
import 'package:mobil_verify_app/components/form_widget.dart';

enum MobileVerificationState {
  SHOW_MOBILE_FORM_SATE,
  SHOW_OTP_FORM_STATE,
}

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  var currentState = MobileVerificationState.SHOW_MOBILE_FORM_SATE;
  final phoneController = TextEditingController();
  final otpController = TextEditingController();

  getMobileFormState(BuildContext context) {
    return FormWidget(
      controller: phoneController,
      hintText: "Phone Number",
      buttonLabel: "SEND",
      press: () {
        print(phoneController.text);
        currentState = MobileVerificationState.SHOW_MOBILE_FORM_SATE;
      },
    );
  }

  getOtpFormState(BuildContext context) {
    return FormWidget(
      controller: otpController,
      hintText: "Enter OTP",
      buttonLabel: "VERIFY",
      press: () {
        print(otpController.text);
        currentState = MobileVerificationState.SHOW_OTP_FORM_STATE;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        child: Container(
          child: currentState == MobileVerificationState.SHOW_MOBILE_FORM_SATE
              ? getMobileFormState(context)
              : getOtpFormState(context),
        ),
      ),
    );
  }
}
