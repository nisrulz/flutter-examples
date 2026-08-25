import 'package:flutter/material.dart';
import '../../misc/colors.dart';

class CustomScaffold extends StatelessWidget {
  final String? title;
  final Widget body;
  final EdgeInsetsGeometry? padding;
  final bool hideAppBar;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final Widget? drawer;
  final PreferredSizeWidget? appBar;
  final Color? appBarColor;
  final List<Widget>? appBarActions;
  final PreferredSizeWidget? bottom;
  final bool safeArea;

  const CustomScaffold({
    super.key,
    this.title,
    required this.body,
    this.padding,
    this.hideAppBar = false,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.drawer,
    this.appBar,
    this.appBarColor,
    this.appBarActions,
    this.bottom,
    this.safeArea = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawer,
      appBar: hideAppBar
          ? null
          : appBar ??
              AppBar(
                title: title != null ? Text(title!) : null,
                backgroundColor: appBarColor ?? CustomColors.primary,
                actions: appBarActions,
                bottom: bottom,
              ),
      body: Padding(
        padding: padding ?? EdgeInsets.zero,
        child: safeArea ? SafeArea(child: body) : body,
      ),
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
    );
  }
}
