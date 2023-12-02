import 'dart:io';

import 'package:check_vpn_connection/check_vpn_connection.dart';
import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../ui_helpers.dart';

class ConnectivityWidgetWrapperWrapper extends ConnectivityWidgetWrapper {
  ConnectivityWidgetWrapperWrapper(
      {super.key,
      Widget? offlineWidget,
      required super.child,
      super.stacked,
      super.disableInteraction,
      super.message,
      super.height})
      : super(offlineWidget: isIOS ? child : offlineWidget) {
    ConnectivityWrapper.instance.addresses = kIsWeb
        ? <AddressCheckOptions>[]
        : List<AddressCheckOptions>.unmodifiable(
            <AddressCheckOptions>[
              /* AddressCheckOptions(
                hostname: 'duniter.org',
                port: 443,
              ),
              AddressCheckOptions(
                hostname: 'moneda-libre.org',
                port: 443,
              ), */
              // Cloudflare
              AddressCheckOptions(
                address: InternetAddress(
                  '1.1.1.1',
                  type: InternetAddressType.IPv4,
                ),
              ),
              // Cloudflare IPv6
              AddressCheckOptions(
                address: InternetAddress(
                  '2606:4700:4700::1111',
                  type: InternetAddressType.IPv6,
                ),
              ),
              // OpenDNS
              AddressCheckOptions(
                address: InternetAddress(
                  '208.67.222.222',
                  type: InternetAddressType.IPv4,
                ),
              ),
              // OpenDNS IPv6
              AddressCheckOptions(
                address: InternetAddress(
                  '2620:0:ccc::2',
                  type: InternetAddressType.IPv6,
                ),
              ),
              // Quad9 IPv4
              AddressCheckOptions(
                address: InternetAddress(
                  '9.9.9.9',
                  type: InternetAddressType.IPv4,
                ),
              ),
              // Quad9 IPv6
              /*  Disabled for faster check
              AddressCheckOptions(
                address: InternetAddress(
                  '2620:fe::fe',
                  type: InternetAddressType.IPv6,
                ),
              ),
              // DNS.Watch IPv4
              AddressCheckOptions(
                address: InternetAddress(
                  '84.200.69.80',
                  type: InternetAddressType.IPv4,
                ),
              ),
              // DNS.Watch IPv6
              AddressCheckOptions(
                address: InternetAddress(
                  '2001:1608:10:25::1c04:b12f',
                  type: InternetAddressType.IPv6,
                ),
              ),*/
            ],
          );
  }

  @override
  Widget build(BuildContext context) {
    return kIsWeb
        ? super.build(context)
        : FutureBuilder<bool>(
            future: CheckVpnConnection.isVpnActive(),
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                final bool isVpnActive = snapshot.data!;
                if (isVpnActive) {
                  return child;
                } else {
                  return super.build(context);
                }
              } else {
                return super.build(context);
              }
            });
  }

  // This package does not work in IOS so we just return true
  // Also does not detect well in web production mode
  static Future<bool> get isConnected async {
    if (!kIsWeb && await CheckVpnConnection.isVpnActive()) {
      return true;
    }
    return kIsWeb || isIOS
        ? Future<bool>.value(true)
        : ConnectivityWrapper.instance.isConnected;
  }
}
