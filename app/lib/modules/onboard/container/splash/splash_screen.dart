import 'package:app/modules/common/components/base_screen/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/splash_bloc.dart';
import 'models/splash_argument.dart';

part 'splash_screen_body.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({
    super.key,
    this.argument,
  });
  final SplashArgument? argument;
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      configs: BaseScreenConfigs(
        scaffoldConfigs: ScaffoldConfigs(
          body: BlocProvider(
            create: (context) => SplashBloc(),
            child: _SplashScreenBody(argument: argument),
          ),
        ),
      ),
    );
  }
}
