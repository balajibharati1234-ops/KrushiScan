class ProductModel {
  final String id;
  final String productName;
  final String companyName;
  final String batchNumber;
  final String manufactureDate;
  final bool isAuthentic;

  ProductModel({
    required this.id,
    required this.productName,
    required this.companyName,
    required this.batchNumber,
    required this.manufactureDate,
    required this.isAuthentic,
  });

  factory ProductModel.fromMap(Map<String, dynamic> map, String id) =>
      ProductModel(
        id: id,
        productName: map['productName'] ?? '',
        companyName: map['companyName'] ?? '',
        batchNumber: map['batchNumber'] ?? '',
        manufactureDate: map['manufactureDate'] ?? '',
        isAuthentic: map['isAuthentic'] ?? false,
      );
}
