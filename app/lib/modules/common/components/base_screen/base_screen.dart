import 'package:flutter/material.dart';

part './models/base_screen_configs.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({
    super.key,
    required this.configs,
  });
  final BaseScreenConfigs configs;
  ScaffoldConfigs? get scaffoldConfigs => configs.scaffoldConfigs;
  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.scaffoldConfigs?.appBar,
      body: widget.scaffoldConfigs?.body,
      bottomNavigationBar: widget.scaffoldConfigs?.bottomNavigationBar,
    );
  }
}
