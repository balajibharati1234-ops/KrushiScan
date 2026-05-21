import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../../core/theme/app_theme.dart';

class QrGeneratorScreen extends StatefulWidget {
  const QrGeneratorScreen({super.key});

  @override
  State<QrGeneratorScreen> createState() => _QrGeneratorScreenState();
}

class _QrGeneratorScreenState extends State<QrGeneratorScreen> {
  final _ctrl = TextEditingController();
  String _qrData = 'KRUSHI001';

  // Test product IDs - these must match Firestore document IDs
  final List<String> _testProducts = [
    'KRUSHI001',
    'KRUSHI002',
    'KRUSHI003',
    'FAKEPRODUCT001', // this will show as FAKE
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Generator (Test)', style: GoogleFonts.poppins()),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Info banner
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.primaryLight.withOpacity(0.3),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.info, color: AppColors.primary),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Show this QR on screen and scan it from the Scan tab',
                      style: GoogleFonts.poppins(fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // QR Display
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Column(
                children: [
                  QrImageView(
                    data: _qrData,
                    version: QrVersions.auto,
                    size: 220,
                    backgroundColor: Colors.white,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    _qrData,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Quick select buttons
            Text(
              'Quick Select Test Products',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 12),
            ..._testProducts.map(
              (id) => GestureDetector(
                onTap: () => setState(() => _qrData = id),
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: _qrData == id ? AppColors.primary : Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.primary),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        id.contains('FAKE') ? Icons.dangerous : Icons.verified,
                        color: _qrData == id
                            ? Colors.white
                            : id.contains('FAKE')
                            ? AppColors.fake
                            : AppColors.authentic,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        id,
                        style: GoogleFonts.poppins(
                          color: _qrData == id
                              ? Colors.white
                              : AppColors.textDark,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        id.contains('FAKE') ? 'FAKE' : 'AUTHENTIC',
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          color: _qrData == id
                              ? Colors.white70
                              : id.contains('FAKE')
                              ? AppColors.fake
                              : AppColors.authentic,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Custom QR input
            Text(
              'Or Enter Custom QR Value',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _ctrl,
              decoration: InputDecoration(
                labelText: 'Enter product ID',
                prefixIcon: const Icon(Icons.qr_code),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.qr_code_2),
                  onPressed: () {
                    final text = _ctrl.text.trim();
                    if (text.isNotEmpty) {
                      setState(() {
                        _qrData = text;
                      });
                    }
                  },
                ),
                border: const OutlineInputBorder(),
              ),
              onSubmitted: (value) {
                final text = value.trim();
                if (text.isNotEmpty) {
                  setState(() {
                    _qrData = text;
                  });
                }
              },
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  if (_ctrl.text.isNotEmpty) {
                    setState(() => _qrData = _ctrl.text.trim());
                  }
                },
                icon: const Icon(Icons.qr_code),
                label: Text('Generate QR', style: GoogleFonts.poppins()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
