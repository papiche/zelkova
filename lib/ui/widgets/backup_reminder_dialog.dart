import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/app_cubit.dart';
import '../../data/models/app_state.dart';
import 'fifth_screen/export_dialog.dart';

void showBackupReminderDialog(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return BlocBuilder<AppCubit, AppState>(
        builder: (BuildContext context, AppState state) => Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          tr('export_reminder_question'),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(tr('export_reminder_description')),
                        const SizedBox(height: 12),
                        _buildBulletPoint(tr('export_reminder_scenario1')),
                        _buildBulletPoint(tr('export_reminder_scenario2')),
                        _buildBulletPoint(tr('export_reminder_scenario3')),
                        const SizedBox(height: 16),
                        Text(
                          tr('export_reminder_recommendation'),
                          style: const TextStyle(
                            fontStyle: FontStyle.italic,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: OutlinedButton(
                          child: Text(tr('export_reminder_yes_button')),
                          onPressed: () {
                            context.read<AppCubit>().setHasRecentExport(true);
                            context
                                .read<AppCubit>()
                                .setRecentExportReminderInDays(120);
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            textStyle: const TextStyle(color: Colors.red),
                          ),
                          child: Text(tr('export_reminder_no_button')),
                          onPressed: () {
                            Navigator.pop(context);
                            openExportWalletsSelector(
                                context, state.expertMode);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

Widget _buildBulletPoint(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text('• '),
        Expanded(child: Text(text)),
      ],
    ),
  );
}
