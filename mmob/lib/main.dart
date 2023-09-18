import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './models/mmob_customer_info.dart';
import 'models/mmob_integration_configuration.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chase EF Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Chase EF Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const methodChannel = MethodChannel('com.client.mmob/methodChannel');

  String _message = 'Test';

  Future<void> _mmobBoot() async {
    try {
      var messageFromNative = await methodChannel.invokeMethod('boot', {
        "customerInfo": MmobCustomerInfo(email: "test@test.com"),
        "configuration":
            MmobIntegrationConfiguration(cp_id: "test", integration_id: "test")
      });
      // setState(() {
      //   _message = messageFromAndroid.toString();
      // });
    } on PlatformException catch (e) {
      print(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Click the Button to Boot',
            ),
            Text(
              _message,
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _mmobBoot,
        tooltip: 'Boot MMOB',
        child: const Icon(Icons.add),
      ),
    ));
  }
}
