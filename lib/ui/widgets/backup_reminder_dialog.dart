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
        builder: (BuildContext context, AppState state) {
          final ThemeData theme = Theme.of(context);
          final ColorScheme colorScheme = theme.colorScheme;
          return Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(20)),
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
                      color: colorScheme.onSurface.withOpacity(0.2),
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
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(tr('export_reminder_description')),
                          const SizedBox(height: 12),
                          _buildBulletPoint(
                            context,
                            tr('export_reminder_scenario1'),
                          ),
                          _buildBulletPoint(
                            context,
                            tr('export_reminder_scenario2'),
                          ),
                          _buildBulletPoint(
                            context,
                            tr('export_reminder_scenario3'),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            tr('export_reminder_recommendation'),
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontStyle: FontStyle.italic,
                              color: colorScheme.onSurface.withOpacity(0.65),
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
                              textStyle:
                                  TextStyle(color: colorScheme.onPrimary),
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
          );
        },
      );
    },
  );
}

Widget _buildBulletPoint(BuildContext context, String text) {
  final Color bulletColor = Theme.of(context).colorScheme.onSurface;
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '• ',
          style: TextStyle(color: bulletColor),
        ),
        Expanded(
          child: Text(
            text,
            style: TextStyle(color: bulletColor),
          ),
        ),
      ],
    ),
  );
}
