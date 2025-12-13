import 'package:flutter/material.dart';

class FilterChips extends StatefulWidget {
  const FilterChips({super.key});

  @override
  State<FilterChips> createState() => _FilterChipsState();
}

class _FilterChipsState extends State<FilterChips> {
  int selectedIndex = 0;

  final filters = const [
    ('All', Icons.apps),
    ('To Fill', Icons.edit_document),
    ('History', Icons.history),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SizedBox(
      height: 48,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final selected = index == selectedIndex;

          return GestureDetector(
            onTap: () => setState(() => selectedIndex = index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: selected
                    ? (isDark ? Colors.white : Colors.black)
                    : (isDark ? const Color(0xFF1C2B18) : Colors.white),
                borderRadius: BorderRadius.circular(999),
                border: Border.all(
                  color: selected
                      ? Colors.transparent
                      : (isDark
                          ? const Color(0xFF2C3829)
                          : Colors.grey.shade200),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    filters[index].$2,
                    size: 18,
                    color: selected
                        ? (isDark ? Colors.black : Colors.white)
                        : Colors.grey,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    filters[index].$1,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: selected
                          ? (isDark ? Colors.black : Colors.white)
                          : (isDark ? Colors.white : Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
