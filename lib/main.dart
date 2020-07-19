// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pagotometer/bloc/location_bloc.dart';
import 'package:pagotometer/bloc/location_bloc_observer.dart';
import 'package:pagotometer/pages/page_container.dart';
import 'package:pagotometer/style/styles.dart';

void main() {
  Bloc.observer = LocationBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Pagotometer';

    return BlocProvider<LocationBloc>(
        create: (context) =>
            LocationBloc(geolocator: Geolocator())..add(LocationStarted()),
        child: MaterialApp(
            title: appTitle,
            home: PageContainer(title: appTitle),
            theme: ThemeData(
              // Define the default brightness and colors.
              brightness: Brightness.dark,
              primaryColor: AppColor.midnightPurple,
              accentColor: Colors.cyan[600],
              cardColor: AppColor.lightPurple,

              // Define the default font family.
              fontFamily: 'Avenir Next',

              // Define the default TextTheme. Use this to specify the default
              // text styling for headlines, titles, bodies of text, and more.
              textTheme: TextTheme(
                headline1:
                    TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
                headline6:
                    TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
                bodyText2: TextStyle(
                    fontSize: 20.0,
                    fontFamily: 'Avenir Next',
                    fontWeight: FontWeight.w300),
              ),
            )));
  }
}
