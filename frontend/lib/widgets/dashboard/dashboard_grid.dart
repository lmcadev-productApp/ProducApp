import 'package:flutter/material.dart';

class DashboardItem {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Color? iconColor;

  DashboardItem({
    required this.icon,
    required this.title,
    required this.onTap,
    this.iconColor,
  });
}

class DashboardGrid extends StatelessWidget {
  final List<DashboardItem> items;
  final double itemHeight;
  final double spacing;
  final Color backgroundColor;
  final Color cardColor;
  final Color textColor;
  final double iconSize;
  final double fontSize;
  final EdgeInsetsGeometry padding;

  const DashboardGrid({
    Key? key,
    required this.items,
    this.itemHeight = 120,
    this.spacing = 16,
    this.backgroundColor = Colors.transparent,
    this.cardColor = Colors.white,
    this.textColor = Colors.black87,
    this.iconSize = 48,
    this.fontSize = 16,
    this.padding = const EdgeInsets.all(16),
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      padding: padding,
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: spacing,
          mainAxisSpacing: spacing,
          childAspectRatio: 1.2,
        ),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return _DashboardCard(
            item: item,
            cardColor: cardColor,
            textColor: textColor,
            iconSize: iconSize,
            fontSize: fontSize,
          );
        },
      ),
    );
  }
}

class _DashboardCard extends StatelessWidget {
  final DashboardItem item;
  final Color cardColor;
  final Color textColor;
  final double iconSize;
  final double fontSize;

  const _DashboardCard({
    Key? key,
    required this.item,
    required this.cardColor,
    required this.textColor,
    required this.iconSize,
    required this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: cardColor,
      borderRadius: BorderRadius.circular(12),
      elevation: 2,
      shadowColor: Colors.black12,
      child: InkWell(
        onTap: item.onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black.withOpacity(0.3),
              width: 0.8,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                item.icon,
                size: iconSize,
                color: item.iconColor ?? const Color(0xFF4A90E2),
              ),
              const SizedBox(height: 12),
              Flexible(
                child: Text(
                  item.title,
                  style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: FontWeight.w600,
                    color: textColor,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
