import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:instant_mechanic/core/constants/app_colors.dart';
import 'package:instant_mechanic/core/constants/app_spacing.dart';
import 'package:instant_mechanic/core/constants/app_strings.dart';
import 'package:instant_mechanic/core/theme/app_text_styles.dart';
import 'package:instant_mechanic/data/mock_data.dart';
import 'package:instant_mechanic/models/booking_model.dart';
import 'package:instant_mechanic/models/mechanic_model.dart';
import 'package:instant_mechanic/models/service_model.dart';
import 'package:instant_mechanic/shared/widgets/custom_button.dart';
import 'package:instant_mechanic/shared/widgets/step_indicator.dart';

class RequestServiceScreen extends StatefulWidget {
  final String mechanicId;

  const RequestServiceScreen({
    super.key,
    required this.mechanicId,
  });

  @override
  State<RequestServiceScreen> createState() => _RequestServiceScreenState();
}

class _RequestServiceScreenState extends State<RequestServiceScreen> {
  late MechanicModel mechanic;
  int _currentStep = 1;
  bool _isLoading = true;

  // Form Controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _vehicleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  ServiceModel? _selectedService;
  List<ServiceModel> _availableServices = [];

  @override
  void initState() {
    super.initState();
    _loadMechanicData();
  }

  void _loadMechanicData() {
  Future.delayed(const Duration(milliseconds: 300), () {
    final data = MockData.getMechanicById(widget.mechanicId); // ← Use widget.mechanicId
    if (data != null) {
      setState(() {
        mechanic = data;
        _availableServices = data.services;
        _isLoading = false;
      });
    } else {
      context.pop();
    }
  });
}

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _vehicleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  bool _validateStep1() {
    if (_nameController.text.isEmpty) {
      _showErrorSnackbar('Please enter your name');
      return false;
    }
    if (_phoneController.text.isEmpty || _phoneController.text.length < 10) {
      _showErrorSnackbar('Please enter a valid phone number');
      return false;
    }
    return true;
  }

  bool _validateStep2() {
    if (_vehicleController.text.isEmpty) {
      _showErrorSnackbar('Please enter your vehicle number');
      return false;
    }
    if (_selectedService == null) {
      _showErrorSnackbar('Please select a service');
      return false;
    }
    if (_descriptionController.text.isEmpty) {
      _showErrorSnackbar('Please describe the problem');
      return false;
    }
    return true;
  }

  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.errorRed,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _nextStep() {
    if (_currentStep == 1 && !_validateStep1()) {
      return;
    }
    if (_currentStep == 2 && !_validateStep2()) {
      return;
    }

    if (_currentStep < 3) {
      setState(() {
        _currentStep++;
      });
    } else {
      _submitRequest();
    }
  }

  void _previousStep() {
    if (_currentStep > 1) {
      setState(() {
        _currentStep--;
      });
    }
  }

  void _submitRequest() {
    final booking = BookingModel(
      bookingId: 'BK${DateTime.now().millisecondsSinceEpoch}',
      mechanicId: mechanic.id,
      garageName: mechanic.garageName,
      customerName: _nameController.text,
      phoneNumber: _phoneController.text,
      vehicleNumber: _vehicleController.text,
      selectedService: _selectedService?.name ?? '',
      problemDescription: _descriptionController.text,
      bookingDate: '25 May 2026',
      bookingTime: '10:30 AM',
      estimatedCost: _selectedService?.estimatedCost ?? 0,
      status: 'confirmed',
    );

    context.push('/confirmation', extra: booking.toJson());
  }

