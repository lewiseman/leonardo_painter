import 'package:flutter/material.dart';
import 'package:funvas/funvas.dart';
import 'package:leonardo_painter/SalvatorMundi/salvator_mundi.dart';

class Demons extends StatelessWidget {
  const Demons({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return CustomScrollView(
      slivers: [
        SliverAppBar.medium(
          title: const Text('Vitruvian Man'),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            childCount: fanvases.length,
            (context, index) {
              return Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(),
                  ),
                ),
                width: size.width,
                height: size.width,
                child: FunvasContainer(
                  funvas: fanvases[index],
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
