import 'package:bloc_medium_scale_project/repositories/auth/auth_repository.dart';
import 'package:bloc_medium_scale_project/screens/login/cubit/login_cubit.dart';
import 'package:bloc_medium_scale_project/screens/nav/nav_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';

  LoginScreen({Key? key}) : super(key: key);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  static Route route() {
    return PageRouteBuilder(
        settings: const RouteSettings(name: routeName),
        transitionDuration: const Duration(seconds: 0),
        pageBuilder: (context, _, __) => BlocProvider<LoginCubit>(
              create: (_) =>
                  LoginCubit(authRepository: context.read<AuthRepository>()),
              child: LoginScreen(),
            ));
  }

  @override
  LoginScreenStateful createState() => LoginScreenStateful();
}

class LoginScreenStateful extends State<LoginScreen> {
  bool passwordVisible = true;

  void _toggle() {
    setState(() {
      passwordVisible = !passwordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: BlocConsumer<LoginCubit, LoginState>(listener: (context, state) {
          if (state.status == LoginStatus.error) {
            showDialog(
                context: (context),
                builder: (context) => AlertDialog(
                    title: const Text('error'),
                    content: Text(state.failure.message ?? "")));
          }
        }, builder: (context, state) {
          return Scaffold(
              resizeToAvoidBottomInset: false,
              body: Center(
                child: Card(
                  shadowColor: Colors.white,
                  color: Colors.white,
                  child: Form(
                    key: widget._formKey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/images/logo.png'),
                          const SizedBox(
                            height: 20.0,
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              isDense: true,
                              filled: true,
                              fillColor: Color.fromRGBO(250, 250, 250, 1),
                              hintText: 'Email',
                              hintStyle: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14.0,
                                color: Color.fromRGBO(0, 0, 0, 0.2),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromRGBO(0, 0, 0, 0.1),
                                  width: .5,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromRGBO(0, 0, 0, 0.1),
                                  width: .5,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromRGBO(0, 0, 0, 0.1),
                                  width: .5,
                                ),
                              ),
                            ),
                            onChanged: (value) =>
                                context.read<LoginCubit>().emailChanged(value),
                            validator: (value) => !value!.contains('@')
                                ? 'Please input correct Email.'
                                : null,
                          ),
                          const SizedBox(
                            height: 12.0,
                          ),
                          TextFormField(
                            obscureText: passwordVisible,
                            enableSuggestions: false,
                            decoration: InputDecoration(
                                isDense: true,
                                filled: true,
                                fillColor:
                                    const Color.fromRGBO(250, 250, 250, 1),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromRGBO(0, 0, 0, 0.1),
                                    width: .5,
                                  ),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromRGBO(0, 0, 0, 0.1),
                                    width: .5,
                                  ),
                                ),
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromRGBO(0, 0, 0, 0.1),
                                    width: .5,
                                  ),
                                ),
                                hintText: 'Password',
                                hintStyle: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.0,
                                  color: Color.fromRGBO(0, 0, 0, 0.2),
                                ),
                                suffixIcon: IconButton(
                                    onPressed: _toggle,
                                    icon: Icon(passwordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off))),
                            onChanged: (value) => context
                                .read<LoginCubit>()
                                .passwordChanged(value),
                            validator: (value) => value!.length < 7
                                ? 'Password Must be least 6 characters.'
                                : null,
                          ),
                          const SizedBox(
                            height: 19.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: const [
                              Text(
                                'Forgot password?',
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  letterSpacing: .15,
                                  fontSize: 12.0,
                                  color: Color.fromRGBO(55, 151, 239, 1),
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 30.0,
                          ),
                          SizedBox(
                            height: 44,
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: context
                                          .read<LoginCubit>()
                                          .isFulFieldForm
                                      ? const Color.fromRGBO(55, 151, 239, 1)
                                      : Colors.grey.shade200,
                                  shadowColor: Colors.transparent,
                                  side: const BorderSide(
                                      color: Colors.transparent),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5))),
                              onPressed: () {
                                context.read<LoginCubit>().isFulFieldForm
                                    ? _submitForm(context,
                                        state.status == LoginStatus.submitting)
                                    : null;
                              },
                              child: const Text('Login'),
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ElevatedButton.icon(
                                  label: const Text(
                                    'Log in with Facebook',
                                    style: TextStyle(
                                        color: Color.fromRGBO(55, 151, 239, 1)),
                                  ),
                                  icon: const Icon(
                                    Icons.facebook,
                                    color: Color.fromRGBO(55, 151, 239, 1),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      side: const BorderSide(
                                          color: Colors.transparent),
                                      shadowColor: Colors.transparent),
                                  onPressed: () {})
                            ],
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                    margin: const EdgeInsets.only(
                                        left: 10.0, right: 20.0),
                                    child: const Divider(
                                      color: Color.fromRGBO(0, 0, 0, 0.2),
                                      height: 20,
                                    )),
                              ),
                              const Text(
                                "OR",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Color.fromRGBO(0, 0, 0, 0.4)),
                              ),
                              Expanded(
                                child: Container(
                                    margin: const EdgeInsets.only(
                                        left: 20.0, right: 10.0),
                                    child: const Divider(
                                      color: Color.fromRGBO(0, 0, 0, 0.2),
                                      height: 20,
                                    )),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Don’t have an account ?',
                                style: TextStyle(
                                    color: Color.fromRGBO(0, 0, 0, 0.4)),
                              ),
                              Padding(
                                padding: EdgeInsets.zero,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                        backgroundColor: Colors.white,
                                        side: const BorderSide(
                                            color: Colors.transparent),
                                        shadowColor: Colors.transparent),
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) => const AlertDialog(
                                                content: Text('fff'),
                                              ));
                                    },
                                    child: const Text(
                                      'Sign up.',
                                      style: TextStyle(
                                        color: Color.fromRGBO(55, 151, 239, 1),
                                      ),
                                    )),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ));
        }),
      ),
    );
  }

  void _submitForm(BuildContext context, bool isSubmitting) {
    if (widget._formKey.currentState!.validate() && !isSubmitting) {
      context.read<LoginCubit>().logInWithCredentials();
    }
  }
}
