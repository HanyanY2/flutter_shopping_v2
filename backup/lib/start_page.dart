import 'package:flutter/material.dart';
import 'home_page.dart';

class StartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  bool _showAd = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          HomePage(), // 背景是主页面

          if (_showAd)
            Dismissible(
              key: UniqueKey(),
              direction: DismissDirection.up,
              onDismissed: (_) {
                setState(() {
                  _showAd = false;
                });
              },
              child: Container(
                color: Colors.black, // 黑色背景
                width: double.infinity,
                height: double.infinity,
                child: Column(
                  children: [
                    Spacer(),

                    // 👟 图片居中完整显示
                    Center(
                      child: Image.asset(
                        'assets/ad_banner.png',
                        fit: BoxFit.contain,
                        width: MediaQuery.of(context).size.width * 0.9, // 不要太宽
                      ),
                    ),

                    Spacer(),

                    // 文字内容
                    Text(
                      "LIVE YOUR\nPERFECT",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 28,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Smart, gorgeous & fashionable\ncollection makes you cool",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 20),
                    Icon(Icons.keyboard_arrow_up, color: Colors.white, size: 28),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _showAd = false;
                        });
                      },
                      child: Text(
                        "Get Started",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                    SizedBox(height: 30),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
