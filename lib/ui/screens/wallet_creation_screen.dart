import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ginkgo/services/multipass_service.dart';
import 'package:ginkgo/ui/logger.dart';
class WalletCreationScreen extends StatefulWidget {
  const WalletCreationScreen({super.key});

  @override
  State<WalletCreationScreen> createState() => _WalletCreationScreenState();
}

class _WalletCreationScreenState extends State<WalletCreationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  bool _isLoading = false;
  String? _statusMessage;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _createWallet() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
      _statusMessage = 'Getting location...';
    });

    try {
      // Get location
      final Position position = await _determinePosition();
      
      setState(() {
        _statusMessage = 'Creating MULTIPASS...';
      });

      await MultipassService.createWallet(
        email: _emailController.text.trim(),
        lat: position.latitude,
        lon: position.longitude,
        lang: context.locale.languageCode,
      );

      if (!mounted) return;

      // Navigate to main app (AppStart will now see a wallet and show FirstScreen)
      // We can pushReplacement to AppStart or just pop if we were pushed on top
      // But since we are replacing the intro flow, we should probably restart the app structure
      // or navigate to '/'
      Navigator.of(context).pushReplacementNamed('/');
      
    } catch (e) {
      logger('Error creating wallet: $e');
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Error'),
          content: Text(e.toString()),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _statusMessage = null;
        });
      }
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create MULTIPASS'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Welcome to Ginkgo',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              const Text(
                'To create your wallet, please enter your email address. We also need your location to initialize your UPlanet coordinates.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              if (_isLoading)
                Column(
                  children: <Widget>[
                    const CircularProgressIndicator(),
                    const SizedBox(height: 10),
                    Text(_statusMessage ?? 'Processing...'),
                  ],
                )
              else
                ElevatedButton(
                  onPressed: _createWallet,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text('Create Wallet'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
