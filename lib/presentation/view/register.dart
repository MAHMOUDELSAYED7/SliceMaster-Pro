import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/utils/extension/extension.dart';
import '../../core/utils/helpers/my_snackbar.dart';
import '../../core/widgets/custom_button.dart';
import '../../core/widgets/custom_text_field.dart';
import '../controllers/register/register_cubit.dart';
import 'widgets/auth_background.dart';
import 'widgets/auth_headline.dart';
import 'widgets/text_and_btn.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _passwordController = TextEditingController();
    super.initState();
  }

  late GlobalKey<FormState> _formKey;
  late TextEditingController _passwordController;

  String? _validatePassword(value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    } else if (value != _passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  String? _username;
  String? _password;
  void _register() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      debugPrint('Username: $_username, Password: $_password');
      context.cubit<RegisterCubit>().register(_username!, _password!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthBackground(
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 54.h),
              const AuthHeadline(
                firstText: 'Create an ',
                secondText: 'Account',
                smallText: true,
              ),
              SizedBox(height: 12.h),
              Text('Please set a strong username and password.',
                  style: context.textTheme.displaySmall),
              SizedBox(height: 30.h),
              MyTextFormField(
                onSaved: (data) => _username = data,
                title: 'Username',
                hintText: 'Enter your Username',
              ),
              SizedBox(height: 10.h),
              MyTextFormField(
                controller: _passwordController,
                keyboardType: TextInputType.visiblePassword,
                hintText: 'Enter your Password',
                title: 'Password',
              ),
              SizedBox(height: 10.h),
              MyTextFormField(
                onSaved: (data) => _password = data,
                keyboardType: TextInputType.visiblePassword,
                hintText: 'Confirm your Password',
                title: 'Confirm Password',
                obscureText: true,
                validator: _validatePassword,
              ),
              SizedBox(height: 40.h),
              BlocListener<RegisterCubit, RegisterState>(
                listener: (context, state) {
                  if (state is RegisterSuccess) {
                    customSnackBar(context, 'Registration success, Login now!');
                    Navigator.pop(context);
                  }
                  if (state is RegisterFailure) {
                    customSnackBar(context, 'Registration failed!');
                  }
                  if (state is UsernameTaken) {
                    customSnackBar(context, 'Username already taken!');
                  }
                },
                child: MyElevatedButton(
                  title: 'Register',
                  onPressed: _register,
                ),
              ),
              SizedBox(height: 30.h),
              TextAndButton(
                buttonText: 'Sign In',
                text: 'Already have an account? ',
                onTap: () => Navigator.pop(context),
              ),
              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }
}
