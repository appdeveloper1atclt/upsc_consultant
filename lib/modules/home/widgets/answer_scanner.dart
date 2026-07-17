import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:upsc_consultant/core/constant/app_colors.dart';
import 'package:upsc_consultant/core/constant/app_image.dart';
import 'package:upsc_consultant/core/constant/app_text_styles.dart';
import '../view/analysis_screen.dart';

class AnswerScannerBanner extends StatelessWidget {
  final VoidCallback onScanTap;

  const AnswerScannerBanner({super.key, required this.onScanTap});

  // ── Upload bottom sheet ──────────────────────────────────────────────────
  void _showUploadSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => UploadBottomSheet(onUploadSuccess: onScanTap),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: Stack(
        children: [
          // ── Full background image ────────────────────────────────────────
          Positioned.fill(child: Image.asset(AppImage.searchbannerImg, fit: BoxFit.cover)),

          // ── Dark gradient overlay ────────────────────────────────────────
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [AppColors.primaryDark.withValues(alpha: 0.88), AppColors.primaryDark.withValues(alpha: 0.55), Colors.transparent],
                  stops: const [0.0, 0.55, 1.0],
                ),
              ),
            ),
          ),

          // ── Content on top ───────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Headline
                Text("Scan Your Answer Sheet & Get Analysis", style: AppTextStyles.white20bold.copyWith(fontSize: 17, height: 1.2, fontWeight: FontWeight.w900)),

                const SizedBox(height: 8),

                // Feature chips
                Wrap(
                  spacing: 6,
                  runSpacing: 4,
                  children: const [
                    _CheckItem(label: 'Evaluation'),
                    _CheckItem(label: 'Detailed Feedback'),
                    _CheckItem(label: 'Score Prediction'),
                  ],
                ),

                const SizedBox(height: 12),

                // CTA Button → opens upload sheet
                SizedBox(
                  height: 38,
                  child: ElevatedButton.icon(
                    onPressed: () => _showUploadSheet(context),
                    icon: const Icon(Icons.document_scanner_outlined, size: 14, color: AppColors.primaryDark),
                    label: const Text('Scan / Upload PDF'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 38),
                      elevation: 0,
                      backgroundColor: AppColors.gold,
                      foregroundColor: AppColors.primaryDark,
                      textStyle: AppTextStyles.primaryDark15extraBold.copyWith(fontSize: 12, fontWeight: FontWeight.bold),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Upload Bottom Sheet ────────────────────────────────────────────────────────
class UploadBottomSheet extends StatefulWidget {
  final VoidCallback? onUploadSuccess;

  const UploadBottomSheet({super.key, this.onUploadSuccess});

  @override
  State<UploadBottomSheet> createState() => _UploadBottomSheetState();
}

class _UploadBottomSheetState extends State<UploadBottomSheet> {
  final ImagePicker _picker = ImagePicker();

  List<File> _pickedFiles = [];
  bool _isLoading = false;

  // ── Pick from Camera ────────────────────────────────────────────────────
  Future<void> _fromCamera() async {
    setState(() => _isLoading = true);
    try {
      final XFile? photo = await _picker.pickImage(source: ImageSource.camera, imageQuality: 90);
      if (photo != null && mounted) {
        setState(() => _pickedFiles = [File(photo.path)]);
        _showConfirmation(photo.name, 'image');
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  // ── Pick from Gallery ───────────────────────────────────────────────────
  Future<void> _fromGallery() async {
    setState(() => _isLoading = true);
    try {
      final List<XFile> images = await _picker.pickMultiImage(imageQuality: 90);
      if (images.isNotEmpty && mounted) {
        setState(() => _pickedFiles = images.map((x) => File(x.path)).toList());
        _showConfirmation('${images.length} image(s)', 'image');
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  // ── Pick PDF ────────────────────────────────────────────────────────────
  Future<void> _fromFilePicker() async {
    setState(() => _isLoading = true);
    try {
      final FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['pdf'], allowMultiple: false);
      if (result != null && result.files.single.path != null && mounted) {
        final file = File(result.files.single.path!);
        setState(() => _pickedFiles = [file]);
        _showConfirmation(result.files.single.name, 'pdf');
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showConfirmation(String name, String type) async {
    Navigator.pop(context); // Close bottom sheet
    final result = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (context) => AnalysisScreen(fileName: name, fileType: type),
      ),
    );
    if (result == true && widget.onUploadSuccess != null) {
      widget.onUploadSuccess!();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(color: AppColors.border, borderRadius: BorderRadius.circular(10)),
          ),
          const SizedBox(height: 20),

          Text('Upload Answer Sheet', style: AppTextStyles.textPrimary16bold.copyWith(fontWeight: FontWeight.w800)),
          const SizedBox(height: 4),
          Text('Image (JPG/PNG) ya PDF select karo', style: AppTextStyles.textSecondary13normal.copyWith(fontSize: 12)),
          const SizedBox(height: 24),

          if (_isLoading)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: CircularProgressIndicator(color: AppColors.gold),
            )
          else
            Row(
              children: [
                // Camera
                Expanded(
                  child: _UploadOption(
                    icon: Icons.camera_alt_rounded,
                    label: 'Camera',
                    subtitle: 'Photo lao',
                    color: const Color(0xFF1565C0),
                    onTap: _fromCamera,
                  ),
                ),
                const SizedBox(width: 12),
                // Gallery
                Expanded(
                  child: _UploadOption(
                    icon: Icons.photo_library_rounded,
                    label: 'Gallery',
                    subtitle: 'Photo chunno',
                    color: const Color(0xFF2E7D32),
                    onTap: _fromGallery,
                  ),
                ),
                const SizedBox(width: 12),
                // PDF
                Expanded(
                  child: _UploadOption(
                    icon: Icons.picture_as_pdf_rounded,
                    label: 'PDF',
                    subtitle: 'File chunno',
                    color: const Color(0xFFC62828),
                    onTap: _fromFilePicker,
                  ),
                ),
              ],
            ),

          // Show picked file names
          if (_pickedFiles.isNotEmpty) ...[
            const SizedBox(height: 16),
            ...(_pickedFiles.map(
              (f) => Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  children: [
                    const Icon(Icons.check_circle_rounded, color: AppColors.success, size: 16),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        f.path.split('/').last,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.labelMedium.copyWith(color: AppColors.textPrimary, fontWeight: FontWeight.normal),
                      ),
                    ),
                  ],
                ),
              ),
            )),
          ],
        ],
      ),
    );
  }
}

// ── Upload Option Card ─────────────────────────────────────────────────────────
class _UploadOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const _UploadOption({required this.icon, required this.label, required this.subtitle, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 8),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withValues(alpha: 0.2)),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: color.withValues(alpha: 0.12), shape: BoxShape.circle),
              child: Icon(icon, color: color, size: 26),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: AppTextStyles.textPrimary12semibold.copyWith(color: color, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 2),
            Text(subtitle, style: AppTextStyles.textSecondary11semibold.copyWith(fontSize: 9.5, fontWeight: FontWeight.normal)),
          ],
        ),
      ),
    );
  }
}

// ── Check Item ────────────────────────────────────────────────────────────────
class _CheckItem extends StatelessWidget {
  final String label;

  const _CheckItem({required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.check_circle_rounded, color: AppColors.goldLight, size: 13),
        const SizedBox(width: 4),
        Text(label, style: AppTextStyles.caption.copyWith(fontSize: 10, color: Colors.white70)),
      ],
    );
  }
}
