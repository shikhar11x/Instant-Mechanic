import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:instant_mechanic/core/constants/app_colors.dart';
import 'package:instant_mechanic/core/constants/app_spacing.dart';
import 'package:instant_mechanic/core/constants/app_strings.dart';
import 'package:instant_mechanic/core/theme/app_text_styles.dart';
import 'package:instant_mechanic/models/booking_model.dart';
import 'package:instant_mechanic/shared/widgets/booking_details_card.dart';
import 'package:instant_mechanic/shared/widgets/custom_button.dart';

class ConfirmationScreen extends StatefulWidget {
  final Map<String, dynamic> bookingDetails;

  const ConfirmationScreen({
    super.key,
    required this.bookingDetails,
  });

  @override
  State<ConfirmationScreen> createState() => _ConfirmationScreenState();
}

class _ConfirmationScreenState extends State<ConfirmationScreen>
    with SingleTickerProviderStateMixin {
  late BookingModel booking;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    booking = BookingModel.fromJson(widget.bookingDetails);
    
    _setupAnimations();
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: AppColors.bgWarmWhite,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.horizontalPadding,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: AppSpacing.xl56),

                  // Success Animation
                  _buildSuccessAnimation(),

                  const SizedBox(height: AppSpacing.lg32),

                  // Title
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: Text(
                      AppStrings.requestSubmitted,
                      style: AppTextStyles.displayMedium,
                      textAlign: TextAlign.center,
                    ),
                  ),

                  const SizedBox(height: AppSpacing.sm12),

                  // Subtitle
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: Text(
                      AppStrings.requestSubmittedDesc,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textSecondary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  const SizedBox(height: AppSpacing.lg32),

                  // Booking Details Card
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: BookingDetailsCard(
                      title: AppStrings.bookingDetails,
                      details: [
                        BookingDetailRow(
                          label: AppStrings.garage,
                          value: booking.garageName,
                        ),
                        BookingDetailRow(
                          label: AppStrings.service,
                          value: booking.selectedService,
                        ),
                        BookingDetailRow(
                          label: 'Customer',
                          value: booking.customerName,
                        ),
                        BookingDetailRow(
                          label: 'Vehicle',
                          value: booking.vehicleNumber,
                        ),
                        BookingDetailRow(
                          label: AppStrings.date,
                          value: booking.bookingDate,
                        ),
                        BookingDetailRow(
                          label: AppStrings.time,
                          value: booking.bookingTime,
                        ),
                        BookingDetailRow(
                          label: 'Estimated Cost',
                          value: '₹${booking.estimatedCost.toStringAsFixed(0)}',
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: AppSpacing.lg32),

                  // Info Card
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: Container(
                      padding: const EdgeInsets.all(AppSpacing.md16),
                      decoration: BoxDecoration(
                        color: AppColors.bgLightOrange,
                        borderRadius: BorderRadius.circular(
                          AppSpacing.radiusCard,
                        ),
                        border: Border.all(
                          color: AppColors.primaryOrange.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: AppColors.primaryOrange,
                            size: AppSpacing.iconMedium,
                          ),
                          const SizedBox(width: AppSpacing.sm16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'What\'s Next?',
                                  style: AppTextStyles.bodyMedium.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.primaryOrange,
                                  ),
                                ),
                                const SizedBox(height: AppSpacing.xs4),
                                Text(
                                  'The mechanic will contact you shortly to confirm the appointment.',
                                  style: AppTextStyles.captionMedium.copyWith(
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: AppSpacing.xl56),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: _buildBottomButtons(),
      ),
    );
  }

  Widget _buildSuccessAnimation() {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Decorative circles
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.successGreen.withValues(alpha: 0.1),
            ),
          ),
          Container(
            width: 140,
            height: 140,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.successGreen.withValues(alpha: 0.2),
            ),
          ),
          // Checkmark
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.successGreen,
            ),
            child: const Icon(
              Icons.check_rounded,
              color: Colors.white,
              size: 60,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomButtons() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.bgWhite,
        border: Border(
          top: BorderSide(
            color: AppColors.borderColor,
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Primary Button
              FadeTransition(
                opacity: _fadeAnimation,
                child: CustomButton(
                  text: AppStrings.viewMyBookings,
                  onPressed: () {
                    context.go('/');
                  },
                ),
              ),
              const SizedBox(height: AppSpacing.md12),

              // Secondary Button
              FadeTransition(
                opacity: _fadeAnimation,
                child: OutlinedButton(
                  onPressed: () {
                    context.go('/');
                  },
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(
                      double.infinity,
                      AppSpacing.buttonHeight,
                    ),
                    side: const BorderSide(
                      color: AppColors.borderColor,
                    ),
                  ),
                  child: Text(
                    AppStrings.backToHome,
                    style: AppTextStyles.buttonLarge.copyWith(
                      color: AppColors.textDark,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}