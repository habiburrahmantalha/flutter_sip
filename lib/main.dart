import 'package:flutter/material.dart';
import 'package:flutter_sip/src/about.dart';
import 'package:flutter_sip/src/callscreen.dart';
import 'package:flutter_sip/src/dialpad.dart';
import 'package:flutter_sip/src/register.dart';
import 'package:sip_ua/sip_ua.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final SIPUAHelper _helper = SIPUAHelper();
  var routes = {
    '/': (helper) => DialPadWidget(helper),
    '/register': (helper) => RegisterWidget(helper),
    '/callscreen': (helper, {arguments}) => CallScreenWidget(helper, arguments),
    '/about': (helper) => AboutWidget(),
  };

  Route<dynamic> _onGenerateRoute(RouteSettings settings) {
    final String name = settings.name;
    final Function pageContentBuilder = routes[name];
    if (pageContentBuilder != null) {
      if (settings.arguments != null) {
        final Route route = MaterialPageRoute(
            builder: (context) =>
                pageContentBuilder(_helper, arguments: settings.arguments));
        return route;
      } else {
        final Route route = MaterialPageRoute(
            builder: (context) => pageContentBuilder(_helper));
        return route;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
      ),
      initialRoute: '/',
      onGenerateRoute: _onGenerateRoute,
    );
  }
}
