import 'package:flutter/material.dart';

import 'package:instant_mechanic/core/constants/app_colors.dart';
import 'package:instant_mechanic/core/theme/app_text_styles.dart';

class SearchBarWidget extends StatefulWidget {
  final String hintText;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onFilterPressed;
  final TextEditingController? controller;
  final bool showFilterButton;

  const SearchBarWidget({
    super.key,
    this.hintText = 'Search services or mechanics',
    this.onChanged,
    this.onFilterPressed,
    this.controller,
    this.showFilterButton = true,
  });

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  late TextEditingController _controller;

  final FocusNode _focusNode = FocusNode();

  bool _hasText = false;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();

    _controller = widget.controller ?? TextEditingController();

    _hasText = _controller.text.isNotEmpty;

    _controller.addListener(_handleTextChange);
    _focusNode.addListener(_handleFocusChange);
  }

  void _handleTextChange() {
    if (!mounted) return;

    setState(() {
      _hasText = _controller.text.isNotEmpty;
    });
  }

  void _handleFocusChange() {
    if (!mounted) return;

    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  void _clearSearch() {
    _controller.clear();
    widget.onChanged?.call('');
  }

  @override
  void dispose() {
    _controller.removeListener(_handleTextChange);
    _focusNode.removeListener(_handleFocusChange);

    if (widget.controller == null) {
      _controller.dispose();
    }

    _focusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    final height = width < 360 ? 50.0 : 54.0;
    final horizontalPadding = width < 360 ? 16.0 : 20.0;
    final filterSize = width < 360 ? 50.0 : 54.0;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: 8,
      ),
      child: Row(
        children: [
          Expanded(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: height,
              decoration: BoxDecoration(
                color: AppColors.bgWhite,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: _isFocused
                      ? AppColors.primaryOrange.withValues(alpha: 0.7)
                      : AppColors.borderColor.withValues(alpha: 0.35),
                ),
                boxShadow: [
                  BoxShadow(
                    color: _isFocused
                        ? AppColors.primaryOrange.withValues(alpha: 0.10)
                        : Colors.black.withValues(alpha: 0.025),
                    blurRadius: _isFocused ? 14 : 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  const SizedBox(width: 16),

                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    child: Icon(
                      Icons.search_rounded,
                      size: 22,
                      color: _isFocused
                          ? AppColors.primaryOrange
                          : AppColors.textSecondary,
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: TextField(
                      controller: _controller,
                      focusNode: _focusNode,
                      onChanged: widget.onChanged,
                      cursorColor: AppColors.primaryOrange,
                      textAlignVertical: TextAlignVertical.center,
                      style: AppTextStyles.inputText,
                      decoration: InputDecoration(
                        hintText: widget.hintText,
                        hintStyle: AppTextStyles.inputHint.copyWith(
                          color: AppColors.textSecondary.withValues(alpha: 0.75),
                        ),
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                        isDense: true,
                      ),
                    ),
                  ),

                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 150),
                    child: _hasText
                        ? IconButton(
                            key: const ValueKey('clear'),
                            onPressed: _clearSearch,
                            icon: Container(
                              width: 28,
                              height: 28,
                              decoration: BoxDecoration(
                                color: Colors.black.withValues(alpha: 0.05),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.close_rounded,
                                size: 17,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          )
                        : const SizedBox(
                            key: ValueKey('empty'),
                            width: 12,
                          ),
                  ),
                ],
              ),
            ),
          ),

          if (widget.showFilterButton) ...[
            const SizedBox(width: 10),

            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: widget.onFilterPressed,
                borderRadius: BorderRadius.circular(16),
                child: Ink(
                  width: filterSize,
                  height: filterSize,
                  decoration: BoxDecoration(
                    color: AppColors.primaryOrange,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color:
                            AppColors.primaryOrange.withValues(alpha: 0.22),
                        blurRadius: 12,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.tune_rounded,
                      color: Colors.white,
                      size: 22,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}