import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:task_manager_app/data/network_caller/network_caller.dart';
import 'package:task_manager_app/ui/screens/auth_screee/login_screen.dart';
import 'package:task_manager_app/ui/screens/auth_screee/set_password_screen.dart';
import 'package:task_manager_app/ui/widgets/default_background.dart';
import 'package:task_manager_app/utilities/status_snackbar.dart';
import 'package:task_manager_app/utilities/urls.dart';

class PinVerificationScreen extends StatefulWidget {
  const PinVerificationScreen({super.key, required this.email});
  final String email;

  @override
  State<PinVerificationScreen> createState() => _PinVerificationScreenState();
}

class _PinVerificationScreenState extends State<PinVerificationScreen> {
  String? userEnteredPin;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: DefaultBackGround(
          child: SafeArea(
            child: Padding(
                padding: const EdgeInsets.only(
                    top: 200, left: 50, right: 20, bottom: 20),
                child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Pin Verification",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "A 6 digit verification pin will send to your email address.",
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: Pinput(
                            length: 6,
                            defaultPinTheme: defaultPinTheme,
                            focusedPinTheme: focusedPinTheme,
                            submittedPinTheme: submittedPinTheme,
                            pinputAutovalidateMode:
                                PinputAutovalidateMode.onSubmit,
                            showCursor: true,
                            onCompleted: (pinCode) {
                              userEnteredPin = pinCode;
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (userEnteredPin != null) {
                                final response = await NetworkCaller()
                                    .getRequest(
                                        url: verfiyOtpUrl(
                                            widget.email, userEnteredPin!));
                                if (response.isSuccess) {
                                  if (mounted &&
                                      response.jsonResponse['status'] ==
                                          'fail') {
                                    statusSnackBar(
                                        context,
                                        '${response.jsonResponse["data"]}',
                                        true);
                                  } else {
                                    if (mounted) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                SetPasswordScreen(
                                                    email: widget.email,
                                                    otp: userEnteredPin!),
                                          ));
                                    }
                                  }
                                }
                              }
                            },
                            child: const Text(
                              "Verify",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Center(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Have An Account?",
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginScreen(),
                                      ),
                                      (route) => false);
                                },
                                child: const Text(
                                  "Signin",
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold),
                                ))
                          ],
                        )),
                      ]),
                )),
          ),
        ));
  }
}

final defaultPinTheme = PinTheme(
  width: 56,
  height: 56,
  textStyle: const TextStyle(
      fontSize: 20,
      color: Color.fromRGBO(30, 60, 87, 1),
      fontWeight: FontWeight.w600),
  decoration: BoxDecoration(
    border: Border.all(color: Colors.grey),
    borderRadius: BorderRadius.circular(10),
  ),
);

final focusedPinTheme = defaultPinTheme.copyDecorationWith(
  border: Border.all(color: const Color.fromRGBO(114, 178, 238, 1)),
  borderRadius: BorderRadius.circular(8),
);

final submittedPinTheme = defaultPinTheme.copyWith(
  decoration: defaultPinTheme.decoration?.copyWith(
    color: const Color.fromRGBO(234, 239, 243, 1),
  ),
);
