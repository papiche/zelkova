import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/models/app_cubit.dart';
import '../../g1/multipass_service.dart';
import '../../shared_prefs_helper_v2.dart';

void showMultipassOnboardingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) => const MultipassOnboardingDialog(),
  );
}

class MultipassOnboardingDialog extends StatefulWidget {
  const MultipassOnboardingDialog({super.key});

  @override
  State<MultipassOnboardingDialog> createState() =>
      _MultipassOnboardingDialogState();
}

class _MultipassOnboardingDialogState extends State<MultipassOnboardingDialog> {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String? _errorMessage;
  String _lat = '';
  String _lon = '';
  bool _geolocated = false;
  MultipassResponse? _result;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _requestGeolocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        // User refused geolocation — use 0.00, 0.00
        setState(() {
          _lat = '0.00';
          _lon = '0.00';
          _geolocated = true;
          _errorMessage = null;
        });
        return;
      }
      final Position position = await Geolocator.getCurrentPosition(
        locationSettings:
            const LocationSettings(accuracy: LocationAccuracy.low),
      );
      setState(() {
        // Precision 0.01° (~1.1 km) for UMAP grid
        _lat = position.latitude.toStringAsFixed(2);
        _lon = position.longitude.toStringAsFixed(2);
        _geolocated = true;
        _errorMessage = null;
      });
    } catch (e) {
      // Geolocation error — fallback to 0.00, 0.00
      setState(() {
        _lat = '0.00';
        _lon = '0.00';
        _geolocated = true;
        _errorMessage = null;
      });
    }
  }

  Future<void> _createMultipass() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final MultipassResponse response =
          await MultipassService.createMultipass(
        email: _emailController.text.trim(),
        lang: context.locale.languageCode,
        lat: _lat,
        lon: _lon,
      );

      // Create the wallet from salt/pepper
      await SharedPreferencesHelperV2().createMultipassAccount(
        salt: response.salt,
        pepper: response.pepper,
        nsec: response.nsec,
        npub: response.npub,
        nostrns: response.nostrns,
        ssssPlayer: response.ssssPlayer,
        email: response.email,
      );

      setState(() {
        _result = response;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_result != null) {
      return _buildSuccessView(context);
    }
    return _buildFormView(context);
  }

  Widget _buildFormView(BuildContext context) {
    return AlertDialog(
      title: Text(tr('multipass_onboarding_title')),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(tr('multipass_onboarding_description')),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: tr('email'),
                  prefixIcon: const Icon(Icons.email),
                ),
                validator: (String? value) {
                  if (value == null || value.trim().isEmpty) {
                    return tr('email_required');
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+$')
                      .hasMatch(value.trim())) {
                    return tr('email_invalid');
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              if (!_geolocated)
                ElevatedButton.icon(
                  onPressed: _isLoading ? null : _requestGeolocation,
                  icon: const Icon(Icons.my_location),
                  label: Text(tr('get_location')),
                )
              else
                Chip(
                  avatar: const Icon(Icons.location_on, size: 18),
                  label: Text('$_lat, $_lon'),
                ),
              if (_errorMessage != null) ...<Widget>[
                const SizedBox(height: 8),
                Text(
                  _errorMessage!,
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              ],
            ],
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: _isLoading ? null : () => Navigator.of(context).pop(),
          child: Text(tr('cancel')),
        ),
        if (_isLoading)
          const Padding(
            padding: EdgeInsets.all(8),
            child: SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          )
        else
          ElevatedButton(
            onPressed: _createMultipass,
            child: Text(tr('create_multipass')),
          ),
      ],
    );
  }

  Widget _buildSuccessView(BuildContext context) {
    return AlertDialog(
      title: Text(tr('multipass_created_title')),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(tr('multipass_created_description')),
            const SizedBox(height: 16),
            Text(
              tr('choose_subscription'),
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 8),
            ListTile(
              leading: const Icon(Icons.satellite_alt),
              title: const Text('Satellite (128 Go)'),
              subtitle: Text(tr('subscription_satellite_desc')),
              onTap: () => _openSubscription(
                'https://opencollective.com/monnaie-libre/projects/coeurbox/contribute/parrainage-infrastructure-extension-128-go-98386',
              ),
              trailing: const Icon(Icons.open_in_new),
            ),
            ListTile(
              leading: const Icon(Icons.memory),
              title: const Text('GPU (max)'),
              subtitle: Text(tr('subscription_gpu_desc')),
              onTap: () => _openSubscription(
                'https://opencollective.com/monnaie-libre/projects/coeurbox/contribute/parrainage-infrastructure-module-gpu-1-24-98385',
              ),
              trailing: const Icon(Icons.open_in_new),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
            context.read<AppCubit>().setHasRecentExport(false);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(tr('wallet_created_successfully'))),
            );
          },
          child: Text(tr('done')),
        ),
      ],
    );
  }

  Future<void> _openSubscription(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
