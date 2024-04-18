import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_bitybank/auth/signin_screen.dart';
import 'package:flutter_bitybank/auth/signup_screen.dart';

class AuthenticatorScreen extends StatelessWidget {
  const AuthenticatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: Scaffold(
            body: NestedTabBar("ACESSO")
        ));
    // const SignInScreen(title: "Login");
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
      children: <Widget>[
        Card(
          color: Colors.black,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8.0),
              ),
            ),
        margin: const EdgeInsets.only(left: 16.0, top: 32.0, right: 16.0, bottom: 16.0),
        child: TabBar.secondary(
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white
          ),
            controller: _tabController,
            padding: const EdgeInsets.all(8.0),
            tabs: const [
              Tab(text: 'ACESSO'),
              Tab(text: 'CADASTRO')]
        )),
        Expanded(child: TabBarView(
          controller: _tabController,
          children: const [
             Card(
              child: SignInScreen(title: "ACESSO"),
            ),
            Card(
              child: SignUpScreen(title: "CADASTRO"),
            ),
          ],
        ))
      ],
    );
  }
}
