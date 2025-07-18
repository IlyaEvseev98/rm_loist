import 'package:flutter/material.dart';

import '../network/rest_client.dart';

class ClientProvider extends InheritedWidget {
  const ClientProvider({super.key, required this.client, required super.child});

  final RestClient client;

  static ClientProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ClientProvider>()!;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }
}
