import 'package:flutter/cupertino.dart';
import 'views/login_view.dart';


Map<String, WidgetBuilder> getAppRoutes() {
  return {
    '/login': (context) => const LoginView(),
  };
}