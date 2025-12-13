// lib/screens/join_queue_screen.dart

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';
import 'package:uni_process_hub/core/theme/app_color.dart';
import '../providers/app_state.dart';

class JoinQueueScreen extends StatelessWidget {
  const JoinQueueScreen({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> services = const [
    {
      'title': 'Registrar Office',
      'location': 'Window 1-4 • Admin Bldg',
      'description':
          'Handles student registration, grade report issuance, academic record corrections, and readmission requests.',
      'hours': '8:30 AM - 4:30 PM',
      'avgService': '~15 mins / person',
      'currentWait': '25 min',
      'peopleInLine': 14,
      'status': 'Open',
      'expanded': true,
      'icon': Symbols.how_to_reg,
    },
    {
      'title': 'Student Clinic',
      'location': 'OPD • Ground Floor',
      'wait': '10 min',
      'people': 3,
      'status': 'Open',
      'icon': Symbols.medical_services,
    },
    {
      'title': 'Library Services',
      'location': 'Book Return & Loan',
      'wait': '< 5 min',
      'people': 1,
      'status': 'Fast',
      'statusColor': Colors.green,
      'icon': Symbols.local_library,
    },
    {
      'title': 'Student Cafeteria',
      'location': 'Lunch Service',
      'wait': '45 min',
      'people': 82,
      'status': 'Busy',
      'statusColor': Colors.orange,
      'icon': Symbols.restaurant,
    },
    {
      'title': 'Discipline Office',
      'location': 'Opens at 2:00 PM',
      'status': 'Closed',
      'closed': true,
      'icon': Symbols.gavel,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primary = Theme.of(context).primaryColor;
    final userName = Provider.of<AppState>(context).userName;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            CustomScrollView(
              slivers: [
                // Top App Bar (same as Home & Forms)
                SliverPersistentHeader(
                  delegate: _TopAppBarDelegate(userName: userName, isDark: isDark),
                  pinned: true,
                ),

                // Title & Search
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Join Queue',
                          style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Select a service to get in line remotely',
                          style: TextStyle(color: isDark ? const Color(0xFFA4B89D) : Colors.grey.shade600, fontSize: 14),
                        ),
                        const SizedBox(height: 20),
                        // Search Bar
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'Search services, departments...',
                            prefixIcon: Icon(Symbols.search, color: const Color(0xFFA4B89D)),
                            filled: true,
                            fillColor: isDark ? const Color(0xFF1E261C) : Colors.grey.shade50,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Services List
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final service = services[index];
                        final bool isExpanded = service['expanded'] ?? false;
                        final bool isClosed = service['closed'] ?? false;

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: isDark ? const Color(0xFF1E261C) : Colors.white,
                              borderRadius: BorderRadius.circular(32),
                              border: Border.all(
                                color: isClosed
                                    ? (isDark ? Colors.grey.shade700 : Colors.grey.shade300)
                                    : (service['title'] == 'Registrar Office'
                                        ? primary.withOpacity(0.4)
                                        : (isDark ? const Color(0xFF41533C).withOpacity(0.3) : Colors.grey.shade300)),
                              ),
                              boxShadow: service['title'] == 'Registrar Office'
                                  ? [BoxShadow(color: primary.withOpacity(0.2), blurRadius: 20)]
                                  : null,
                            ),
                            child: Column(
                              children: [
                                // Header Row
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                        color: isDark ? const Color(0xFF131811) : Colors.grey.shade50,
                                        borderRadius: BorderRadius.circular(24),
                                        border: Border.all(color: const Color(0xFF41533C).withOpacity(0.3)),
                                      ),
                                      child: Icon(
                                        service['icon'],
                                        color: isClosed ? Colors.grey.shade500 : primary,
                                        size: 28,
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            service['title'],
                                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                          ),
                                          Text(
                                            service['location'],
                                            style: TextStyle(color: isDark ? const Color(0xFFA4B89D) : Colors.grey.shade600, fontSize: 13),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                          decoration: BoxDecoration(
                                            color: (service['statusColor'] ?? primary).withOpacity(0.1),
                                            borderRadius: BorderRadius.circular(32),
                                            border: Border.all(color: (service['statusColor'] ?? primary).withOpacity(0.2)),
                                          ),
                                          child: Row(
                                            children: [
                                              if (service['status'] == 'Open' || service['status'] == 'Fast')
                                                const Padding(
                                                  padding: EdgeInsets.only(right: 4),
                                                  child: SizedBox(
                                                    width: 8,
                                                    height: 8,
                                                    child: DecoratedBox(
                                                      decoration: BoxDecoration(color: Color(0xFF49E619), shape: BoxShape.circle),
                                                    ),
                                                  ),
                                                ),
                                              Text(
                                                service['status'],
                                                style: TextStyle(
                                                  color: service['statusColor'] ?? primary,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 10,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Icon(
                                          isExpanded ? Symbols.expand_less : Symbols.expand_more,
                                          color: isDark ? const Color(0xFFA4B89D) : Colors.grey.shade500,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),

                                // Expanded Content (only for Registrar as in design)
                                if (isExpanded) ...[
                                  const Divider(height: 40, color: Color(0xFF41533C), thickness: 0.5),
                                  // Description
                                  Text(
                                    'Description',
                                    style: TextStyle(
                                      color: isDark ? const Color(0xFF6F8569) : Colors.grey.shade500,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.2,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    service['description'],
                                    style: TextStyle(color: isDark ? Colors.grey.shade300 : Colors.grey.shade700, height: 1.5),
                                  ),
                                  const SizedBox(height: 20),

                                  // Hours & Avg Service
                                  Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: isDark ? const Color(0xFF131811).withOpacity(0.6) : Colors.grey.shade50,
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(color: const Color(0xFF41533C).withOpacity(0.2)),
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: _infoColumn(Symbols.schedule as Symbol, 'Hours', service['hours'], isDark),
                                        ),
                                        Container(width: 1, height: 40, color: const Color(0xFF41533C).withOpacity(0.3)),
                                        Expanded(
                                          child: _infoColumn(Symbols.timelapse as Symbol, 'Avg. Service', service['avgService'], isDark, leftPadding: 16),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 20),

                                  // Current Stats
                                  Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: isDark ? const Color(0xFF131811) : Colors.grey.shade900,
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(color: const Color(0xFF41533C).withOpacity(0.3)),
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: _statItem('Current Wait', service['currentWait'], Symbols.hourglass_top as Symbol, isDark),
                                        ),
                                        Container(width: 1, height: 40, color: const Color(0xFF41533C).withOpacity(0.3)),
                                        Expanded(
                                          child: _statItem('People in Line', service['peopleInLine'].toString(), Symbols.groups as Symbol, isDark),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 24),

                                  // Join Button
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton.icon(
                                      onPressed: () {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: Text('Joined ${service['title']} queue!')),
                                        );
                                      },
                                      icon: const Icon(Symbols.arrow_forward),
                                      label: Text('Join ${service['title'].split(' ').first} Queue', style: const TextStyle(fontWeight: FontWeight.bold)),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: primary,
                                        foregroundColor: const Color(0xFF131811),
                                        padding: const EdgeInsets.symmetric(vertical: 16),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                        elevation: 4,
                                        shadowColor: primary.withOpacity(0.4),
                                      ),
                                    ),
                                  ),
                                ] else if (!isClosed) ...[
                                  // Compact view for non-expanded
                                  const SizedBox(height: 16),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      _quickStat(Symbols.schedule as Symbol, service['wait'] ?? '-', 'wait', isDark, color: service['statusColor']),
                                      Container(width: 1, height: 24, color: const Color(0xFF41533C).withOpacity(0.3)),
                                      _quickStat(Symbols.group as Symbol, service['people']?.toString() ?? '-', 'in line', isDark),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      onPressed: isClosed
                                          ? null
                                          : () {
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(content: Text('Joined ${service['title']} queue!')),
                                              );
                                            },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: isClosed ? Colors.grey.shade700 : (isDark ? const Color(0xFF2A3626) : Colors.grey.shade50),
                                        foregroundColor: isClosed ? Colors.grey.shade500 : primary,
                                        padding: const EdgeInsets.symmetric(vertical: 12),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                        side: BorderSide(color: primary.withOpacity(0.3)),
                                      ),
                                      child: Text(isClosed ? 'Queue Unavailable' : 'Join Queue', style: const TextStyle(fontWeight: FontWeight.bold)),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        );
                      },
                      childCount: services.length,
                    ),
                  ),
                ),

                SliverToBoxAdapter(child: SizedBox(height: 120)), // Space for FAB
              ],
            ),

            // Floating QR Scanner Button
            Positioned(
              bottom: 24,
              right: 16,
              child: FloatingActionButton(
                backgroundColor: isDark ? const Color(0xFF2A3626) : Colors.white,
                foregroundColor: Colors.white,
                elevation: 8,
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('QR Scanner opened')));
                },
                child: const Icon(Symbols.qr_code_scanner, size: 32),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoColumn(Symbol icon, String label, String value, bool isDark, {double leftPadding = 0}) {
    return Padding(
      padding: EdgeInsets.only(left: leftPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon as IconData?, size: 16, color: isDark ? const Color(0xFFA4B89D) : Colors.grey.shade500),
              const SizedBox(width: 8),
              Text(label, style: TextStyle(color: isDark ? const Color(0xFFA4B89D) : Colors.grey.shade500, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1)),
            ],
          ),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _statItem(String label, String value, Symbol icon, bool isDark) {
    return Column(
      children: [
        Text(label, style: TextStyle(color: isDark ? const Color(0xFFA4B89D) : Colors.grey.shade500, fontSize: 10, letterSpacing: 1)),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon as IconData?, color: AppColors.primary, size: 18),
            const SizedBox(width: 8),
            Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          ],
        ),
      ],
    );
  }

  Widget _quickStat(Symbol icon, String value, String label, bool isDark, {Color? color}) {
    return Row(
      children: [
        Icon(icon as IconData?, color: color ?? (isDark ? Colors.grey.shade500 : Colors.grey.shade600)),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(label, style: TextStyle(color: isDark ? const Color(0xFFA4B89D) : Colors.grey.shade600, fontSize: 12)),
          ],
        ),
      ],
    );
  }
}

