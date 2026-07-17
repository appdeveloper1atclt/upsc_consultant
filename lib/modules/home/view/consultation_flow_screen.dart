import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/app_text_styles.dart';
import '../model/session_type_model.dart';
import '../widgets/consultation_stepper.dart';
import '../widgets/consultation_details_step.dart';
import '../widgets/consultation_slot_step.dart';
import '../widgets/consultation_session_step.dart';
import '../widgets/consultation_payment_step.dart';
import '../widgets/consultation_confirmed_step.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ConsultationFlowScreen extends StatefulWidget {
  const ConsultationFlowScreen({super.key});

  @override
  State<ConsultationFlowScreen> createState() => _ConsultationFlowScreenState();
}

class _ConsultationFlowScreenState extends State<ConsultationFlowScreen> {
  int _currentStep = 0; // 0: Details, 1: Slot, 2: Session, 3: Payment, 4: Confirmed
  late String _bookingId;

  // Step 1: Student Details Form State
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  
  String _selectedAttempt = 'First Attempt';
  String _selectedStage = 'Prelims';
  String _selectedLanguage = 'English';
  String _selectedReason = 'Select reason';
  
  final List<String> _reasons = [
    'Select reason',
    'Strategy Planning',
    'Syllabus Discussion',
    'Doubt Clearing',
    'Mains Answer Review',
    'Interview Guidance',
  ];

  // Step 2: Date & Slot State
  late DateTime _selectedDate;
  String _selectedTimeSlot = '';
  final List<DateTime> _dates = List.generate(10, (index) => DateTime.now().add(Duration(days: index)));
  final List<String> _timeSlots = [
    '10:00 AM', '11:00 AM', '12:00 PM',
    '04:00 PM', '05:00 PM', '06:00 PM',
    '07:00 PM', '08:00 PM', '09:00 PM'
  ];

  // Step 3: Session State
  int _selectedSessionIndex = 0;
  final List<SessionTypeModel> _sessions = [
    SessionTypeModel(
      title: '1 to 1 Session',
      subtitle: 'One-on-one personalized session with expert mentor.',
      price: 999,
      icon: Icons.person_rounded,
      color: const Color(0xFF107C41),
    ),
    SessionTypeModel(
      title: '1 to 3 Session',
      subtitle: 'Share and learn with 1 to 2 more aspirants.',
      price: 699,
      icon: Icons.groups_rounded,
      color: const Color(0xFF2563EB),
    ),
    SessionTypeModel(
      title: '1 to 6 Session',
      subtitle: 'Group session with 5 to 6 aspirants.',
      price: 499,
      icon: Icons.group_add_rounded,
      color: Colors.orange,
    ),
  ];

  // Step 4: Payment & Coupon State
  String _selectedPaymentMethod = 'UPI';
  bool _isProcessingPayment = false;
  final TextEditingController _couponController = TextEditingController();
  bool _couponApplied = false;
  double _discountAmount = 0.0;
  String _appliedCouponCode = '';

  @override
  void initState() {
    super.initState();
    _selectedDate = _dates.first;
    // Generate a unique booking ID
    _bookingId = 'UPSC-${(100000 + (DateTime.now().millisecondsSinceEpoch % 900000)).toString()}';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _noteController.dispose();
    _couponController.dispose();
    super.dispose();
  }

  // Custom Date Formatting Helpers
  String _getMonthYearString(DateTime date) {
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return "${months[date.month - 1]} ${date.year}";
  }

  String _getWeekdayString(DateTime date) {
    const weekdaysList = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return weekdaysList[date.weekday - 1].toUpperCase();
  }

  String _getFormattedDateShort(DateTime date) {
    const weekdaysList = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    const monthsList = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return "${weekdaysList[date.weekday - 1]}, ${date.day} ${monthsList[date.month - 1]}";
  }

  String _getFormattedDateLong(DateTime date) {
    const weekdaysList = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    const monthsList = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return "${weekdaysList[date.weekday - 1]}, ${date.day} ${monthsList[date.month - 1]} ${date.year}";
  }

  bool _isSameDay(DateTime d1, DateTime d2) {
    return d1.year == d2.year && d1.month == d2.month && d1.day == d2.day;
  }

