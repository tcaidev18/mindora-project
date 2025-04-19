part of 'splash_screen.dart';

class _SplashScreenBody extends StatefulWidget {
  const _SplashScreenBody({
    this.argument,
  });
  final SplashArgument? argument;
  @override
  State<_SplashScreenBody> createState() => __SplashScreenBodyState();
}

class __SplashScreenBodyState extends State<_SplashScreenBody> {
  late final bloc = context.read<SplashBloc>();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text("Hello")),
    );
  }
}
