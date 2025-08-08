import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../data/models/contact.dart';
import '../g1/api.dart';
import 'ui_helpers.dart';
import 'widgets/connectivity_widget_wrapper_wrapper.dart';

class ContactListItem extends StatelessWidget {
  const ContactListItem(
      {super.key,
      required this.contact,
      required this.index,
      required this.onTap,
      this.onLongPress,
      required this.trailing,
      required this.isV2,
      this.subtitleExtra});

  final Contact contact;
  final int index;
  final String? subtitleExtra;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final Widget? trailing;
  final bool isV2;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Contact>(
        future: getProfile(contact.pubKey, resize: false, complete: false),
        builder: (BuildContext context, AsyncSnapshot<Contact> snapshot) {
          if (snapshot.hasData) {
            return _buildListTile(snapshot.data!, context, true);
          } else {
            // here a mock contact is used
            return ConnectivityWidgetWrapperWrapper(
                offlineWidget: _buildListTile(contact, context, false),
                child: Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: _buildListTile(
                    Contact(
                      pubKey: contact.pubKey,
                      name: '',
                    ),
                    context,
                    false,
                  ),
                ));
          }
        });
  }

  ListTile _buildListTile(
      Contact contact, BuildContext context, bool hasProfile) {
    final String title = contact.title;
    final Widget? subtitle = contact.subtitle != null && hasProfile
        ? Text(isV2
            ? '${contact.createdOnV2 ? contact.subtitleV2 : contact.subtitle!} ${subtitleExtra != null ? ' - $subtitleExtra' : ''}'
            : contact.subtitle!)
        : null;
    return ListTile(
        title: Text(title),
        subtitle: subtitle ?? Container(),
        tileColor: tileColor(index, context),
        onTap: onTap,
        onLongPress: onLongPress,
        leading: avatar(
          contact,
          bgColor: tileColor(index, context),
          color: tileColor(index, context, true),
        ),
        trailing: trailing);
  }
}
