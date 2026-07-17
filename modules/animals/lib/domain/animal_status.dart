/// Статус животного. Wire-значения совпадают с API (Status69fEnum), но это
/// доменный тип — UI-цвета живут в ui-слое (AnimalStatusX), не здесь.
enum AnimalStatus {
  inTheShelter('IN_THE_SHELTER'),
  hospital('HOSPITAL'),
  overexposure('OVEREXPOSURE'),
  attached('ATTACHED'),
  preparingToRelease('PREPARING_TO_RELEASE'),
  released('RELEASED'),
  death('DEATH'),
  euthanasia('EUTHANASIA'),
  inClinic('IN_CLINIC'),
  unknown(null);

  const AnimalStatus(this.wire);

  final String? wire;

  static AnimalStatus fromWire(String? wire) {
    if (wire == null) return AnimalStatus.unknown;
    for (final status in AnimalStatus.values) {
      if (status.wire == wire) return status;
    }
    return AnimalStatus.unknown;
  }
}
