class RequestCardData {
  final int? id;
  final String code;
  final String customerName;
  final String address;
  final String date;
  final String note;
  final String statusValue;
  final String statusLabel;

  const RequestCardData({
    this.id,
    required this.code,
    required this.customerName,
    required this.address,
    required this.date,
    required this.note,
    required this.statusValue,
    required this.statusLabel,
  });
}