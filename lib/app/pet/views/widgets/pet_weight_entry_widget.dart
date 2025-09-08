import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petjournal/app/settings/controllers/settings_controller.dart';
import 'package:petjournal/constants/weight_units.dart';
import 'package:petjournal/helpers/imperial_weight.dart';
import 'package:petjournal/widgets/loading_widget.dart';

/// This widget allows the user to enter the pet weight
/// The widget manages whether to allow entry in metric or imperial
class PetWeightEntryWidget extends ConsumerStatefulWidget {
  final String? labelText;
  final String? errorText;
  final double? weightKg;
  final Function(double?)? onChanged;
  final String? Function(double?)? onValidate;

  const PetWeightEntryWidget({
    super.key,
    this.weightKg,
    this.labelText = 'Weight',
    this.errorText = 'Weight is required',
    this.onChanged,
    this.onValidate,
  });

  @override
  ConsumerState<PetWeightEntryWidget> createState() =>
      _PetWeightEntryWidgetState();
}

class _PetWeightEntryWidgetState extends ConsumerState<PetWeightEntryWidget> {
  late TextEditingController _metricKgController;
  late TextEditingController _imperialLbController;
  late TextEditingController _imperialOzController;

  @override
  void initState() {
    super.initState();

    // Initialize with existing weight data if available, otherwise defaults
    ImperialWeight? imperialWeight = ImperialWeight.fromKg(
      (widget.weightKg ?? 0).toDouble(),
    );
    _metricKgController = TextEditingController(
      text: widget.weightKg?.toString() ?? '',
    );
    _imperialLbController = TextEditingController(
      text: imperialWeight.pounds.toString(),
    );
    _imperialOzController = TextEditingController(
      text: imperialWeight.ounces.toStringAsFixed(3),
    );
  }

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsControllerProvider);

    return settings.when(
      data: (s) {
        if (s.defaultWeightUnit == WeightUnits.metric) {
          return _buildMetric(widget.weightKg);
        } else {
          return _buildImperial(widget.weightKg);
        }
      },
      error: (error, stackTrace) => Center(child: Text('Error: $error')),
      loading: () => LoadingWidget(labelText: 'Loading...'),
    );
  }

  Widget _buildMetric(double? weightKg) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            key: Key('${widget.key.toString()}_kg'),
            controller: _metricKgController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: widget.labelText),
            validator: (value) {
              if (value == null ||
                  value.isEmpty ||
                  double.tryParse(value) == null) {
                return widget.errorText;
              }
              if (widget.onValidate != null) {
                return widget.onValidate!(double.parse(value));
              }
              return null;
            },
            onChanged: (value) {
              widget.onChanged!(value.isEmpty ? 0 : double.tryParse(value));
            },
          ),
        ),
        const Text('kg'),
      ],
    );
  }

  Widget _buildImperial(double? weightKg) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.labelText != null)
          Text(widget.labelText!, style: Theme.of(context).textTheme.bodySmall),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                key: Key('${widget.key.toString()}_lb'),
                controller: _imperialLbController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      int.tryParse(value) == null) {
                    return widget.errorText;
                  }
                  if (widget.onValidate != null) {
                    final lbValue = int.parse(value);
                    final ozValue = double.tryParse(
                      _imperialOzController.text.isEmpty
                          ? '0'
                          : _imperialOzController.text,
                    );
                    final imperial = ImperialWeight.fromImperial(
                      lbValue,
                      ozValue ?? 0,
                    );
                    return widget.onValidate!(imperial.toKg());
                  }
                  return null;
                },
                onChanged: (value) {
                  final lbValue = int.tryParse(value.isEmpty ? '0' : value);
                  final ozValue = double.tryParse(
                    _imperialOzController.text.isEmpty
                        ? '0'
                        : _imperialOzController.text,
                  );
                  final imperial = ImperialWeight.fromImperial(
                    lbValue ?? 0,
                    ozValue ?? 0,
                  );
                  widget.onChanged!(imperial.toKg());
                },
              ),
            ),
            const Text('lb'),
            const SizedBox(width: 10),
            Expanded(
              child: TextFormField(
                key: Key('${widget.key.toString()}_oz'),
                controller: _imperialOzController,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      double.tryParse(value) == null) {
                    return widget.errorText;
                  }
                  if (widget.onValidate != null) {
                    final lbValue = int.tryParse(
                      _imperialLbController.text.isEmpty
                          ? '0'
                          : _imperialLbController.text,
                    );
                    final ozValue = double.parse(value.isEmpty ? '0' : value);
                    final imperial = ImperialWeight.fromImperial(
                      lbValue ?? 0,
                      ozValue,
                    );
                    return widget.onValidate!(imperial.toKg());
                  }
                  return null;
                },
                onChanged: (value) {
                  final lbValue = int.tryParse(_imperialLbController.text);
                  final ozValue = double.tryParse(value.isEmpty ? '0' : value);
                  final imperial = ImperialWeight.fromImperial(
                    lbValue ?? 0,
                    ozValue ?? 0,
                  );
                  widget.onChanged!(imperial.toKg());
                },
              ),
            ),
            const Text('oz'),
          ],
        ),
      ],
    );
  }
}
