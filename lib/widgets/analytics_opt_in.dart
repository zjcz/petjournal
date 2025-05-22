import 'package:flutter/material.dart';
import 'package:petjournal/widgets/custom_switch.dart';

class AnalyticsOptIn extends StatelessWidget {
  final bool optIntoAnalyticsValue;
  final Function(bool) onChanged;
  const AnalyticsOptIn({
    super.key,
    required this.optIntoAnalyticsValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 20.0,
      children: [
        const Text(
          'I agree for analytics and crash data to be sent to Google to help improve this application',
        ),
        CustomSwitch(
          key: Key('${key.toString()}_cs'),
          labelText: 'I agree',
          onChanged: onChanged,
          switchValue: optIntoAnalyticsValue,
        ),
      ],
    );
  }
}
