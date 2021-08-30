import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifinepay_police_app/app/components/navigation_bloc.dart';
import 'package:ifinepay_police_app/app/screens/side_nav/components/menu_items.dart';
import 'package:ifinepay_police_app/sizes_helpers.dart';
import 'package:rxdart/rxdart.dart';

import 'clipper.dart';

class SideNavBody extends StatefulWidget {
  @override
  _SideNavBodyState createState() => _SideNavBodyState();
}

class _SideNavBodyState extends State<SideNavBody>
    with SingleTickerProviderStateMixin<SideNavBody> {
  final bool isNavOpened = true;
  final _animationDuration = const Duration(milliseconds: 250);
  AnimationController _animationController;
  StreamController<bool> isNavOpenedStreamController;
  Stream<bool> isNavOpenedStream;
  StreamSink<bool> isNavOpenedSink;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: _animationDuration,
    );
    isNavOpenedStreamController = PublishSubject<bool>();
    isNavOpenedStream = isNavOpenedStreamController.stream;
    isNavOpenedSink = isNavOpenedStreamController.sink;
  }

  @override
  void dispose() {
    _animationController.dispose();
    isNavOpenedStreamController.close();
    isNavOpenedSink.close();
    super.dispose();
  }

  void onIconPressed() {
    final animationStatus = _animationController.status;
    final isAnimationCompleted = animationStatus == AnimationStatus.completed;

    if (isAnimationCompleted) {
      isNavOpenedSink.add(false);
      _animationController.reverse();
    } else {
      isNavOpenedSink.add(true);
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      initialData: false,
      stream: isNavOpenedStream,
      builder: (context, isNavOpenedAsync) {
        return AnimatedPositioned(
          duration: _animationDuration,
          top: 0,
          bottom: 0,
          left: isNavOpenedAsync.data ? 0 : -MediaQuery.of(context).size.width,
          right: isNavOpenedAsync.data
              ? 0
              : MediaQuery.of(context).size.width -
                  displayWidth(context) * 0.07,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: displayWidth(context) * 0.1,),
                  color: Colors.blueAccent,
                  child: Column(
                    children: [
                      SizedBox(
                        height: displayHeight(context) * 0.07,
                      ),
                      Text(
                        "iFinePay",
                        style: TextStyle(
                          fontSize: 45,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Divider(
                        height: 64,
                        thickness: 2,
                        color: Colors.white.withOpacity(0.3),
                        indent: displayWidth(context) * 0.1,
                        endIndent: displayWidth(context) * 0.1,
                      ),
                      MenuItems(
                        icon: Icons.home,
                        title: "Home",
                        onTap: () {
                          onIconPressed();
                          BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.HomePageClickeEvent);
                        },
                      ),
                      SizedBox(
                        height: displayHeight(context) * 0.025,
                      ),
                      MenuItems(
                        icon: Icons.card_membership,
                        title: "Scan license",
                        onTap: () {
                          onIconPressed();
                          BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.ScanLicenseClickeEvent);
                        },
                      ),
                      SizedBox(
                        height: displayHeight(context) * 0.025,
                      ),
                      MenuItems(
                        icon: Icons.pageview,
                        title: "Scan number plate",
                        onTap: () {
                          onIconPressed();
                          BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.ScanNumberPlateClickeEvent);
                        },
                      ),
                      SizedBox(
                        height: displayHeight(context) * 0.025,
                      ),
                      MenuItems(
                        icon: Icons.add_circle,
                        title: "Add fine",
                        onTap: () {
                          onIconPressed();
                          BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.AddFineClickeEvent);
                        },
                      ),
                      SizedBox(
                        height: displayHeight(context) * 0.025,
                      ),
                      Divider(
                        height: 64,
                        thickness: 2,
                        color: Colors.white.withOpacity(0.3),
                        indent: displayWidth(context) * 0.1,
                        endIndent: displayWidth(context) * 0.1,
                      ),
                      SizedBox(
                        height: displayHeight(context) * 0.025,
                      ),
                      MenuItems(
                        icon: Icons.exit_to_app,
                        title: "Logout",
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment(0, -0.9),
                child: GestureDetector(
                  onTap: () {
                    onIconPressed();
                  },
                  child: ClipPath(
                    clipper: CustomMenuClipper(),
                    child: Container(
                      width: 35,
                      height: 100,
                      color: Colors.blueAccent,
                      alignment: Alignment.centerLeft,
                      child: AnimatedIcon(
                        progress: _animationController.view,
                        icon: AnimatedIcons.menu_close,
                        color: Colors.white,
                        size: 25,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}