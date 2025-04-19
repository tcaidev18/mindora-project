part of '../base_screen.dart';

class BaseScreenConfigs {
  const BaseScreenConfigs({
    this.scaffoldConfigs,
  });
  final ScaffoldConfigs? scaffoldConfigs;

  BaseScreenConfigs copyWith() {
    return const BaseScreenConfigs();
  }
}

class ScaffoldConfigs {
  final PreferredSizeWidget? appBar;
  final Widget? body;
  final Widget? bottomNavigationBar;
  const ScaffoldConfigs({
    this.appBar,
    this.body,
    this.bottomNavigationBar,
  });

  ScaffoldConfigs copyWith() {
    return const ScaffoldConfigs();
  }
}
