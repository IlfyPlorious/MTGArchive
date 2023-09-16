import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:playground/colors.dart';
import 'package:playground/network/exceptions/exceptions.dart';
import 'package:playground/ui/authentication/register.dart';
import 'package:playground/ui/bloc/login/login_cubit.dart';
import 'package:playground/ui/cards_page.dart';
import 'package:playground/ui/partitions/fields/fields.dart';
import 'package:playground/utils/constants.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginPageCubit(),
      child: const LoginPageView(),
    );
  }
}

class LoginPageView extends StatelessWidget {
  const LoginPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginPageCubit, LoginPageState>(
      builder: (context, state) {
        switch (state.status) {
          case Status.initial:
            return LoginPageData(
              email: state.email,
              password: state.password,
              attempts: state.attempts,
            );
          case Status.success:
            return LoginPageData(
              email: state.email,
              password: state.password,
              attempts: state.attempts,
            );
          case Status.loading:
            return LoginPageData(
              email: state.email,
              password: state.password,
              attempts: state.attempts,
            );
          case Status.failure:
            return LoginPageData(
              exception: state.exception,
              email: state.email,
              password: state.password,
              attempts: state.attempts,
            );
          default:
            return const PageLoading();
        }
      },
    );
  }
}

class LoginPageData extends StatelessWidget {
  const LoginPageData(
      {Key? key,
      this.exception,
      required this.email,
      required this.password,
      required this.attempts})
      : super(key: key);

  final FirebaseAuthenticationException? exception;
  final String email;
  final String password;
  final int attempts;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: const [
            Expanded(
              child: Text(
                'Authentication - Login',
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 64,
              ),
              if (exception == null)
                Text(
                  attempts == -1
                      ? 'We have sent you an email at $email'
                      : 'Come, planeswalker! Enter the multiverse!',
                  style: TextStyle(
                    color:
                        attempts == -1 ? Colors.green : CustomColors.blackOlive,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                )
              else
                Text(
                  attempts >= 3
                      ? 'You might want to ask Cody to reset your password.'
                      : exception?.getLoginError ?? 'Hmm...',
                  style: const TextStyle(
                    color: CustomColors.errorRed,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              Image.asset('assets/images/login_hero.png'),
              Container(
                margin: const EdgeInsets.fromLTRB(16, 0, 16, 4),
                child: TextFormField(
                  onChanged: (value) {
                    context.read<LoginPageCubit>().updateFields(email: value);
                  },
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(12, 12, 12, 0),
                    border: OutlineInputBorder(),
                    hintText: 'Email',
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(16, 0, 16, 4),
                child: TextFormField(
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  onChanged: (value) {
                    context
                        .read<LoginPageCubit>()
                        .updateFields(password: value);
                  },
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(12, 12, 12, 0),
                    border: OutlineInputBorder(),
                    hintText: 'Password',
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                constraints: const BoxConstraints(minWidth: 100),
                child: ElevatedButton(
                  onPressed: () {
                    context.read<LoginPageCubit>().signInWithEmailAndPassword();
                  },
                  child: const Text('Login'),
                ),
              ),
              if (attempts >= 3)
                ElevatedButton(
                  onPressed: () {
                    context.read<LoginPageCubit>().sendResetEmail(email);
                  },
                  child: const Text('Send password reset email'),
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?"),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RegisterPage()),
                        );
                      },
                      child: const Text(
                        'Register here!',
                        style: TextStyle(color: CustomColors.orange),
                      ))
                ],
              ),
              SignInButton(Buttons.Google, onPressed: () {
                context.read<LoginPageCubit>().signInWithGoogle();
              }),
              const SizedBox(
                height: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
