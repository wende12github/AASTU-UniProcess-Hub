import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:uni_process_hub/core/theme/app_color.dart';
import 'package:uni_process_hub/widgets/custom_text_field.dart';

class BookingScreen extends StatefulWidget {
  final String serviceId;
  const BookingScreen({Key? key, required this.serviceId}) : super(key: key);

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  int _selectedOfficeIndex = 0;
  String? _selectedTime;
  DateTime? _selectedDate;
  DateTime _focusedMonth = DateTime.now();

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

  String _monthName(int m) => const [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ][m - 1];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Symbols.arrow_back_ios_new),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Book Appointment'),
        centerTitle: true,
        backgroundColor: isDark
            ? const Color(0xFF152111)
            : const Color(0xFFF6F8F6),
      ),
      body: CustomScrollView(
        slivers: [
          _progressDots(isDark),
          _sectionTitle('Select Office'),
          _officeSelector(),
          _sectionTitle('Select Date'),
          _calendarSection(isDark),
          _sectionTitle('Select Time'),
          _timeSlotsSection(),
          _sectionTitle('Reason (Optional)'),
          _reasonSection(),
          const SliverToBoxAdapter(child: SizedBox(height: 120)),
        ],
      ),
      bottomNavigationBar: _confirmButton(),
    );
  }

  // UI SECTIONS
  SliverToBoxAdapter _progressDots(bool isDark) {
    return SliverToBoxAdapter(
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
                    : (isDark ? Colors.white24 : Colors.grey.shade300),
              ),
            ),
          ),
        ),
      ),
    );
  }

  SliverToBoxAdapter _sectionTitle(String title) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 8),
        child: Text(
          title,
          style:
              Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold) ??
              const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  SliverToBoxAdapter _officeSelector() {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 210,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemCount: offices.length,
          itemBuilder: (context, index) {
            final office = offices[index];
            final selected = _selectedOfficeIndex == index;

            return GestureDetector(
              onTap: () => setState(() => _selectedOfficeIndex = index),
              child: Container(
                width: 140,
                margin: const EdgeInsets.only(right: 16),
                child: Column(
                  children: [
                    Container(
                      height: 140,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        image: DecorationImage(
                          image: NetworkImage(office['image']!),
                          fit: BoxFit.cover,
                        ),
                        border: selected
                            ? Border.all(color: AppColors.primary, width: 2)
                            : null,
                        boxShadow: selected
                            ? [
                                BoxShadow(
                                  color: AppColors.primary.withValues(
                                    alpha: 0.3,
                                  ),
                                  blurRadius: 12,
                                ),
                              ]
                            : null,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      office['title']!,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
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
    );
  }

  SliverToBoxAdapter _calendarSection(bool isDark) {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E2B1A) : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(16),
        ),
        child: _buildCalendar(),
      ),
    );
  }

  SliverToBoxAdapter _timeSlotsSection() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Wrap(
          spacing: 12,
          runSpacing: 12,
          children: timeSlots.map((time) {
            final selected = _selectedTime == time;
            return ChoiceChip(
              label: Text(time),
              selected: selected,
              selectedColor: AppColors.primary,
              onSelected: (_) => setState(() => _selectedTime = time),
            );
          }).toList(),
        ),
      ),
    );
  }

  SliverToBoxAdapter _reasonSection() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: CustomTextField(
          controller: _reasonController,
          hintText:
              'Briefly describe why you are visiting the ${offices[_selectedOfficeIndex]['title']}...',
        ),
      ),
    );
  }

  Widget _confirmButton() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ElevatedButton(
        onPressed: _selectedDate == null || _selectedTime == null
            ? null
            : _confirmBooking,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text(
          'Confirm Booking',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  // CALENDAR
  Widget _buildCalendar() {
    final now = DateTime.now();

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('appointments')
          .where('serviceId', isEqualTo: widget.serviceId)
          .snapshots(),
      builder: (context, snapshot) {
        final bookedDates =
            snapshot.data?.docs
                .map((d) => (d['date'] as Timestamp).toDate())
                .map((d) => DateTime(d.year, d.month, d.day))
                .toSet() ??
            {};

        final firstDay = DateTime(_focusedMonth.year, _focusedMonth.month, 1);
        final daysInMonth = DateTime(
          _focusedMonth.year,
          _focusedMonth.month + 1,
          0,
        ).day;
        final startOffset = firstDay.weekday % 7;

        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.chevron_left),
                  onPressed: () {
                    setState(() {
                      _focusedMonth = DateTime(
                        _focusedMonth.year,
                        _focusedMonth.month - 1,
                      );
                    });
                  },
                ),
                Text(
                  '${_monthName(_focusedMonth.month)} ${_focusedMonth.year}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.chevron_right),
                  onPressed: () {
                    setState(() {
                      _focusedMonth = DateTime(
                        _focusedMonth.year,
                        _focusedMonth.month + 1,
                      );
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 12),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: startOffset + daysInMonth,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                mainAxisSpacing: 12,
              ),
              itemBuilder: (context, index) {
                if (index < startOffset) return const SizedBox();

                final day = index - startOffset + 1;
                final date = DateTime(
                  _focusedMonth.year,
                  _focusedMonth.month,
                  day,
                );

                final isPast = date.isBefore(
                  DateTime(now.year, now.month, now.day),
                );
                final isBooked = bookedDates.contains(date);
                final isSelected = _selectedDate == date;

                if (isSelected) {
                  return Center(
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: AppColors.primary,
                      child: Text(
                        '$day',
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                }

                return GestureDetector(
                  onTap: isPast || isBooked
                      ? null
                      : () => setState(() => _selectedDate = date),
                  child: Center(
                    child: Text(
                      '$day',
                      style: TextStyle(
                        color: isPast || isBooked
                            ? Colors.grey.withValues(alpha: .4)
                            : null,
                        decoration: isBooked
                            ? TextDecoration.lineThrough
                            : null,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _confirmBooking() async {
    await FirebaseFirestore.instance.collection('appointments').add({
      'serviceId': widget.serviceId,
      'office': offices[_selectedOfficeIndex]['title'],
      'date': Timestamp.fromDate(_selectedDate!),
      'time': _selectedTime,
      'reason': _reasonController.text.trim(),
      'createdAt': FieldValue.serverTimestamp(),
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Appointment booked successfully')),
    );

    Navigator.pop(context);
  }
}
