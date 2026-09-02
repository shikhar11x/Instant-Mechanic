import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:instant_mechanic/core/constants/app_colors.dart';
import 'package:instant_mechanic/core/constants/app_spacing.dart';
import 'package:instant_mechanic/core/constants/app_strings.dart';
import 'package:instant_mechanic/core/theme/app_text_styles.dart';
import 'package:instant_mechanic/data/mock_data.dart';
import 'package:instant_mechanic/models/mechanic_model.dart';
import 'package:instant_mechanic/shared/widgets/bottom_navigation.dart';
import 'package:instant_mechanic/shared/widgets/location_card.dart';
import 'package:instant_mechanic/shared/widgets/mechanic_card.dart';
import 'package:instant_mechanic/shared/widgets/search_bar_widget.dart';
import 'package:instant_mechanic/shared/widgets/section_title.dart';
import 'package:instant_mechanic/shared/widgets/service_card.dart';
import 'package:instant_mechanic/shared/widgets/app_drawer.dart'; // ✅ ADD THIS IMPORT

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentNavIndex = 0;
  late List<MechanicModel> _mechanics;
  late List<MechanicModel> _filteredMechanics;
  String _searchQuery = '';
  String _sortBy = 'recommended';
  
  // ✅ ADD THIS GLOBAL KEY
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _mechanics = MockData.allMechanics;
    _filteredMechanics = _mechanics;
  }

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query.toLowerCase();
      _filterAndSort();
    });
  }

  void _filterAndSort() {
    _filteredMechanics = _mechanics;

    // Apply search filter
    if (_searchQuery.isNotEmpty) {
      _filteredMechanics = _filteredMechanics
          .where(
            (m) =>
                m.garageName.toLowerCase().contains(_searchQuery) ||
                m.location.toLowerCase().contains(_searchQuery),
          )
          .toList();
    }

    // Apply sorting
    switch (_sortBy) {
      case 'rating':
        _filteredMechanics.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      case 'distance':
        _filteredMechanics.sort((a, b) => a.distanceKm.compareTo(b.distanceKm));
        break;
      default:
        // Keep original order
        break;
    }
  }

  void _showSortOptions() {
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
            Text('Sort By', style: AppTextStyles.headingSmall),
            const SizedBox(height: AppSpacing.md20),
            _buildSortOption('Recommended', 'recommended'),
            _buildSortOption('Highest Rating', 'rating'),
            _buildSortOption('Nearest', 'distance'),
            const SizedBox(height: AppSpacing.md20),
          ],
        ),
      ),
    );
  }

  Widget _buildSortOption(String label, String value) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _sortBy = value;
          _filterAndSort();
        });
        Navigator.pop(context);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: AppTextStyles.bodyMedium.copyWith(
                fontWeight: _sortBy == value
                    ? FontWeight.w700
                    : FontWeight.w500,
              ),
            ),
            if (_sortBy == value)
              const Icon(Icons.check_circle, color: AppColors.primaryOrange),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ✅ ADD KEY HERE
      key: _scaffoldKey,
      backgroundColor: AppColors.bgWarmWhite,
      // ✅ ADD DRAWER HERE
      drawer: const AppDrawer(),
      appBar: AppBar(
        backgroundColor: AppColors.bgWarmWhite,
        elevation: 0,
        surfaceTintColor: AppColors.bgWarmWhite,
        leading: Padding(
          padding: const EdgeInsets.only(left: AppSpacing.horizontalPadding),
          child: GestureDetector(
            // ✅ UPDATED: Use GlobalKey instead of Scaffold.of()
            onTap: () {
              _scaffoldKey.currentState?.openDrawer();
            },
            child: Icon(
              Icons.menu_rounded,
              color: AppColors.textDark,
              size: AppSpacing.iconMedium,
            ),
          ),
        ),
        title: SvgPicture.network(
          'https://instantmechanic.online/assets/img/logo.svg',
          height: 40,
        ),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: AppSpacing.horizontalPadding),
            child: GestureDetector(
              onTap: () {
                // TODO: Navigate to notifications screen
              },
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  Icon(
                    Icons.notifications_outlined,
                    color: AppColors.textDark,
                    size: AppSpacing.iconMedium,
                  ),
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: AppColors.errorRed,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Section
            _buildHeroSection(),
            const SizedBox(height: AppSpacing.md20),

            // Location Card
            LocationCard(
              location: 'Connaught Place, New Delhi',
              subtitle: 'Change location',
              onTap: () {},
            ),
            const SizedBox(height: AppSpacing.md20),

            // Search Bar
            SearchBarWidget(
              hintText: AppStrings.searchPlaceholder,
              onChanged: _onSearchChanged,
              onFilterPressed: _showSortOptions,
              showFilterButton: true,
            ),
            const SizedBox(height: AppSpacing.md24),

            // Popular Services
            SectionTitle(
              title: AppStrings.popularServices,
              actionText: AppStrings.viewAll,
              onActionPressed: () {},
            ),
            const SizedBox(height: AppSpacing.sm12),
            _buildPopularServicesSection(),
            const SizedBox(height: AppSpacing.md24),

            // Nearby Mechanics
            SectionTitle(
              title: AppStrings.nearbyMechanics,
              actionText: AppStrings.sort,
              onActionPressed: _showSortOptions,
            ),
            const SizedBox(height: AppSpacing.sm12),
            if (_filteredMechanics.isEmpty)
              Padding(
                padding: const EdgeInsets.all(AppSpacing.md20),
                child: Center(
                  child: Text(
                    'No mechanics found',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              )
            else
              Column(
                children: _filteredMechanics
                    .map(
                      (mechanic) => MechanicCard(
                        mechanic: mechanic,
                        onTap: () {
                          context.push('/mechanic-details/${mechanic.id}');
                        },
                      ),
                    )
                    .toList(),
              ),
            const SizedBox(height: AppSpacing.xl56),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigation(
        currentIndex: _currentNavIndex,
        onTap: (index) {
          setState(() {
            _currentNavIndex = index;
          });
        },
        items: [
          BottomNavItem(icon: Icons.home_rounded, label: AppStrings.navHome),
          BottomNavItem(
            icon: Icons.bookmark_rounded,
            label: AppStrings.navBookings,
          ),
          BottomNavItem(
            icon: Icons.message_rounded,
            label: AppStrings.navMessages,
          ),
          BottomNavItem(
            icon: Icons.person_rounded,
            label: AppStrings.navProfile,
          ),
        ],
      ),
    );
  }

  Widget _buildHeroSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.horizontalPadding,
        vertical: AppSpacing.verticalPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppStrings.indiasMostTrusted, style: AppTextStyles.tagline),
          const SizedBox(height: AppSpacing.sm12),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Your Car\nDeserves\n',
                  style: AppTextStyles.displayLarge,
                ),
                TextSpan(
                  text: 'Expert Care',
                  style: AppTextStyles.displayLarge.copyWith(
                    color: AppColors.primaryOrange,
                  ),
                ),
                TextSpan(
                  text: ',\nNot a Gamble.',
                  style: AppTextStyles.displayLarge,
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md20),
          Text(
            AppStrings.heroSubtext,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppSpacing.md20),
          // Hero Image Placeholder
          Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              color: AppColors.bgLightOrange,
              borderRadius: BorderRadius.circular(AppSpacing.radiusCard),
            ),
            child: Center(
              child: Image.network(
                'https://customers-car-image.s3.ap-south-1.amazonaws.com/car-images/7c8ab28a-90df-4fe7-9fec-f1229039890f.png',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    Icons.directions_car_rounded,
                    size: 80,
                    color: AppColors.primaryOrange,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPopularServicesSection() {
    return SizedBox(
      height: 140,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.horizontalPadding,
        ),
        itemCount: MockData.popularServices.length,
        itemBuilder: (context, index) {
          final service = MockData.popularServices[index];
          return Padding(
            padding: EdgeInsets.only(
              right: index == MockData.popularServices.length - 1
                  ? 0
                  : AppSpacing.sm12,
            ),
            child: ServiceCard(service: service, isCompact: true, onTap: () {}),
          );
        },
      ),
    );
  }
}