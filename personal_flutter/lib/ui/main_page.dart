import 'package:flutter/material.dart';
import 'package:personal_flutter/ui/draft_page.dart';
import 'package:personal_flutter/ui/home_page.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:personal_flutter/ui/meals/meal_main_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String appVersion = "";

  @override
  void initState() {
    super.initState();
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      setState(() {
        appVersion = 'v${packageInfo.version}+${packageInfo.buildNumber}';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("MY flutter DEMO personal")),
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Select next page"),
              OutlinedButton(
                child: Text("Draft"),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DraftPage(
                      title: 'draft example page',
                      onPressed: () => debugPrint('pressed'),
                    ),
                  ),
                ),
              ),
              OutlinedButton(
                child: Text("Home page FETCH API BLOC"),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const HomePage()),
                ),
              ),
              OutlinedButton(
                child: Text("Meal Page API fetch bloc"),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const MealMainPage()),
                ),
              ),
              const Spacer(),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text("app version: $appVersion"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
