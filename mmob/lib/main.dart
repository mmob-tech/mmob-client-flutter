import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mmob/models/mmob_customer_info.dart';
import 'package:mmob/models/mmob_integration_configuration.dart';

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

  String _message = 'BOOT';
  Future<void> _mmobBoot() async {
    final bootInfo = MmobIntegrationConfiguration(
        cpId: 'YOUR_CP_ID', integrationId: 'YOUR_CPD_ID', environment: 'prod');
    final userData = MmobCustomerInfo(
      email: 'user@example.com',
      firstName: 'John',
      surname: 'Doe',
      gender: 'Male',
      title: 'Mr.',
      buildingNumber: '123',
      address1: '123 Main St',
      townCity: 'Cityville',
      postcode: '12345',
      dob: '1990-01-01',
    );
    try {
      await methodChannel.invokeMethod('boot', {
        'integration_configuration': bootInfo.toJson(),
        'customer_info': userData.toJson()
      });
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
