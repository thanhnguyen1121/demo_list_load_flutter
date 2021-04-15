import 'dart:async';

import 'package:vbee_app/app/model/User.dart';

class HomeController {
  var homeEventController = StreamController<User>();
}

class HomeEvent {}

class HomeState {}
