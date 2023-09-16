import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:playground/colors.dart';
import 'package:playground/network/exceptions/exceptions.dart';
import 'package:playground/ui/bloc/register/register_cubit.dart';
import 'package:playground/ui/cards_page.dart';
import 'package:playground/utils/constants.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterPageCubit(),
      child: const RegisterPageView(),
    );
  }
}

class RegisterPageView extends StatelessWidget {
  const RegisterPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterPageCubit, RegisterPageState>(
      builder: (context, state) {
        switch (state.status) {
          case Status.initial:
            return RegisterPageData(
              email: state.email,
              password: state.password,
            );
          case Status.success:
            Navigator.pop(context);
            return const Expanded(child: PageLoading());
          case Status.loading:
            return RegisterPageData(
              email: state.email,
              password: state.password,
            );
          case Status.failure:
            return RegisterPageData(
              exception: state.exception,
              email: state.email,
              password: state.password,
            );
          default:
            return const Expanded(child: PageLoading());
        }
      },
    );
  }
}

class RegisterPageData extends StatelessWidget {
  const RegisterPageData(
      {Key? key, this.exception, required this.email, required this.password})
      : super(key: key);

  final FirebaseAuthenticationException? exception;
  final String email;
  final String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: Container(
          height: 20,
          width: 20,
          margin: const EdgeInsets.all(15),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            iconSize: 20,
            padding: const EdgeInsets.all(0),
            icon: Image.asset('assets/images/back_arrow_light.png'),
          ),
        ),
        title: Row(
          children: const [
            Expanded(
              child: Text(
                'Authentication - Register',
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
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                        margin: const EdgeInsets.all(8),
                        constraints: const BoxConstraints(maxHeight: 200),
                        child: Image.asset('assets/images/codie.png')),
                  ),
                  if (exception == null)
                    Container(
                      constraints:
                          const BoxConstraints(minWidth: 200, maxWidth: 250),
                      margin: const EdgeInsets.all(8),
                      child: const Text(
                        'Aaah, a newcomer! Let me register you....',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    )
                  else
                    Container(
                      constraints:
                          const BoxConstraints(minWidth: 200, maxWidth: 250),
                      margin: const EdgeInsets.all(8),
                      child: Text(
                        exception?.getRegisterError ?? 'Hmm...',
                        style: const TextStyle(
                          color: CustomColors.errorRed,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                ],
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(16, 0, 16, 4),
                child: TextFormField(
                  onChanged: (value) {
                    context
                        .read<RegisterPageCubit>()
                        .updateFields(email: value);
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
                        .read<RegisterPageCubit>()
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
                    context
                        .read<RegisterPageCubit>()
                        .registerWithEmailAndPassword();
                  },
                  child: const Text('Register'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
