import 'package:flutter/material.dart';
import 'package:instant_mechanic/core/constants/app_colors.dart';
import 'package:instant_mechanic/core/constants/app_spacing.dart';
import 'package:instant_mechanic/core/theme/app_text_styles.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final bool isEnabled;
  final ButtonVariant variant;
  final double? width;
  final double? height;
  final EdgeInsets? padding;
  final TextStyle? textStyle;
  final Widget? icon;
  final bool isFullWidth;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.isEnabled = true,
    this.variant = ButtonVariant.primary,
    this.width,
    this.height,
    this.padding,
    this.textStyle,
    this.icon,
    this.isFullWidth = true,
  });

  @override
  Widget build(BuildContext context) {
    final buttonHeight = height ?? AppSpacing.buttonHeight;
    final buttonWidth = isFullWidth ? double.infinity : (width ?? 200);

    return SizedBox(
      width: buttonWidth,
      height: buttonHeight,
      child: _buildButton(),
    );
  }

  Widget _buildButton() {
    switch (variant) {
      case ButtonVariant.primary:
        return _buildPrimaryButton();
      case ButtonVariant.secondary:
        return _buildSecondaryButton();
      case ButtonVariant.outline:
        return _buildOutlineButton();
      case ButtonVariant.text:
        return _buildTextButton();
    }
  }

  Widget _buildPrimaryButton() {
    return ElevatedButton(
      onPressed: isEnabled && !isLoading ? onPressed : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryOrange,
        disabledBackgroundColor: AppColors.disabled,
        padding: padding ??
            const EdgeInsets.symmetric(
              horizontal: AppSpacing.md24,
              vertical: AppSpacing.sm12,
            ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusButton),
        ),
      ),
      child: _buildButtonContent(),
    );
  }

  Widget _buildSecondaryButton() {
    return ElevatedButton(
      onPressed: isEnabled && !isLoading ? onPressed : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.bgLightOrange,
        disabledBackgroundColor: AppColors.disabled,
        padding: padding ??
            const EdgeInsets.symmetric(
              horizontal: AppSpacing.md24,
              vertical: AppSpacing.sm12,
            ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusButton),
        ),
      ),
      child: _buildButtonContent(
        textColor: AppColors.primaryOrange,
      ),
    );
  }

  Widget _buildOutlineButton() {
    return OutlinedButton(
      onPressed: isEnabled && !isLoading ? onPressed : null,
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primaryOrange,
        side: const BorderSide(color: AppColors.borderColor),
        disabledForegroundColor: AppColors.disabled,
        padding: padding ??
            const EdgeInsets.symmetric(
              horizontal: AppSpacing.md24,
              vertical: AppSpacing.sm12,
            ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusButton),
        ),
      ),
      child: _buildButtonContent(
        textColor: AppColors.primaryOrange,
      ),
    );
  }

  Widget _buildTextButton() {
    return TextButton(
      onPressed: isEnabled && !isLoading ? onPressed : null,
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primaryOrange,
        padding: padding ??
            const EdgeInsets.symmetric(
              horizontal: AppSpacing.sm16,
              vertical: AppSpacing.xs8,
            ),
      ),
      child: _buildButtonContent(
        textColor: AppColors.primaryOrange,
      ),
    );
  }

  Widget _buildButtonContent({Color? textColor}) {
    if (isLoading) {
      return SizedBox(
        height: 24,
        width: 24,
        child: CircularProgressIndicator(
          strokeWidth: 2.5,
          valueColor: AlwaysStoppedAnimation<Color>(
            textColor ?? Colors.white,
          ),
        ),
      );
    }

    if (icon != null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          icon!,
          const SizedBox(width: AppSpacing.xs8),
          Text(
            text,
            style: textStyle ?? AppTextStyles.buttonLarge,
          ),
        ],
      );
    }

    return Text(
      text,
      style: textStyle ??
          (textColor != null
              ? AppTextStyles.buttonLarge.copyWith(color: textColor)
              : AppTextStyles.buttonLarge),
      textAlign: TextAlign.center,
    );
  }
}

enum ButtonVariant {
  primary,
  secondary,
  outline,
  text,
}