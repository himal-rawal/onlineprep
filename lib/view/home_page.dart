import 'package:flutter/material.dart';
import 'package:onlineprep/modal/question_categories.dart';
import 'package:onlineprep/view/quiz_rules_page.dart';
import 'package:provider/provider.dart';

import '../res/widgets/homepage_widgets/sliver_appbar_widget.dart';
import '../viewmodel/question_categories_viewmodel.dart';

class HomepPage extends StatelessWidget {
  const HomepPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // Check Whether the data is already fetched or not
        body: context.read<QuestionCategoriesViewModeel>().allCategories.isEmpty
            ? _fetchAllCategoriesFromApi(context)
            : _customScrollView(context,
                context.read<QuestionCategoriesViewModeel>().allCategories));
  }
}

/// Fetch New Category Data
FutureBuilder<List<Categories>> _fetchAllCategoriesFromApi(
    BuildContext context) {
  return FutureBuilder(
      future: context.read<QuestionCategoriesViewModeel>().getAllCategories(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        } else if (snapshot.hasData) {
          final categoryData = snapshot.data;
          if (categoryData == null) {
            return const Text("No data received");
          } else if (categoryData.isEmpty) {
            return const Text("Sorry No categories Found");
          } else {
            return _customScrollView(context, categoryData);
          }
        }
        return const Center(child: CircularProgressIndicator());
      });
}

CustomScrollView _customScrollView(
    BuildContext context, List<Categories> categoryData) {
  return CustomScrollView(
    slivers: [
      const HomePageSliverAppBarWidget(),
      _textWidgetToDisplayHeading(),
      _sliverGridviewBuilderForCategory(categoryData)
    ],
  );
}

SliverToBoxAdapter _textWidgetToDisplayHeading() {
  return const SliverToBoxAdapter(
    child: Padding(
      padding: EdgeInsets.only(top: 10.0, left: 15, right: 15, bottom: 20),
      child: Text(
        "Categories",
        style: TextStyle(
            color: Color(0xff03dac6),
            fontSize: 20,
            fontWeight: FontWeight.bold),
      ),
    ),
  );
}

SliverPadding _sliverGridviewBuilderForCategory(List<Categories> categoryData) {
  return SliverPadding(
    padding: const EdgeInsets.all(10),
    sliver: SliverGrid.builder(
      itemCount: categoryData.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, crossAxisSpacing: 3, mainAxisSpacing: 3),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => _navigateToQuizRulesPage(context, categoryData, index),
          child: _categoryContainer(categoryData, index),
        );
      },
    ),
  );
}

Container _categoryContainer(List<Categories> categoryData, int index) {
  return Container(
    padding: const EdgeInsets.all(8),
    height: 20,
    width: 20,
    decoration: _boxDecorationForCategoryContainer(categoryData, index),
    child: _titleOfCategory(categoryData, index),
  );
}

Align _titleOfCategory(List<Categories> categoryData, int index) {
  return Align(
      alignment: Alignment.bottomCenter,
      child: Text(
        categoryData[index].title ?? '',
        style: const TextStyle(color: Color.fromARGB(255, 3, 237, 213)),
      ));
}

BoxDecoration _boxDecorationForCategoryContainer(
    List<Categories> categoryData, int index) {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(
      15,
    ),
    image: DecorationImage(
        image: NetworkImage(categoryData[index].photo ?? ""),
        fit: BoxFit.cover,
        opacity: 0.5),
    border: Border.all(color: Colors.grey),
  );
}

void _navigateToQuizRulesPage(
    BuildContext context, List<Categories> categoryData, int index) {
  Navigator.of(context).push(MaterialPageRoute(
      builder: ((context) => QuizRulesPage(
            categoryId: categoryData[index].id,
            categoryName: categoryData[index].title,
          ))));
}

// CustomScrollView(
//               slivers: [
//                 SliverAppBar(
//                   floating: true,
//                   flexibleSpace: SizedBox(),
//                   expandedHeight: 80,
//                   collapsedHeight: 60,
//                   title: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         "Hello Himal ,",
//                         style: TextStyle(color: Color(0xff03dac6)),
//                       ),
//                       Text(
//                         "Welcome to Quiz App",
//                         style: TextStyle(fontSize: 15),
//                       )
//                     ],
//                   ),
//                   actions: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         SizedBox(width: 20),
//                         GestureDetector(
//                           onTap: () {
//                             context.read<AuthViewModel>().logOut();
//                           },
//                           child: CircleAvatar(
//                             backgroundImage: NetworkImage(
//                                 'https://media.sproutsocial.com/uploads/2022/06/profile-picture.jpeg'),
//                             radius: 30,
//                           ),
//                         ),
//                         SizedBox(width: 20),
//                       ],
//                     )
//                   ],
//                 ),
//                 SliverToBoxAdapter(
//                   child: Padding(
//                     padding: const EdgeInsets.only(
//                         top: 10.0, left: 15, right: 15, bottom: 20),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               "Categories",
//                               style: TextStyle(
//                                   color: Color(0xff03dac6),
//                                   fontSize: 20,
//                                   fontWeight: FontWeight.bold),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 SliverPadding(
//                   padding: EdgeInsets.all(10),
//                   sliver: SliverGrid.builder(
//                     itemCount: context
//                         .read<QuestionCategoriesViewModeel>()
//                         .allCategories
//                         .length,
//                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 2,
//                         crossAxisSpacing: 3,
//                         mainAxisSpacing: 3),
//                     itemBuilder: (context, index) {
//                       return GestureDetector(
//                         onTap: () {
//                           Navigator.of(context).push(MaterialPageRoute(
//                               builder: ((context) => QuizRulesPage())));
//                         },
//                         child: Container(
//                           padding: EdgeInsets.all(8),
//                           //width: 20,
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(
//                                 15,
//                               ),
//                               image: DecorationImage(
//                                   image: NetworkImage(context
//                                           .read<QuestionCategoriesViewModeel>()
//                                           .allCategories[index]
//                                           .photo ??
//                                       ""),
//                                   fit: BoxFit.cover,
//                                   opacity: 0.3),
//                               border: Border.all(color: Color(0xff03dac6))),
//                           child: Align(
//                             alignment: Alignment.bottomCenter,
//                             child: Text(
//                                 context
//                                         .read<QuestionCategoriesViewModeel>()
//                                         .allCategories[index]
//                                         .title ??
//                                     '',
//                                 style: TextStyle(color: Color(0xff03dac6))),
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 )
//               ],
//             ),