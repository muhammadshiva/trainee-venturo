import 'package:coffee_app/constants/core/asset_const.dart';
import 'package:coffee_app/modules/features/login/controllers/login_controller.dart';
import 'package:coffee_app/modules/features/login/view/components/divider_with_text.dart';
import 'package:coffee_app/modules/features/login/view/components/login_button_google.dart';
import 'package:coffee_app/modules/features/login/view/components/text_field_email.dart';
import 'package:coffee_app/modules/features/login/view/components/text_field_password.dart';
import 'package:coffee_app/shared/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AssetConst.bgPattern1),
            fit: BoxFit.fitHeight,
            alignment: Alignment.center,
          ),
        ),
        child: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 30.r),
            children: [
              // Logo
              80.verticalSpacingRadius,
              Image.asset(AssetConst.iconJavaCode, width: 0.8.sw),
              120.verticalSpacingRadius,

              /// Heading
              Text(
                'Continue to sign in'.tr,
                style: Get.textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              40.verticalSpacingRadius,

              /// Email
              TextFieldEmail(controller: _emailController),
              20.verticalSpacingRadius,

              /// Password
              TextFieldPassword(controller: _passwordController),
              40.verticalSpacingRadius,

              /// Login Button
              PrimaryButton(
                text: 'Login'.tr,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    LoginController.to.loginWithEmailAndPassword(
                      _emailController.text,
                      _passwordController.text,
                    );
                  }
                },
              ),

              70.verticalSpacingRadius,
              const DividerWithText('or'),
              20.verticalSpacingRadius,

              /// Google Button
              LoginButtonGoogle(
                onPressed: () {},
              ),

              // LoginButtonGoogle(onPressed: LoginController.to.loginWithGoogle),
              15.verticalSpacingRadius,
            ],
          ),
        ),
      ),
    );
  }
}