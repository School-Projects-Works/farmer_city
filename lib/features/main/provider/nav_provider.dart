import 'package:firmer_city/config/router/router_info.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

final navProvider = StateProvider<String>((ref) =>
    Hive.box('route').get('currentRoute') != null
        ? Hive.box('route').get('currentRoute').toString()
        : RouterInfo.homeRoute.name);
