import 'package:flutter/material.dart';

class GivenExams extends StatelessWidget {
  const GivenExams({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.separated(
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  tileColor: const Color(0xFF494949),
                  leading: const CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://www.cedars-sinai.org/content/dam/cedars-sinai/blog/2020/06/viruses-bacteria-fungi.jpg')),
                  title: const Text("Biology"),
                  subtitle: const Text("22/09/2019 at 02:20 PM"),
                  trailing: CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.red.shade300,
                    child: const Text(
                      "40",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(),
            itemCount: 10));
  }
}
