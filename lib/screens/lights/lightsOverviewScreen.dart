import 'package:flutter/material.dart';
import 'package:hue_dart/hue_dart.dart';
import 'package:huepersonal/main.dart';
import 'package:huepersonal/widgets/lightListItem.dart';
import 'package:huepersonal/widgets/mainDrawer.dart';

class LightsOverviewScreen extends StatefulWidget {
  static const String routeName = "/lights";

  @override
  _LightsOverviewScreenState createState() => _LightsOverviewScreenState();
}

class _LightsOverviewScreenState extends State<LightsOverviewScreen> {
  List<Light> lights;
  bool _isInit = true;
  bool _isLoading = true;

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      lights = await MyApp.bridge.lights().then((v) {
        setState(() {
          _isLoading = false;
        });
        return v;
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: MainDrawer(),
        appBar: AppBar(
          title: const Text("Lights"),
        ),
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView(children: lights.map((e) => LightListItem(e)).toList()));
  }
}
