import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';
import 'package:playground/colors.dart';
import 'package:playground/ui/authentication/profile/profile.dart';
import 'package:playground/ui/deck_collection/deck_collection_page.dart';
import 'package:playground/ui/friends/friends_page.dart';
import 'package:playground/ui/life_track/life_track_page.dart';
import 'package:playground/ui/search/search_page.dart';
import 'package:playground/ui/sets_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Expanded(
              child: Text(
                'Magic Archive',
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        actions: const [
          SizedBox(
            height: 40,
            width: 40,
          )
        ],
        leading: Container(
          height: 20,
          width: 20,
          margin: const EdgeInsets.all(8),
          child: IconButton(
            onPressed: () async {
              try {
                await GoogleSignIn().signOut();
                await FirebaseAuth.instance.signOut();
              } on Exception catch (e) {
                Logger().e(e.toString());
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Sign out failed. Try again later')));
              }
            },
            iconSize: 20,
            padding: const EdgeInsets.all(0),
            icon: Image.asset('assets/images/logout_icon.png'),
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          color: CustomColors.eggshell,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  margin: const EdgeInsets.all(16),
                  child: Image.asset('assets/images/archive.png')),
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            height: 75,
                            margin: const EdgeInsets.fromLTRB(16, 16, 2, 4),
                            child: TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: CustomColors.blackOlive,
                                padding: const EdgeInsets.all(12),
                              ),
                              onPressed: () async {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      // builder: (context) => const InfoPage()),
                                      builder: (context) =>
                                          const ProfilePage()),
                                );
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    margin:
                                        const EdgeInsets.fromLTRB(0, 0, 20, 0),
                                    child: const Text(
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: CustomColors.orange),
                                        'Your profile'),
                                  ),
                                  CircleAvatar(
                                    radius: 20,
                                    child: FirebaseAuth.instance.currentUser
                                                ?.photoURL !=
                                            null
                                        ? CircleAvatar(
                                            backgroundColor: Colors.transparent,
                                            backgroundImage: NetworkImage(
                                                FirebaseAuth.instance
                                                    .currentUser!.photoURL!),
                                          )
                                        : Image.asset(
                                            'assets/images/profile.png'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: 75,
                            margin: const EdgeInsets.fromLTRB(2, 16, 16, 4),
                            child: TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: CustomColors.blackOlive,
                                padding: const EdgeInsets.all(12),
                              ),
                              onPressed: () async {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const FriendsPage(),
                                  ),
                                );
                              },
                              child: Image.asset('assets/images/friends.png'),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Container(
                          height: 75,
                          margin: const EdgeInsets.fromLTRB(16, 0, 16, 4),
                          child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: CustomColors.blackOlive,
                              padding: const EdgeInsets.all(12),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const LifeTrackPage()),
                              ).then((value) =>
                                  SystemChrome.setEnabledSystemUIMode(
                                      SystemUiMode.manual,
                                      overlays: SystemUiOverlay.values));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  margin:
                                      const EdgeInsets.fromLTRB(0, 0, 20, 0),
                                  child: const Text(
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: CustomColors.orange),
                                      'Track your HP'),
                                ),
                                Image.asset('assets/images/scores.png'),
                              ],
                            ),
                          ),
                        )),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Container(
                            height: 100,
                            margin: const EdgeInsets.fromLTRB(16, 0, 2, 4),
                            child: TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor: CustomColors.blackOlive,
                                  padding: const EdgeInsets.all(12),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SetsPage()),
                                  );
                                },
                                child: const Text(
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: CustomColors.orange),
                                    'Browse MTG sets')),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 100,
                            margin: const EdgeInsets.fromLTRB(2, 0, 16, 4),
                            child: TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor: CustomColors.blackOlive,
                                  padding: const EdgeInsets.all(12),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SearchPage()),
                                  );
                                },
                                child: const Text(
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: CustomColors.orange),
                                    'Search for cards')),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Container(
                          height: 75,
                          margin: const EdgeInsets.fromLTRB(16, 0, 16, 4),
                          child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: CustomColors.blackOlive,
                              padding: const EdgeInsets.all(12),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const DecksCollectionPage()),
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  margin:
                                      const EdgeInsets.fromLTRB(0, 0, 20, 0),
                                  child: const Text(
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: CustomColors.orange),
                                      'Your decks'),
                                ),
                                Image.asset('assets/images/storage.png'),
                              ],
                            ),
                          ),
                        )),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
