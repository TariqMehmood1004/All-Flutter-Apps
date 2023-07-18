// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_sms_autofill/flutter_sms_autofill.dart';
import 'package:get/get.dart';
import 'package:handdle/Auth/signup.dart';
import 'package:handdle/utils/colors.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../Home/home_screen.dart';
import '../utils/constants.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({
    Key? key,
    required this.verificationId,
    required this.phoneNumber,
  }) : super(key: key);

  final String verificationId;
  final String phoneNumber;

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  TextEditingController otpController = TextEditingController();
  StreamController<ErrorAnimationType>? errorController;

  bool hasError = false;
  final formKey = GlobalKey<FormState>();
  String currentOTPCode = '';

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();

    // Set the auto-filled OTP code in the text field
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setAutoFilledCode();
    });
  }

  Future<void> setAutoFilledCode() async {
    try {
      String? code = await SmsAutoFill().getAppSignature.then(
            (signature) => SmsAutoFill().getAppSignature.then(
                  (code) => code,
                ),
          );
      if (code != null) {
        setState(() {
          currentOTPCode = code;
          otpController.text = code;
        });
      }
    } catch (e) {
      Constants.showToast('Failed to retrieve auto-filled OTP code: $e');
    }
  }

  @override
  void dispose() {
    errorController!.close();
    super.dispose();
  }

  // void _verifyOTP() {
  //   FirebaseServices().verifySentOTPCode(
  //     context,
  //     verificationId: widget.verificationId,
  //     verifyOTPCodeController: otpController.text,
  //     phoneNumber: SignUp.phoneNumber,
  //     username: SignUp.userName,
  //   );
  // }

  // void _resendOTP() {
  //   FirebaseServices().createUserWithPhoneNumber(
  //     context: context,
  //     phoneNumber: widget.phoneNumber,
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: GestureDetector(
        onTap: () {
          formKey.currentState!.validate();
          // conditions for validating
          if (currentOTPCode.length != 4 && currentOTPCode != "1234") {
            log("----------------------------------------------------${currentOTPCode.length}");
            errorController!.add(
                ErrorAnimationType.shake); // Triggering error shake animation
            setState(() => hasError = true);
          } else {
            setState(
              () {
                hasError = false;
                Constants.snackBar(context, "OTP Verified!!");
                Get.to(() => const HomeScreen());
              },
            );
          }
        },
        child: Padding(
          padding: EdgeInsets.all(size.width * 0.06),
          child: Container(
            width: size.width,
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50), color: primaryColor),
            child: const Text(
              "Verify",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ),
      ),
      appBar: AppBar(
        title: const Text("Enter OTP Code"),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView(
          children: <Widget>[
            const SizedBox(height: 30),
            SizedBox(
              height: MediaQuery.of(context).size.height / 4,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                // child: Image.asset(Constants.otpGifImage),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'Code has been sent to ${SignUp.phoneNumber.substring(0, 5)}******${SignUp.phoneNumber.substring(SignUp.phoneNumber.length - 2)}',
                style:
                    const TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 60,
                ),
                child: PinCodeTextField(
                  appContext: context,
                  pastedTextStyle: TextStyle(
                    color: primaryColor.withOpacity(0.8),
                    fontWeight: FontWeight.bold,
                  ),
                  length: 4,
                  obscureText: true,
                  obscuringCharacter: '*',
                  blinkWhenObscuring: true,
                  animationType: AnimationType.fade,
                  validator: (v) {
                    if (v!.length < 4) {
                      return "Please fill all the boxes";
                    } else {
                      return null;
                    }
                  },
                  pinTheme: PinTheme(
                    activeColor: primaryColor,
                    selectedFillColor: Colors.white,
                    shape: PinCodeFieldShape.box,
                    selectedColor: primaryColor,
                    errorBorderColor: Colors.red,
                    inactiveColor: Colors.grey,
                    inactiveFillColor: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    fieldHeight: 70,
                    fieldWidth: 60,
                    activeFillColor: Colors.white,
                  ),
                  cursorColor: Colors.black,
                  animationDuration: const Duration(milliseconds: 300),
                  enableActiveFill: true,
                  errorAnimationController: errorController,
                  controller: otpController,
                  keyboardType: TextInputType.number,
                  boxShadows: const [
                    BoxShadow(
                      offset: Offset(0, 1),
                      color: Colors.black12,
                      blurRadius: 10,
                    )
                  ],
                  onCompleted: (v) {
                    debugPrint("Completed");
                  },
                  onTap: () {
                    log("Pressed");
                  },
                  onChanged: (value) {
                    debugPrint(value);
                    setState(() {
                      currentOTPCode = value;
                    });
                  },
                  beforeTextPaste: (text) {
                    debugPrint("Allowing to paste $text");
                    return true;
                  },
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Didn't receive the code? ",
                  style: TextStyle(color: Colors.black54, fontSize: 15),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "RESEND",
                    style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 14,
            ),
          ],
        ),
      ),
    );
  }
}
