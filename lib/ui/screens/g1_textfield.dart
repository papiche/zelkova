import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class G1PayAmountField extends StatelessWidget {
  const G1PayAmountField({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: tr('g1_amount'),
        hintText: tr('g1_amount_hint'),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SvgPicture.asset(
            colorFilter:
                ColorFilter.mode(Colors.purple.shade600, BlendMode.srcIn),
            'assets/img/gbrevedot.svg',
            width: 20.0,
            height: 20.0,
          ),
        ),
        border: const OutlineInputBorder(),
      ),
    );
  }
}
