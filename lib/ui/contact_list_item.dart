import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../data/models/contact.dart';
import 'contacts_cache.dart';
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
      future: ContactsCache().getContact(contact.pubKey),
      builder: (BuildContext context, AsyncSnapshot<Contact> snapshot) {
        Widget avatarWidget;
        Contact displayContact;
        bool hasProfile = false;
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          avatarWidget = avatar(
            snapshot.data!,
            bgColor: tileColor(index, context),
            color: tileColor(index, context, true),
          );
          displayContact = snapshot.data!;
          hasProfile = true;
        } else {
          // Show local data while the snapshot is loading
          avatarWidget = Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: avatar(
              contact,
              bgColor: tileColor(index, context),
              color: tileColor(index, context, true),
            ),
          );
          displayContact = contact;
        }
        return ConnectivityWidgetWrapperWrapper(
          offlineWidget: _buildListTile(contact, context, false, avatarWidget),
          child: _buildListTile(
            displayContact,
            context,
            hasProfile,
            avatarWidget,
          ),
        );
      },
    );
  }

  ListTile _buildListTile(Contact contact, BuildContext context,
      bool hasProfile, Widget avatarWidget) {
    final String title = contact.title;
    final Widget? subtitle = contact.subtitle != null && hasProfile
        ? Text(isV2
            ? '${contact.subtitle} ${subtitleExtra != null ? ' - $subtitleExtra' : ''}'
            : contact.subtitle!)
        : null;
    return ListTile(
        title: Text(title),
        subtitle: subtitle ?? Container(),
        tileColor: tileColor(index, context),
        onTap: onTap,
        onLongPress: onLongPress,
        leading: avatarWidget,
        trailing: trailing);
  }
}