  void _showServiceSelector() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppSpacing.radiusLarge),
        ),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(AppSpacing.md16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Service',
              style: AppTextStyles.headingSmall,
            ),
            const SizedBox(height: AppSpacing.md16),
            Flexible(
              child: ListView.builder(
                itemCount: _availableServices.length,
                itemBuilder: (context, index) {
                  final service = _availableServices[index];
                  final isSelected = _selectedService?.id == service.id;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedService = service;
                      });
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: AppSpacing.sm12,
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(AppSpacing.md16),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.bgLightOrange
                              : AppColors.bgWhite,
                          border: Border.all(
                            color: isSelected
                                ? AppColors.primaryOrange
                                : AppColors.borderColor,
                            width: isSelected ? 2 : 1,
                          ),
                          borderRadius: BorderRadius.circular(
                            AppSpacing.radiusMedium,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  service.name,
                                  style: AppTextStyles.bodyMedium.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: AppSpacing.xs4),
                                Text(
                                  '₹${service.estimatedCost.toStringAsFixed(0)}',
                                  style: AppTextStyles.captionMedium.copyWith(
                                    color: AppColors.primaryOrange,
                                  ),
                                ),
                              ],
                            ),
                            if (isSelected)
                              const Icon(
                                Icons.check_circle,
                                color: AppColors.primaryOrange,
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        backgroundColor: AppColors.bgWarmWhite,
        body: Center(
          child: CircularProgressIndicator(
            color: AppColors.primaryOrange,
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.bgWarmWhite,
      appBar: AppBar(
        backgroundColor: AppColors.bgWarmWhite,
        elevation: 0,
        surfaceTintColor: AppColors.bgWarmWhite,
        leading: GestureDetector(
          onTap: () => context.pop(),
          child: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.textDark,
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.requestServiceTitle,
              style: AppTextStyles.headingLarge,
            ),
            Text(
              mechanic.garageName,
              style: AppTextStyles.captionMedium,
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Step Indicator
          StepIndicator(
            currentStep: _currentStep,
            steps: const [
              AppStrings.step1,
              AppStrings.step2,
              AppStrings.step3,
            ],
          ),
          const SizedBox(height: AppSpacing.md20),

          // Form Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.horizontalPadding,
              ),
              child: _buildStepContent(),
            ),
          ),

          // Bottom Button
          _buildBottomSection(),
        ],
      ),
    );
  }

  Widget _buildStepContent() {
    switch (_currentStep) {
      case 1:
        return _buildStep1();
      case 2:
        return _buildStep2();
      case 3:
        return _buildStep3();
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildStep1() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Your Details',
          style: AppTextStyles.headingMedium,
        ),
        const SizedBox(height: AppSpacing.md20),
        _buildTextField(
          controller: _nameController,
          label: AppStrings.customerName,
          hint: 'Enter your full name',
          icon: Icons.person_outline,
        ),
        const SizedBox(height: AppSpacing.md16),
        _buildTextField(
          controller: _phoneController,
          label: AppStrings.phoneNumber,
          hint: '+91 XXXXX XXXXX',
          icon: Icons.phone_outlined,
          keyboardType: TextInputType.phone,
        ),
      ],
    );
  }

  Widget _buildStep2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Vehicle & Problem',
          style: AppTextStyles.headingMedium,
        ),
        const SizedBox(height: AppSpacing.md20),
        _buildTextField(
          controller: _vehicleController,
          label: AppStrings.vehicleNumber,
          hint: 'DL01AB0001',
          icon: Icons.directions_car_outlined,
        ),
        const SizedBox(height: AppSpacing.md16),
        _buildServiceSelector(),
        const SizedBox(height: AppSpacing.md16),
        _buildDescriptionField(),
      ],
    );
  }

  Widget _buildStep3() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Confirm Details',
          style: AppTextStyles.headingMedium,
        ),
        const SizedBox(height: AppSpacing.md20),
        _buildConfirmationCard(
          'Customer Name',
          _nameController.text,
          Icons.person_outline,
        ),
        const SizedBox(height: AppSpacing.md12),
        _buildConfirmationCard(
          'Phone Number',
          _phoneController.text,
          Icons.phone_outlined,
        ),
        const SizedBox(height: AppSpacing.md12),
        _buildConfirmationCard(
          'Vehicle Number',
          _vehicleController.text,
          Icons.directions_car_outlined,
        ),
        const SizedBox(height: AppSpacing.md12),
        _buildConfirmationCard(
          'Service',
          _selectedService?.name ?? 'Not selected',
          Icons.build_outlined,
        ),
        const SizedBox(height: AppSpacing.md12),
        _buildConfirmationCard(
          'Problem Description',
          _descriptionController.text,
          Icons.description_outlined,
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.labelMedium,
        ),
        const SizedBox(height: AppSpacing.xs8),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          style: AppTextStyles.inputText,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: AppTextStyles.inputHint,
            prefixIcon: Icon(
              icon,
              color: AppColors.textSecondary,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.sm16,
              vertical: AppSpacing.sm14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
              borderSide: const BorderSide(
                color: AppColors.borderColor,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
              borderSide: const BorderSide(
                color: AppColors.borderColor,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
              borderSide: const BorderSide(
                color: AppColors.primaryOrange,
                width: 2,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildServiceSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.selectService,
          style: AppTextStyles.labelMedium,
        ),
        const SizedBox(height: AppSpacing.xs8),
        GestureDetector(
          onTap: _showServiceSelector,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.sm16,
              vertical: AppSpacing.sm14,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.borderColor,
              ),
              borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    _selectedService?.name ?? 'Select a service',
                    style: _selectedService != null
                        ? AppTextStyles.inputText
                        : AppTextStyles.inputHint,
                  ),
                ),
                Icon(
                  Icons.expand_more,
                  color: AppColors.textSecondary,
                ),
              ],
            ),
          ),
        ),
        if (_selectedService != null) ...[
          const SizedBox(height: AppSpacing.xs8),
          Text(
            '₹${_selectedService!.estimatedCost.toStringAsFixed(0)} • ~${_selectedService!.estimatedTimeInMinutes}m',
            style: AppTextStyles.captionMedium.copyWith(
              color: AppColors.primaryOrange,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildDescriptionField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.problemDescription,
          style: AppTextStyles.labelMedium,
        ),
        const SizedBox(height: AppSpacing.xs8),
        TextField(
          controller: _descriptionController,
          maxLines: 4,
          maxLength: 300,
          style: AppTextStyles.inputText,
          decoration: InputDecoration(
            hintText: 'Describe the problem in detail...',
            hintStyle: AppTextStyles.inputHint,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.sm16,
              vertical: AppSpacing.sm14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
              borderSide: const BorderSide(
                color: AppColors.borderColor,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
              borderSide: const BorderSide(
                color: AppColors.borderColor,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
              borderSide: const BorderSide(
                color: AppColors.primaryOrange,
                width: 2,
              ),
            ),
          ),
          buildCounter: (context, {required currentLength, required isFocused, maxLength}) {
            return Text(
              '$currentLength/${maxLength ?? 0}',
              style: AppTextStyles.captionSmall,
            );
          },
        ),
      ],
    );
  }

  Widget _buildConfirmationCard(
    String label,
    String value,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md16),
      decoration: BoxDecoration(
        color: AppColors.bgWhite,
        border: Border.all(
          color: AppColors.borderColor,
        ),
        borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: AppColors.primaryOrange,
            size: AppSpacing.iconMedium,
          ),
          const SizedBox(width: AppSpacing.md16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppTextStyles.captionMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs4),
                Text(
                  value,
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomSection() {
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
              CustomButton(
                text: _currentStep == 3 ? 'Submit Request' : AppStrings.continueButton,
                onPressed: _nextStep,
              ),
              const SizedBox(height: AppSpacing.md12),
              if (_currentStep > 1)
                OutlinedButton(
                  onPressed: _previousStep,
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(double.infinity, AppSpacing.buttonHeight),
                  ),
                  child: Text(
                    'Back',
                    style: AppTextStyles.buttonLarge.copyWith(
                      color: AppColors.primaryOrange,
                    ),
                  ),
                ),
              const SizedBox(height: AppSpacing.sm12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.lock_outline,
                    color: AppColors.textSecondary,
                    size: 16,
                  ),
                  const SizedBox(width: AppSpacing.xs4),
                  Text(
                    AppStrings.yourInfoSafe,
                    style: AppTextStyles.captionSmall,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}