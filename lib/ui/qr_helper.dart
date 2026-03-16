import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../g1/g1_helper.dart';
import '../g1/zen_tag_service.dart';
import 'clipboard_helper.dart';
import 'ui_helpers.dart';

void showQrDialog({
  required BuildContext context,
  required String pubKeyOrAddress,
  required bool isV2,
  bool noTitle = false,
  String? feedbackText,
}) {
  final String baseKey =
      isV2 ? pubKeyOrAddress : getFullPubKey(pubKeyOrAddress);
  // Append :ZEN:XXXXXXXX constellation tag for ecosystem isolation
  final String key = ZenTagService().tagAddress(baseKey);

  final bool brightnessSupported = isBrightnessSupported();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        if (brightnessSupported) {
          await setHighBrightness();
        }
      });
      return PopScope(
          onPopInvokedWithResult: (bool didPop, dynamic result) async {
            if (didPop && brightnessSupported) {
              await resetBrightness();
            }
          },
          child: Dialog(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: ResponsiveBreakpoints.of(context).largerThan(MOBILE)
                    ? 400.0
                    : double.infinity,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(
                      height: MediaQuery.of(context).size.width *
                          (ResponsiveBreakpoints.of(context).largerThan(MOBILE)
                              ? 0.4
                              : 0.8),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: GestureDetector(
                          onTap: () => copyPublicKeyToClipboard(
                              context, key, feedbackText),
                          child: Container(
                            color: isDark(context)
                                ? Colors.grey[900]
                                : Colors.grey[100],
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: <Widget>[
                                if (!noTitle) Text(tr('show_qr_to_client')),
                                if (!noTitle) const SizedBox(height: 10),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      QrImageView(
                                        data: key,
                                        size: MediaQuery.of(context)
                                                .size
                                                .width *
                                            (ResponsiveBreakpoints.of(context)
                                                    .largerThan(MOBILE)
                                                ? 0.3
                                                : 0.5),
                                        eyeStyle: QrEyeStyle(
                                            eyeShape: QrEyeShape.square,
                                            color: isDark(context)
                                                ? Theme.of(context).hintColor
                                                : Theme.of(context)
                                                    .primaryColor),
                                        dataModuleStyle: QrDataModuleStyle(
                                            dataModuleShape:
                                                QrDataModuleShape.square,
                                            color: isDark(context)
                                                ? Colors.white
                                                : Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextFormField(
                        maxLines: 2,
                        initialValue: key,
                        readOnly: true,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.content_copy),
                            onPressed: () {
                              copyPublicKeyToClipboard(
                                  context, key, feedbackText);
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ));
    },
  ).then((_) async {
    if (brightnessSupported) {
      await resetBrightness();
    }
  });
}
