import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:uni_process_hub/features/model/service_model.dart';
import 'join_button.dart';

class ServiceCard extends StatelessWidget {
  final ServiceModels service;
  final VoidCallback onExpand;
  final VoidCallback onJoin;

  const ServiceCard({
    super.key,
    required this.service,
    required this.onExpand,
    required this.onJoin,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final Color primary = const Color(0xFF49E619);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      margin: const EdgeInsets.symmetric(horizontal: 0),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E261C) : Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isDark
              ? const Color(0xFF41533C).withValues(alpha: .3)
              : primary.withValues(alpha: .04),
        ),
        boxShadow: isDark
            ? []
            : [
                BoxShadow(
                  color: Colors.grey.shade200,
                  blurRadius: 14,
                  offset: const Offset(0, 8),
                ),
              ],
      ),
      child: Column(
        children: [
          // top row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: isDark
                      ? const Color(0xFF131811)
                      : const Color(0xFFF6F8F6),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: isDark
                        ? const Color(0xFF41533C).withValues(alpha: .3)
                        : Colors.grey.shade100,
                  ),
                ),
                child: Center(
                  child: Icon(
                    // map each service to the closest symbol
                    service.id == 'registrar'
                        ? Icons.how_to_reg
                        : service.id == 'clinic'
                        ? Icons.medical_services
                        : service.id == 'library'
                        ? Icons.local_library
                        : service.id == 'cafeteria'
                        ? Icons.restaurant
                        : Icons.gavel,
                    size: 26,
                    color: isDark ? Colors.grey[300] : Colors.grey[700],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      service.title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      service.subtitle,
                      style: TextStyle(
                        fontSize: 12,
                        color: isDark
                            ? const Color(0xFFA4B89D)
                            : Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color:
                          (service.badge == 'Open' || service.badge == 'Fast')
                          ? primary.withValues(alpha: .08)
                          : Colors.orange.withValues(alpha: .08),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color:
                            (service.badge == 'Open' || service.badge == 'Fast')
                            ? primary.withValues(alpha: .2)
                            : Colors.orange.withValues(alpha: .2),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (service.badge == 'Open')
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: primary,
                              shape: BoxShape.circle,
                            ),
                          )
                        else if (service.badge == 'Fast')
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                            ),
                          )
                        else if (service.badge == 'Busy')
                          Icon(
                            Icons.warning,
                            size: 12,
                            color: Colors.orange[700],
                          )
                        else if (service.badge == 'Closed')
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                          ),
                        const SizedBox(width: 6),
                        Text(
                          service.badge,
                          style: TextStyle(
                            fontSize: 10,
                            color:
                                (service.badge == 'Open' ||
                                    service.badge == 'Fast')
                                ? primary
                                : (service.badge == 'Closed'
                                      ? Colors.red
                                      : Colors.orange),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: onExpand,
                    icon: Icon(
                      service.expanded ? Icons.expand_less : Icons.expand_more,
                      color: isDark
                          ? const Color(0xFFA4B89D)
                          : Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ],
          ),

          // expanded content
          if (service.expanded) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              decoration: BoxDecoration(
                color: isDark
                    ? const Color(0xFF131811).withValues(alpha: .6)
                    : const Color(0xFFF6F8F6),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isDark
                      ? const Color(0xFF41533C).withValues(alpha: .2)
                      : Colors.grey.shade100,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.2,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    service.description,
                    style: TextStyle(
                      color: isDark ? Colors.grey[300] : Colors.grey[700],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.schedule,
                                  size: 14,
                                  color: Colors.grey,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  'Hours',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Text(
                              service.hours,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: isDark ? Colors.white : Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.timelapse,
                                  size: 14,
                                  color: Colors.grey,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  'Avg. Service',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Text(
                              service.avgService,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: isDark ? Colors.white : Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: isDark
                          ? const Color(0xFF131811)
                          : Colors.grey[900],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isDark
                            ? const Color(0xFF41533C).withValues(alpha: .3)
                            : Colors.grey.shade200,
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: Column(
                              children: [
                                Text(
                                  'Current Wait',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: isDark
                                        ? const Color(0xFFA4B89D)
                                        : Colors.grey,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.hourglass_top,
                                      color: Color(0xFF49E619),
                                      size: 16,
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      service.waitTime,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: 1,
                          height: 48,
                          color: isDark
                              ? const Color(0xFF41533C).withValues(alpha: .3)
                              : Colors.grey.shade200,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: Column(
                              children: [
                                Text(
                                  'People in Line',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: isDark
                                        ? const Color(0xFFA4B89D)
                                        : Colors.grey,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.groups,
                                      color: Color(0xFF49E619),
                                      size: 16,
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      '${service.peopleInLine}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  JoinButton(
                    onPressed: onJoin,
                    highlighted:
                        service.badge == 'Open' || service.badge == 'Fast',
                    disabled: service.disabled,
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
