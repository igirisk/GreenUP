import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../models/tree.dart';
import '../services/tree_Service.dart';

class TreeListSeparated extends StatelessWidget {
  TreeService fsService = TreeService();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Tree>>(
        stream: fsService.getFilteredTrees(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Error loading data'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No data available'),
            );
          } else {
            return ListView.separated(
              itemBuilder: (ctx, i) {
                return SizedBox(
                  width: 3, // Adjust the width as needed
                  height: 3, // Adjust the height as needed
                  child: Image.asset('images/witheredTree.png'),
                );
              },
              separatorBuilder: (ctx, i) {
                return const Divider(
                  height: 5,
                  color: Colors.transparent,
                );
              },
              itemCount: snapshot.data!.length,
            );
          }
        });
  }
}
