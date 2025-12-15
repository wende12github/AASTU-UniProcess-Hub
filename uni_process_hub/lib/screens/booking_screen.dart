// lib/screens/booking_screen.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:uni_process_hub/widgets/custom_text_field.dart';

class BookingScreen extends StatefulWidget {
  final String serviceId;
  const BookingScreen({Key? key, required this.serviceId}) : super(key: key);

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  int _selectedOfficeIndex = 0; // Registrar is selected by default
  String? _selectedTime; // e.g., "10:00 AM"
  final TextEditingController _reasonController = TextEditingController();

  final List<Map<String, String>> offices = [
    {
      'title': 'Registrar',
      'subtitle': 'Records',
      'image':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuBZ5v4tdtEIIMs9WGBuoAdbTbs7jYOSSXI9ulpqldpiF0ro0mDNt0i-O3hj5wqCok5aOWPRGivhXsDkjgFHczHhirXANQdzHDSJuTACdu4K9w87-M6zFplddnjdErR1sKv3FeXoz8-Y5owPpXSTsDPLpPOJVN6gz0cl7amfkzKztPoConVjuuXdsCpP5pYSDABiodFNntNCtBTvOpOwtX41J9xt2iWmV90LoYCjSgfJzcQWX-bKmqFRsD5eIiAww1rxpA69ExB2d2dn',
    },
    {
      'title': 'Library',
      'subtitle': 'Study Rooms',
      'image':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuDORQUbVQZ8G3i9HwwhSIlq_y6-O52i_n97JOeDazcdJExkrSdAKUIIPglR4zEhmOQvXI1Ro66fq3b3D7BP0xkBa2jNBM7BkChbNk9l5bqrrIXseUaHLxjbJtLXB9mZknI-oEvNpLDSfy6j4XsVyFfucgwyx7eLLw5JHcLWiW4OqxGxOcqd7xCadfH8IQfJO_i1S2NqFzEVyUx9k6aBZmTMCijGGCbpJZjvmggFELN3OIENDCT0IkKdHn0-EoeCX5XzzMKWoczKF4KY',
    },
    {
      'title': 'Department',
      'subtitle': 'Advisor',
      'image':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuAmy6gHVGVXdq6SoKufpnqK9XybOhZYWwxwohdFnegoDjBaoeU829pUHLUMDZOB7wX6qCKfg3uTU9YxQVSIbUA7iD7N2hUkvaYUxuOKHc5Ia_WB55WOw-J-EI7TQbqOcHMh0QYyv4dvC5bg-eR-wHaD0y7B6fP601RZoH9Bs87IVAzOWgdumjbdbHAG7pl0aMf4XREDA1fX0I7rRiK08chDIxM3rKMPLvC09piFBnVFSLaPnZtOz7sbFq8PkvDjbyg-eQUNRYxMhBVg',
    },
    {
      'title': 'Clearance',
      'subtitle': 'Exit Form',
      'image':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuBVPaG9fHzu_migioSFpJ_ubude7Zx8OThYi6On4vRF_cDdvfgRouMNrBunOHemNLv2nv6ZWntZNbMSi141iNcw0KHFgWsElgweEp2orbYuRCVOQfPAtvQR90HU1swXREnebitIKEzYy0BkzjF1j6xd-btwNgyaNLyn1RprB_4B5weBYdG1w6zaqz7QlfGEAisEn3wSeE_hYBrswmLx_kIOvH1wJZ7b8NQfAT8ezrVsUPKOq0GNFKtO7rxhXIHKVcrDwyk06Jg3Vu-Z',
    },
  ];

