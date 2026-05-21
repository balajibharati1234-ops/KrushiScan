import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/scan_model.dart';
import '../models/product_model.dart';

class ScanService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<ProductModel?> verifyProduct(String qrCode) async {
    try {
      final doc = await _firestore.collection('products').doc(qrCode).get();

      if (doc.exists) {
        return ProductModel.fromMap(doc.data()!, doc.id);
      }
      return null; // Not found = fake
    } catch (e) {
      rethrow;
    }
  }

  Future<void> saveScan(ScanModel scan) async {
    await _firestore.collection('scans').add(scan.toMap());
  }

  Future<List<ScanModel>> getUserScans(String userId) async {
    try {
      final snapshot = await _firestore
          .collection('scans')
          .where('userId', isEqualTo: userId)
          .get(); // removed orderBy to avoid index error

      final list = snapshot.docs
          .map((doc) => ScanModel.fromMap(doc.data(), doc.id))
          .toList();

      // Sort locally instead
      list.sort((a, b) => b.scannedAt.compareTo(a.scannedAt));
      return list;
    } catch (e) {
      return []; // return empty list on error
    }
  }
}
