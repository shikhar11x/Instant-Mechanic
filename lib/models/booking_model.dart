class BookingModel {
  final String bookingId;
  final String mechanicId;
  final String garageName;
  final String customerName;
  final String phoneNumber;
  final String vehicleNumber;
  final String selectedService;
  final String problemDescription;
  final String bookingDate;
  final String bookingTime;
  final double estimatedCost;
  final String status;

  BookingModel({
    required this.bookingId,
    required this.mechanicId,
    required this.garageName,
    required this.customerName,
    required this.phoneNumber,
    required this.vehicleNumber,
    required this.selectedService,
    required this.problemDescription,
    required this.bookingDate,
    required this.bookingTime,
    required this.estimatedCost,
    required this.status,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      bookingId: json['bookingId'] as String? ?? '',
      mechanicId: json['mechanicId'] as String? ?? '',
      garageName: json['garageName'] as String? ?? '',
      customerName: json['customerName'] as String? ?? '',
      phoneNumber: json['phoneNumber'] as String? ?? '',
      vehicleNumber: json['vehicleNumber'] as String? ?? '',
      selectedService: json['selectedService'] as String? ?? '',
      problemDescription: json['problemDescription'] as String? ?? '',
      bookingDate: json['bookingDate'] as String? ?? '',
      bookingTime: json['bookingTime'] as String? ?? '',
      estimatedCost: (json['estimatedCost'] as num?)?.toDouble() ?? 0.0,
      status: json['status'] as String? ?? 'pending',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'bookingId': bookingId,
      'mechanicId': mechanicId,
      'garageName': garageName,
      'customerName': customerName,
      'phoneNumber': phoneNumber,
      'vehicleNumber': vehicleNumber,
      'selectedService': selectedService,
      'problemDescription': problemDescription,
      'bookingDate': bookingDate,
      'bookingTime': bookingTime,
      'estimatedCost': estimatedCost,
      'status': status,
    };
  }

  @override
  String toString() => 'BookingModel(bookingId: $bookingId, garageName: $garageName)';
}