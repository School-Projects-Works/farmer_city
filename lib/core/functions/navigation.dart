// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import '../../config/router/router_info.dart';

// void navigateToRoute(
//     {required BuildContext context, required RouterInfo route}) async {
//   await Hive.box('route').put('currentRoute', route.name);
//   context.go(route.path);
// }

// void navigateToName(
//     {required BuildContext context,
//     required RouterInfo route,
//     required Map<String, String> parameter}) async {
//   try {
//     await Hive.box('route').put('currentRoute', route.name);
//      context.goNamed(route.name, pathParameters: parameter);
//   }catch(e){
//     print(e);
//   }
// }