  final List<String> timeSlots = [
    '09:00 AM',
    '09:30 AM',
    '10:00 AM',
    '10:30 AM',
    '11:00 AM',
    '11:30 AM',
    '02:00 PM',
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primary = Theme.of(context).primaryColor;

    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              // Header
              SliverAppBar(
                leading: IconButton(
                  icon: const Icon(Symbols.arrow_back_ios_new),
                  onPressed: () => Navigator.pop(context),
                ),
                title: const Text('Book Appointment'),
                centerTitle: true,
                backgroundColor: isDark
                    ? const Color(0xFF152111)
                    : const Color(0xFFF6F8F6),
                floating: true,
              ),

              // Progress Dots
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      3,
                      (i) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: CircleAvatar(
                          radius: 3,
                          backgroundColor: i == 0
                              ? (isDark ? Colors.white : Colors.black)
                              : (isDark
                                    ? Colors.white24
                                    : Colors.grey.shade300),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // Select Office
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
                  child: Text(
                    'Select Office',
                    style:
                        Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ) ??
                        const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SafeArea(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: offices.length,
                    itemBuilder: (context, index) {
                      final office = offices[index];
                      final selected = _selectedOfficeIndex == index;
                      return GestureDetector(
                        onTap: () =>
                            setState(() => _selectedOfficeIndex = index),
                        child: Container(
                          width: 140,
                          margin: const EdgeInsets.only(right: 16),
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    height: 140,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      image: DecorationImage(
                                        image: NetworkImage(office['image']!),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 140,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      color: selected
                                          ? Colors.black.withValues(alpha: .4)
                                          : Colors.black.withValues(alpha: .3),
                                      border: selected
                                          ? Border.all(color: primary, width: 2)
                                          : null,
                                    ),
                                  ),
                                  if (selected)
                                    Positioned(
                                      bottom: 8,
                                      right: 8,
                                      child: CircleAvatar(
                                        radius: 12,
                                        backgroundColor: primary,
                                        child: const Icon(
                                          Symbols.check,
                                          color: Colors.black,
                                          size: 16,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                office['title']!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                office['subtitle']!,
                                style: TextStyle(
                                  color: Colors.grey.shade500,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),

              // Select Date
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 32, 20, 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Select Date',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Symbols.chevron_left),
                            onPressed: () {},
                          ),
                          Text(
                            'October 2025',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                            icon: const Icon(Symbols.chevron_right),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF1E2B1A) : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isDark ? Colors.white10 : Colors.grey.shade200,
                    ),
                  ),
                  child: _buildCalendar(),
                ),
              ),

              // Select Time
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 32, 20, 8),
                  child: Text(
                    'Select Time',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: timeSlots.map((time) {
                      final booked = time == '11:00 AM';
                      final selected = _selectedTime == time;
                      return GestureDetector(
                        onTap: booked
                            ? null
                            : () => setState(() => _selectedTime = time),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: selected
                                ? primary
                                : (isDark
                                      ? const Color(0xFF1E2B1A)
                                      : Colors.white),
                            border: Border.all(
                              color: booked
                                  ? (isDark
                                        ? Colors.white24
                                        : Colors.grey.shade300)
                                  : (selected
                                        ? primary
                                        : (isDark
                                              ? Colors.white10
                                              : Colors.grey.shade300)),
                            ),
                            borderRadius: BorderRadius.circular(32),
                          ),
                          child: Text(
                            time,
                            style: TextStyle(
                              color: selected
                                  ? Colors.black
                                  : (booked ? Colors.grey.shade400 : null),
                              fontWeight: selected
                                  ? FontWeight.bold
                                  : FontWeight.w400,
                              decoration: booked
                                  ? TextDecoration.lineThrough
                                  : null,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),

              // Reason (Optional)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 32, 20, 100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Reason (Optional)',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      CustomTextField(
                        controller: _reasonController,
                        hintText:
                            'Briefly describe why you are visiting the ${offices[_selectedOfficeIndex]['title']}...',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Bottom Confirm Button
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    isDark ? const Color(0xFF152111) : Colors.white,
                  ],
                ),
              ),
              child: SafeArea(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Schedule',
                              style: TextStyle(
                                color: Colors.grey.shade500,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              _selectedTime != null
                                  ? 'Oct 26, $_selectedTime'
                                  : 'Select time',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'Office',
                              style: TextStyle(
                                color: Colors.grey.shade500,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              offices[_selectedOfficeIndex]['title'] ??
                                  'Office',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(20),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: primary,
            foregroundColor: Colors.black,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 4,
            shadowColor: primary.withValues(alpha: .4),
          ),
          onPressed: _selectedTime == null
              ? null
              : () {
                  // Handle booking confirmation
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Appointment booked!')),
                  );
                },
          child: SizedBox(
            width: double.infinity,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Confirm Booking',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(width: 8),
                Icon(Symbols.check_circle),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCalendar() {
    // Simplified static calendar for October 2023 with Oct 24 selected
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('appointments')
          .snapshots(), // real-time
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(
            child: Text(
              'Error loading calendar',
              style: TextStyle(color: Colors.red),
            ),
          );
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return _calendarGrid(const []);
        }

        // Extract unavailable dates from Firestore
        final unavailableDates = snapshot.data!.docs
            .map((doc) {
              final dateString = doc['date'];
              final parts = dateString.split('-');

              if (parts.length != 3) return null;

              return DateTime(
                int.parse(parts[0]),
                int.parse(parts[1]),
                int.parse(parts[2]),
              );
            })
            .whereType<DateTime>()
            .toList();

        return _calendarGrid(unavailableDates);
      },
    );
  }

  Widget _calendarGrid(List<DateTime> unavailableDates) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
      ),
      itemCount: 42,
      itemBuilder: (context, index) {
        final day = index - 4;
        if (day < 1 || day > 31) return const SizedBox();

        final currentDate = DateTime(2023, 10, day);

        final isUnavailable = unavailableDates.any(
          (d) =>
              d.year == currentDate.year &&
              d.month == currentDate.month &&
              d.day == currentDate.day,
        );

        return Center(
          child: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: isUnavailable ? Colors.grey.shade300 : null,
              shape: BoxShape.circle,
            ),
            child: Center(child: Text('$day')),
          ),
        );
      },
    );
  }
}
