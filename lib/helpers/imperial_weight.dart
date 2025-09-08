class ImperialWeight {
  final int pounds;
  final double ounces;

  ImperialWeight._internal(this.pounds, this.ounces);

  double toKg() {
    double totalOunces = pounds * 16 + ounces;
    return totalOunces * 0.0283495;
  }

  factory ImperialWeight.fromImperial(int pounds, double ounces) {
    int newPounds = pounds;
    double newOunces = ounces;

    if (newOunces > 16) {
      newPounds += (newOunces / 16).floor();
      newOunces = newOunces.remainder(16);
    }

    return ImperialWeight._internal(newPounds, newOunces);
  }

  factory ImperialWeight.fromKg(double kg) {
    double totalOunces = kg / 0.0283495;
    int pounds = (totalOunces / 16).floor();
    double ounces = totalOunces.remainder(16);
    return ImperialWeight._internal(pounds, ounces);
  }

  @override
  String toString() {
    if (ounces == 0) {
      return '$pounds lb';
    } else if (ounces - ounces.truncate() == 0.0) {
      return '$pounds lb, ${ounces.toStringAsFixed(0)} oz';
    } else {
      return '$pounds lb, ${ounces.toStringAsFixed(1)} oz';
    }
  }
}
