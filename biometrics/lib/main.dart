import 'package:biometrics/biometrics_verifier.dart';
import 'package:flutter/material.dart';

void main() => runApp(Biometrics());

class Biometrics extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Biometrics',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(elevation: 0),
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late bool isVerified;

  late BiometricsVerifier verifier;

  @override
  void initState() {
    super.initState();
    isVerified = false;
    verifier = BiometricsVerifier();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isVerified ? 'Verification Complete' : 'Unverified',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            isVerified
                ? TextButton(
                    onPressed: () {
                      setState(() {
                        isVerified = false;
                      });
                    },
                    child: const Text('Unverify'),
                  )
                : TextButton(
                    onPressed: () async {
                      try {
                        await verifier
                            .verifyBiometrics('Please enter your fingerprint');
                        // ---- Add your logic after finger print verification here
                        // ---
                        // ---
                        setState(() {
                          isVerified = true;
                        });
                      } catch (e) {
                        // ---- Verification Failed
                        showDialog(
                          context: context,
                          builder: (c) => AlertDialog(
                            title: const Text('Error !'),
                            content: Text(e.toString()),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Ok'),
                              )
                            ],
                          ),
                        );
                      }
                    },
                    child: const Text('Verify with Fingerprint'),
                  ),
          ],
        ),
      ),
    );
  }
}
