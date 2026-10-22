import 'package:flutter/material.dart';
import 'package:personal_flutter/ui/draft_page.dart';
import 'package:personal_flutter/ui/home_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({
    super.key,
    this.title = 'Personal flutter APP',
    this.onPressed,
  });

  final String title;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Align(
          alignment: Alignment.topLeft,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Select next page"),
              OutlinedButton(
                child: Text("Draft"),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        const DraftPage(title: 'draft example page'),
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
            ],
          ),
        ),
      ),
    );
  }
}
