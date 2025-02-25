import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wonderfood/provider/theme_provider.dart';
import 'package:wonderfood/style/colors/wonderfood_colors.dart';

class SkeletonLoading extends StatefulWidget {
  final int count;

  const SkeletonLoading({super.key, required this.count});

  @override
  State<SkeletonLoading> createState() => _SkeletonLoadingState();
}

class _SkeletonLoadingState extends State<SkeletonLoading> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.count,
      itemBuilder: (context, index) {
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: context.watch<ThemeProvider>().isDarkMode
                  ? WonderfoodColors.lightBlue.color
                  : WonderfoodColors.white.color),
          margin: const EdgeInsets.only(bottom: 9),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 15,
            ),
            child: Shimmer.fromColors(
              baseColor: Colors.grey[400]!,
              highlightColor: Colors.grey[200]!,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxHeight: 76,
                      minHeight: 76,
                      maxWidth: 114,
                      minWidth: 114,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox.square(dimension: 9),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 16,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox.square(dimension: 10),
                        Container(
                          width: double.infinity,
                          height: 10,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox.square(dimension: 5),
                        Container(
                          width: double.infinity,
                          height: 10,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox.square(dimension: 5),
                        Container(
                          width: double.infinity,
                          height: 10,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
