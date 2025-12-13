import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_process_hub/features/queue_status/controller/queue_controller.dart';
import 'package:uni_process_hub/features/queue_status/widgets/search_input.dart';
import 'package:uni_process_hub/features/queue_status/widgets/service_card.dart';
import 'package:uni_process_hub/screens/booking_screen.dart';

class JoinQueueScreen extends StatelessWidget {
  const JoinQueueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Provider.of<QueueController>(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            width: double.infinity,
            constraints: const BoxConstraints(maxWidth: 420),
            margin: const EdgeInsets.symmetric(horizontal: 0),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF131811) : Colors.white,
            ),
            child: Column(
              children: [
                // Top bar
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 18,
                  ),
                  decoration: BoxDecoration(
                    color: isDark
                        ? const Color(0xFF131811).withValues(alpha: .9)
                        : Colors.white.withValues(alpha: .9),
                    // mimic backdrop-blur look by slightly translucent
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Stack(
                            children: [
                              Container(
                                width: 44,
                                height: 44,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: const DecorationImage(
                                    image: NetworkImage(
                                      'https://lh3.googleusercontent.com/aida-public/AB6AXuB-4tyDbTTehCvQeeEWhDME7Uh4kBRJI7dD8YW-yMl6zPizeWgsOqNykej9mrY3n-hl2K76cYs4ED7Owx_4gjQ1Vp42QPtDM3bA4LlxfDy7vWu2HRxFeNImeTmCzxyXrc90FhF4NEobjdSPkQ5oNj3V1TdJbfQPfPfervGIf20rvXCQTaU9nSFv4Mg2u6Zo2Fr3xXZ_5cGlmnP-SeNXae55QpKn7y4pDuv2JNUGUwTwIgrdwxSC_m7k_dH69jYYJe8aaIlb041fxMjH',
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                  border: Border.all(
                                    color: const Color(
                                      0xFF49E619,
                                    ).withValues(alpha: .12),
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 0,
                                bottom: 0,
                                child: Container(
                                  width: 10,
                                  height: 10,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF49E619),
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 2,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Welcome back',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: isDark
                                      ? const Color(0xFFA4B89D)
                                      : Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'Hello, Abebe',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: isDark ? Colors.white : Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Stack(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.notifications,
                              color: isDark ? Colors.white : Colors.grey[700],
                            ),
                          ),
                          Positioned(
                            right: 8,
                            top: 8,
                            child: Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Content
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 6),
                        Text(
                          'Join Queue',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : Colors.black,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Select a service to get in line remotely',
                          style: TextStyle(
                            color: isDark
                                ? const Color(0xFFA4B89D)
                                : Colors.grey[700],
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Search
                        const SearchInput(),
                        const SizedBox(height: 16),

                        // Cards list
                        Column(
                          children: ctrl.filtered.map((s) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 14),
                              child: ServiceCard(
                                service: s,
                                onExpand: () => ctrl.toggleExpand(s.id),
                                // onJoin: () => ctrl.joinQueue(s),
                                onJoin: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          BookingScreen(serviceId: s.id),
                                    ),
                                  );
                                },
                              ),
                            );
                          }).toList(),
                        ),

                        const SizedBox(height: 36),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: open QR scanner
        },
        backgroundColor: const Color(0xFF2A3626),
        child: const Icon(Icons.qr_code_scanner, color: Colors.white),
      ),
      bottomNavigationBar: null, // keep navigation to parent MainNavigation
    );
  }
}
