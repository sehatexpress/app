import 'package:flutter/material.dart' show NavigatorObserver, Route;
import 'package:hooks_riverpod/hooks_riverpod.dart' show WidgetRef;

import '../providers/location_provider.dart' show locationProvider;

class MyNavigatorObserver extends NavigatorObserver {
  final WidgetRef ref;

  MyNavigatorObserver(this.ref);

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    ref.read(locationProvider.notifier).clear();
  }
}
