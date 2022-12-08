import 'package:auto_spare_part/view_model/category_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    Provider.of<CategoryViewModel>(context, listen: false).listenCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Consumer<CategoryViewModel>(
        builder: ((context, categoryViewModel, child) {
          return Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: categoryViewModel.categories.length,
                itemBuilder: (context, index) {
                  return Container(
                    width: 100,
                    height: 100,
                    color: Colors.amber,
                  );
                },
              ),
            ],
          );
        }),
      ),
    );
  }
}
