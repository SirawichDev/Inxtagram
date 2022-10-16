import 'package:bloc_medium_scale_project/repositories/auth/auth_repository.dart';
import 'package:bloc_medium_scale_project/screens/login/cubit/login_cubit.dart';
import 'package:bloc_medium_scale_project/screens/signup/cubit/signup_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupScreen extends StatefulWidget {
  static const String routeName = '/signup';

  SignupScreen({Key? key}) : super(key: key);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  static Route route() {
    return PageRouteBuilder(
        settings: const RouteSettings(name: routeName),
        pageBuilder: (context, _, __) => BlocProvider<SignupCubit>(
              create: (_) =>
                  SignupCubit(authRepository: context.read<AuthRepository>()),
              child: SignupScreen(),
            ));
  }
  @override
  SignupScreenStateful createState() => SignupScreenStateful();
}

class SignupScreenStateful extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