  String _getEndTime(String startTime) {
    if (startTime.isEmpty) return '';
    try {
      final parts = startTime.split(' ');
      final timeParts = parts[0].split(':');
      int hour = int.parse(timeParts[0]);
      final String minute = timeParts[1];
      String amPm = parts[1];

      hour = hour + 1;
      if (hour == 12) {
        amPm = amPm == 'AM' ? 'PM' : 'AM';
      } else if (hour > 12) {
        hour = hour - 12;
      }
      
      final String hourStr = hour < 10 ? '0$hour' : '$hour';
      return '$hourStr:$minute $amPm';
    } catch (_) {
      return '';
    }
  }

  void _applyCoupon() {
    final code = _couponController.text.trim().toUpperCase();
    if (code == 'UPSC100' || code == 'FIRSTCONSULT') {
      setState(() {
        _couponApplied = true;
        _discountAmount = 100.0;
        _appliedCouponCode = code;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Coupon "$code" applied! Saved ₹100.'),
          backgroundColor: AppColors.success,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid coupon code. Try "UPSC100".'),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

  void _removeCoupon() {
    setState(() {
      _couponApplied = false;
      _discountAmount = 0.0;
      _appliedCouponCode = '';
      _couponController.clear();
    });
  }

  void _nextStep() {
    if (_currentStep == 0) {
      if (_nameController.text.trim().isEmpty || _phoneController.text.trim().isEmpty || _selectedReason == 'Select reason') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please fill all required fields.')),
        );
        return;
      }
    } else if (_currentStep == 1) {
      if (_selectedTimeSlot.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select a time slot.')),
        );
        return;
      }
    }
    
    setState(() {
      _currentStep++;
    });
  }

  void _previousStep() {
    if (_currentStep == 0) {
      context.pop();
    } else {
      setState(() {
        _currentStep--;
      });
    }
  }

  Future<void> _processPaymentSimulated() async {
    setState(() {
      _isProcessingPayment = true;
    });
    await Future.delayed(const Duration(milliseconds: 1500));
    if (mounted) {
      setState(() {
        _isProcessingPayment = false;
        _currentStep = 4; // Booking Confirmed
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool showHeader = _currentStep < 4;
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      appBar: showHeader
          ? AppBar(
              backgroundColor: AppColors.scaffold,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textPrimary, size: 20),
                onPressed: _previousStep,
              ),
              title: Text(_getAppBarTitle(), style: AppTextStyles.appBarTitle),
              centerTitle: false,
            )
          : null,
      body: _isProcessingPayment
          ? _buildPaymentLoader()
          : Column(
              children: [
                if (showHeader) ...[
                  ConsultationStepper(currentStep: _currentStep),
                  const SizedBox(height: 12),
                ],
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: _buildCurrentStepView(),
                  ),
                ),
                if (showHeader) _buildBottomNavbarButton(),
              ],
            ),
    );
  }

  String _getAppBarTitle() {
    switch (_currentStep) {
      case 0:
        return 'Consult Our Mentor';
      case 1:
        return 'Select a Slot';
      case 2:
        return 'Choose Session Type';
      case 3:
        return 'Payment & Billing';
      default:
        return '';
    }
  }

  Widget _buildPaymentLoader() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          CircularProgressIndicator(color: AppColors.primary),
          SizedBox(height: 18),
          Text(
            'Processing Secure Payment...',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
          ),
          SizedBox(height: 6),
          Text(
            'Do not close or press back button',
            style: TextStyle(fontSize: 11, color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentStepView() {
    Widget stepWidget;
    switch (_currentStep) {
      case 0:
        stepWidget = ConsultationDetailsStep(
          formKey: _formKey,
          nameController: _nameController,
          phoneController: _phoneController,
          noteController: _noteController,
          selectedAttempt: _selectedAttempt,
          selectedStage: _selectedStage,
          selectedLanguage: _selectedLanguage,
          selectedReason: _selectedReason,
          reasons: _reasons,
          onAttemptChanged: (val) => setState(() => _selectedAttempt = val),
          onStageChanged: (val) => setState(() => _selectedStage = val),
          onLanguageChanged: (val) => setState(() => _selectedLanguage = val),
          onReasonChanged: (val) => setState(() => _selectedReason = val),
        );
        break;
      case 1:
        stepWidget = ConsultationSlotStep(
          selectedDate: _selectedDate,
          selectedTimeSlot: _selectedTimeSlot,
          dates: _dates,
          timeSlots: _timeSlots,
          onDateChanged: (val) => setState(() => _selectedDate = val),
          onTimeSlotChanged: (val) => setState(() => _selectedTimeSlot = val),
          getMonthYearString: _getMonthYearString,
          getWeekdayString: _getWeekdayString,
          getFormattedDateShort: _getFormattedDateShort,
          isSameDay: _isSameDay,
        );
        break;
      case 2:
        stepWidget = ConsultationSessionStep(
          selectedSessionIndex: _selectedSessionIndex,
          sessions: _sessions,
          onSessionChanged: (val) => setState(() => _selectedSessionIndex = val),
        );
        break;
      case 3:
        stepWidget = ConsultationPaymentStep(
          activeSession: _sessions[_selectedSessionIndex],
          selectedTimeSlot: _selectedTimeSlot,
          formattedDate: _getFormattedDateLong(_selectedDate),
          selectedPaymentMethod: _selectedPaymentMethod,
          couponApplied: _couponApplied,
          discountAmount: _discountAmount,
          appliedCouponCode: _appliedCouponCode,
          couponController: _couponController,
          onApplyCoupon: _applyCoupon,
          onRemoveCoupon: _removeCoupon,
          onPaymentMethodChanged: (val) => setState(() => _selectedPaymentMethod = val),
          getEndTime: _getEndTime,
        );
        break;
      case 4:
        final activeSession = _sessions[_selectedSessionIndex];
        final double baseAmount = activeSession.price.toDouble();
        final double taxableAmount = baseAmount - _discountAmount;
        final double gst = taxableAmount * 0.18;
        final double platformFee = 10.0;
        final double grandTotal = taxableAmount + gst + platformFee;

        stepWidget = ConsultationConfirmedStep(
          mentorName: 'Expert Mentor (UPSC Strategic Advisor)',
          bookingId: _bookingId,
          formattedDate: _getFormattedDateLong(_selectedDate),
          selectedTimeSlot: '$_selectedTimeSlot - ${_getEndTime(_selectedTimeSlot)}',
          durationString: '60 Minutes',
          paidAmount: grandTotal,
          onAddToCalendar: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Session added to your Google Calendar!')),
            );
          },
          onDownloadReceipt: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Receipt downloaded successfully!')),
            );
          },
        );
        break;
      default:
        stepWidget = const SizedBox.shrink();
    }

    return stepWidget
        .animate(key: ValueKey(_currentStep))
        .fade(duration: 250.ms)
        .slideX(begin: 0.08, end: 0, curve: Curves.easeOutQuad);
  }

  Widget _buildBottomNavbarButton() {
    final activeSession = _sessions[_selectedSessionIndex];
    final bool isDetailsStep = _currentStep == 0;
    final bool isPaymentStep = _currentStep == 3;

    final double baseAmount = activeSession.price.toDouble();
    final double taxableAmount = baseAmount - _discountAmount;
    final double gst = taxableAmount * 0.18;
    final double platformFee = 10.0;
    final double grandTotal = taxableAmount + gst + platformFee;

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      decoration: BoxDecoration(
        color: AppColors.card,
        border: Border(top: BorderSide(color: AppColors.divider.withValues(alpha: 0.6), width: 0.8)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isPaymentStep) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Amount to Pay', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.textSecondary)),
                    const SizedBox(height: 3),
                    Text('₹${grandTotal.toStringAsFixed(2)}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: AppColors.textPrimary)),
                  ],
                ),
                SizedBox(
                  width: 148,
                  height: 42,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: _processPaymentSimulated,
                    child: const Text('Pay Now', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.lock_outline_rounded, color: AppColors.textSecondary, size: 11),
                SizedBox(width: 4),
                Text(
                  'Secure Payment. Your data is safe with us.',
                  style: TextStyle(fontSize: 9.5, color: AppColors.textSecondary, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ] else ...[
            SizedBox(
              width: double.infinity,
              height: 44,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: _nextStep,
                child: const Text('Next Step', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
              ),
            ),
            if (isDetailsStep) ...[
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.lock_outline_rounded, color: AppColors.textSecondary, size: 11),
                  SizedBox(width: 4),
                  Text(
                    'Your information is 100% secure and confidential.',
                    style: TextStyle(fontSize: 9.5, color: AppColors.textSecondary, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ]
        ],
      ),
    );
  }
}
