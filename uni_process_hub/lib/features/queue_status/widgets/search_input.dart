import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_process_hub/features/queue_status/controller/queue_controller.dart';

class SearchInput extends StatelessWidget {
  const SearchInput({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<QueueController>(context, listen: false);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Stack(
        children: [
          TextField(
            onChanged: controller.updateSearch,
            style: TextStyle(color: isDark ? Colors.white : Colors.black),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 48, vertical: 14),
              hintText: 'Search services, departments...',
              hintStyle: TextStyle(color: isDark ? const Color(0xFFA4B89D) : Colors.grey[400]),
              filled: true,
              fillColor: isDark ? const Color(0xFF1E261C) : const Color(0xFFF6F8F6),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: isDark ? const Color(0xFF41533C).withOpacity(.5) : Colors.grey.shade200),
                borderRadius: BorderRadius.circular(24),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: isDark ? const Color(0xFF41533C).withOpacity(.5) : Colors.grey.shade200),
                borderRadius: BorderRadius.circular(24),
              ),
            ),
          ),
          Positioned(
            left: 12,
            top: 10,
            child: Icon(
              Icons.search,
              size: 22,
              color: const Color(0xFFA4B89D),
            ),
          ),
        ],
      ),
    );
  }
}
