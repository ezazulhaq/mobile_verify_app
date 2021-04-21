import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobil_verify_app/components/button_widget.dart';
import 'package:mobil_verify_app/screens/home_screen.dart';

enum MobileVerificationState {
  SHOW_MOBILE_FORM_SATE,
  SHOW_OTP_FORM_STATE,
}

// ignore: must_be_immutable
class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  MobileVerificationState currentState =
      MobileVerificationState.SHOW_MOBILE_FORM_SATE;

  final phoneController = TextEditingController();

  final otpController = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;

  String? verificationId;
  bool showLoading = false;

  getMobileFormState(BuildContext context) {
    return Column(
      children: [
        Spacer(),
        TextField(
          controller: phoneController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: "Phone Number",
          ),
        ),
        SizedBox(
          height: 16,
        ),
        TextButton(
          onPressed: () async {
            setState(() {
              showLoading = true;
            });

            await _auth.verifyPhoneNumber(
              phoneNumber: phoneController.text,
              verificationCompleted: (verificationCompleted) {
                setState(() {
                  showLoading = false;
                });
              },
              verificationFailed: (verificationFailed) async {
                setState(() {
                  showLoading = false;
                });
                _scaffoldKey.currentState!.showSnackBar(
                    SnackBar(content: Text(verificationFailed.message!)));
              },
              codeSent: (verificationId, resendingToken) {
                setState(() {
                  showLoading = false;
                  currentState = MobileVerificationState.SHOW_MOBILE_FORM_SATE;
                  this.verificationId = verificationId;
                });
              },
              codeAutoRetrievalTimeout: (verificationId) {},
            );
          },
          child: ButtonWidget(
            buttonLabel: "SEND",
          ),
        ),
        Spacer(),
      ],
    );
  }

  getOtpFormState(BuildContext context) {
    return Column(
      children: [
        Spacer(),
        TextField(
          controller: otpController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: "Enter OTP",
          ),
        ),
        SizedBox(
          height: 16,
        ),
        TextButton(
          onPressed: () {
            PhoneAuthCredential phoneAuthCredential =
                PhoneAuthProvider.credential(
                    verificationId: verificationId!,
                    smsCode: otpController.text);

            signInWithPhoneAuthCredentials(phoneAuthCredential);
          },
          child: ButtonWidget(
            buttonLabel: "VERIFY",
          ),
        ),
        Spacer(),
      ],
    );
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        child: Container(
          child: showLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : currentState == MobileVerificationState.SHOW_MOBILE_FORM_SATE
                  ? getMobileFormState(context)
                  : getOtpFormState(context),
        ),
      ),
    );
  }

  void signInWithPhoneAuthCredentials(
      PhoneAuthCredential phoneAuthCredential) async {
    setState(() {
      showLoading = false;
    });
    try {
      final authCredentials =
          await _auth.signInWithCredential(phoneAuthCredential);

      setState(() {
        showLoading = false;
        if (authCredentials.user != null) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomeScreen()));
        }
      });
    } on FirebaseAuthException catch (e) {
      setState(() {
        showLoading = false;
      });

      _scaffoldKey.currentState!
          .showSnackBar(SnackBar(content: Text(e.message!)));
    }
  }
}
