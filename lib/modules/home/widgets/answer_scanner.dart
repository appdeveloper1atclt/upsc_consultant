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
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFFDFDFD),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFF1F5F9), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            // Premium subtle background gold glow on the right
            Positioned(
              right: -20,
              top: -20,
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.gold.withValues(alpha: 0.05),
                ),
              ),
            ),

            // Content padding
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              child: Row(
                children: [
                  Expanded(
                    flex: 68,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // AI Powered Badge
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFFBEB),
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: const Color(0xFFFDE68A), width: 0.6),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Icon(Icons.bolt_rounded, color: Color(0xFFB45309), size: 10),
                              SizedBox(width: 2),
                              Text(
                                'AI POWERED',
                                style: TextStyle(
                                  fontFamily: 'PlusJakartaSans',
                                  fontSize: 8,
                                  fontWeight: FontWeight.w900,
                                  color: Color(0xFFB45309),
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),

                        // Title
                        RichText(
                          text: const TextSpan(
                            style: TextStyle(
                              fontFamily: 'PlusJakartaSans',
                              fontSize: 15,
                              fontWeight: FontWeight.w900,
                              color: AppColors.textPrimary,
                              height: 1.2,
                            ),
                            children: [
                              TextSpan(text: "Scan Your Answer Sheet\n& Get "),
                              TextSpan(
                                text: "AI Analysis",
                                style: TextStyle(color: AppColors.goldDark),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Scan Button (Fitted to scale down dynamically on narrow screens)
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
                            onTap: () => _showUploadSheet(context),
                            child: Container(
                              height: 36,
                              padding: const EdgeInsets.symmetric(horizontal: 14),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [AppColors.gold, AppColors.goldLight],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.gold.withValues(alpha: 0.15),
                                    blurRadius: 6,
                                    offset: const Offset(0, 2),
                                  )
                                ],
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  Icon(Icons.document_scanner_rounded, color: AppColors.primaryDark, size: 13),
                                  SizedBox(width: 4),
                                  Text(
                                    'Scan / Upload PDF',
                                    style: TextStyle(
                                      fontFamily: 'PlusJakartaSans',
                                      fontWeight: FontWeight.w800,
                                      fontSize: 11,
                                      color: AppColors.primaryDark,
                                    ),
                                  ),
                                  SizedBox(width: 4),
                                  Icon(Icons.arrow_forward_rounded, color: AppColors.primaryDark, size: 11),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),

                        // Footer text (Uses inline RichText to prevent Row horizontal overflow)
                        const Text.rich(
                          TextSpan(
                            children: [
                              WidgetSpan(
                                child: Padding(
                                  padding: EdgeInsets.only(right: 4.0),
                                  child: Icon(Icons.verified_user_outlined, size: 11, color: AppColors.textSecondary),
                                ),
                                alignment: PlaceholderAlignment.middle,
                              ),
                              TextSpan(
                                text: 'Supports PDF only • Secure & Private',
                                style: TextStyle(
                                  fontFamily: 'PlusJakartaSans',
                                  fontSize: 8.5,
                                  color: AppColors.textSecondary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Right visual decoration - modern pulsing gold badge
                  Expanded(
                    flex: 32,
                    child: SizedBox(
                      height: 80,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Outer glowing ring
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.gold.withValues(alpha: 0.08),
                            ),
                          ),
                          // Gold glassmorphism scanner container
                          Container(
                            width: 46,
                            height: 46,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [
                                  Colors.white,
                                  AppColors.goldLight.withValues(alpha: 0.9),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              border: Border.all(
                                color: AppColors.gold.withValues(alpha: 0.35),
                                width: 1.2,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.gold.withValues(alpha: 0.08),
                                  blurRadius: 8,
                                  offset: const Offset(0, 3),
                                )
                              ],
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.document_scanner_rounded,
                                color: AppColors.goldDark,
                                size: 20,
                              ),
                            ),
                          ),
                          // Neon gold scanning line
                          Positioned(
                            top: 20,
                            child: Container(
                              width: 50,
                              height: 1.5,
                              decoration: BoxDecoration(
                                color: AppColors.gold,
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.gold,
                                    blurRadius: 3,
                                    spreadRadius: 0.5,
                                  )
                                ],
                              ),
                            )
                            .animate(onPlay: (c) => c.repeat(reverse: true))
                            .y(begin: -12, end: 12, duration: 1500.ms, curve: Curves.easeInOut),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
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
