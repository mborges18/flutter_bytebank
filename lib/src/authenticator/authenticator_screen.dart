import 'dart:core';
import 'package:flutter/material.dart';
import '../../util/string/strings.dart';
import 'signin/ui/signin_screen.dart';
import 'signup/ui/signup_screen.dart';

class AuthenticatorScreen extends StatelessWidget {
  const AuthenticatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: Scaffold(body: NestedTabBar(titleAccess)));
  }
}

class NestedTabBar extends StatefulWidget {
  const NestedTabBar(this.titleTabs, {super.key});
  final String titleTabs;
  @override
  State<NestedTabBar> createState() => _NestedTabBarState();
}

class _NestedTabBarState extends State<NestedTabBar> with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[tabView(), tabViewPager()],
    );
  }

  Widget tabView() {
    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.primary,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
      ),
      margin: const EdgeInsets.only(
          left: 16.0, top: 60.0, right: 16.0, bottom: 16.0),
      child: TabBar.secondary(
        indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(8), color: Theme.of(context).colorScheme.onPrimary),
        controller: _tabController,
        padding: const EdgeInsets.all(8.0),
        tabs: [
          Padding(
              padding: const EdgeInsets.only(top: 3),
              child: Tab(text: titleAccess.toUpperCase())),
          Padding(
              padding: const EdgeInsets.only(top: 3),
              child: Tab(text: titleRegister.toUpperCase()))
        ],
        dividerColor: Theme.of(context).colorScheme.primary,
        unselectedLabelColor: Theme.of(context).colorScheme.onPrimary,
        labelColor: Colors.black,
      ),
    );
  }

  Widget tabViewPager() {
    return Expanded(
        child: TabBarView(
      controller: _tabController,
      children: const [
        SignInScreen(),
        SignUpScreen()
      ],
    ));
  }
}
