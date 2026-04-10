import 'package:flutter/material.dart';

import 'package:nexus/features/home/presentation/widgets/grid_tile.dart';

class NavGrid extends StatelessWidget {
  const NavGrid({required this.tiles, super.key});

  final List<GridTileData> tiles;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: tiles.length,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 1.15,
      ),
      itemBuilder: (BuildContext context, int index) {
        return NexusGridTile(data: tiles[index]);
      },
    );
  }
}
