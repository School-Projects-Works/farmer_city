import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthMainPage extends ConsumerStatefulWidget {
  const AuthMainPage({required this.child, this.shellContext, super.key});
  final Widget child;
  final BuildContext? shellContext;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AuthMainPageState();
}

class _AuthMainPageState extends ConsumerState<AuthMainPage> {
  @override
  Widget build(BuildContext context) {
    // var loginStream = ref.watch(loginProviderStream);
    return SafeArea(
      child: Scaffold(
        body: widget.child,
      ),
    );
  }
}
