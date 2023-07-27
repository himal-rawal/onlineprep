import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../view/login_page.dart';
import '../../../viewmodel/auth_viewmodel.dart';
import '../../../viewmodel/user_data_viewmodel.dart';
import '../../constants.dart';

class HomePageSliverAppBarWidget extends StatelessWidget {
  const HomePageSliverAppBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      flexibleSpace: const SizedBox(),
      expandedHeight: 80,
      collapsedHeight: 60,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [_greetingNameText(context), _welcomeText()],
      ),
      actions: [
        const SizedBox(width: 20),
        _profilePagePopUpMenuButon(context),
        const SizedBox(width: 20)
      ],
    );
  }

  Text _welcomeText() {
    return const Text(
      "Welcome to Quiz App",
      style: TextStyle(fontSize: 15),
    );
  }

  Text _greetingNameText(BuildContext context) {
    return Text(
      "Hello ${context.watch<UserDataViewModel>().name} ,",
      style: const TextStyle(color: Color(0xff03dac6)),
    );
  }

  PopupMenuButton<SampleItem> _profilePagePopUpMenuButon(BuildContext context) {
    return PopupMenuButton(
      onSelected: (SampleItem item) {
        if (item == SampleItem.profile) {
        } else if (item == SampleItem.logOut) {
          context.read<UserDataViewModel>().clearDetails();
          context.read<AuthViewModel>().logOut();
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const LoginPage()));
        }
      },
      offset: const Offset(20.0, 52),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
        Radius.circular(20.0),
      )),
      itemBuilder: (context) => <PopupMenuEntry<SampleItem>>[
        _profilePopUpMenuItem(),
        _logoutMenuItem(),
      ],
      child: const CircleAvatar(
        backgroundImage: NetworkImage(
            'https://media.sproutsocial.com/uploads/2022/06/profile-picture.jpeg'),
        radius: 30,
      ),
    );
  }

  PopupMenuItem<SampleItem> _profilePopUpMenuItem() {
    return PopupMenuItem<SampleItem>(
      value: SampleItem.profile,
      child: Row(
        children: const [
          Text('Profile'),
          SizedBox(width: 8),
          Icon(Icons.person_3)
        ],
      ),
    );
  }

  PopupMenuItem<SampleItem> _logoutMenuItem() {
    return PopupMenuItem<SampleItem>(
      value: SampleItem.logOut,
      child: Row(
        children: const [
          Text('Logout'),
          SizedBox(width: 8),
          Icon(Icons.logout)
        ],
      ),
    );
  }
}