// Reusable Top App Bar Delegate (same as FormsScreen)
class _TopAppBarDelegate extends SliverPersistentHeaderDelegate {
  final String userName;
  final bool isDark;

  _TopAppBarDelegate({required this.userName, required this.isDark});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: (isDark ? const Color(0xFF131811) : Colors.white).withOpacity(0.9),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Row(
            children: [
              Stack(
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(
                      'https://lh3.googleusercontent.com/aida-public/AB6AXuB-4tyDbTTehCvQeeEWhDME7Uh4kBRJI7dD8YW-yMl6zPizeWgsOqNykej9mrY3n-hl2K76cYs4ED7Owx_4gjQ1Vp42QPtDM3bA4LlxfDy7vWu2HRxFeNImeTmCzxyXrc90FhF4NEobjdSPkQ5oNj3V1TdJbfQPfPfervGIf20rvXCQTaU9nSFv4Mg2u6Zo2Fr3xXZ_5cGlmnP-SeNXae55QpKn7y4pDuv2JNUGUwTwIgrdwxSC_m7k_dH69jYYJe8aaIlb041fxMjH',
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: const Color(0xFF49E619),
                        shape: BoxShape.circle,
                        border: Border.all(color: isDark ? const Color(0xFF131811) : Colors.white, width: 2),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Welcome back', style: TextStyle(color: Colors.grey.shade500, fontSize: 12)),
                  Text('Hello, $userName', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                ],
              ),
              const Spacer(),
              Stack(
                children: [
                  IconButton(icon: const Icon(Symbols.notifications), onPressed: () {}),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(width: 8, height: 8, decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  double get maxExtent => 92;
  @override
  double get minExtent => 92;
  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => true;
}