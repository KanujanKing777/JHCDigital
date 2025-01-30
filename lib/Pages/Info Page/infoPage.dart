import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text(
          'About Us',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF001020), // Dark blue-black gradient
              Color(0xFF000720), // Dark blue-black gradient
              Color(0xFF000300), // Dark blue-black gradient
              Color(0xFF000000), // Pure black
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Row(
                children: [
                  Center(
                    child: Image(
                      image: AssetImage("images/logo.png"),
                      height: 50,
                      width: 50,
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.015),
                  Text(
                    'JHC Digital',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              Divider(
                color: Colors.white.withOpacity(0.5),
                thickness: 1,
              ),
              SizedBox(height: 10),
              _buildInfoText(
                'JHC Sports is a Mobile Application developed by the IT Club of Jaffna Hindu College.',
              ),
              SizedBox(height: 15),
              _buildInfoText(
                'It is developed with the purpose of digitalizing sports events and the sports community.',
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Icon(Icons.developer_mode, color: Colors.white),
                  SizedBox(width: 10),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white.withOpacity(0.9),
                          height: 1.5,
                        ),
                        children: [
                          TextSpan(text: 'Developers: '),
                          TextSpan(
                            text: 'Kanujan',
                            style: TextStyle(
                              color: Colors.cyanAccent,
                              // shadows: [
                              //   Shadow(
                              //     color: Colors.cyanAccent,
                              //     blurRadius: 5.0,
                              //   ),
                              // ],
                            ),
                          ),
                          TextSpan(text: ', '),
                          TextSpan(
                            text: 'Karthikan',
                            style: TextStyle(
                              color: Colors.orangeAccent,
                              // shadows: [
                              //   Shadow(
                              //     color: Colors.orangeAccent,
                              //     blurRadius: 5.0,
                              //   ),
                              // ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Icon(Icons.mail, color: Colors.white),
                  SizedBox(width: 10),
                  Expanded(
                    child: _buildInfoText(
                      'Contact us: info@jhcit.com',
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Icon(Icons.copyright, color: Colors.white),
                  SizedBox(width: 10),
                  Expanded(
                    child: _buildInfoText(
                      'JHC IT Society',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoText(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 18,
        color: Colors.white.withOpacity(0.9),
        height: 1.5,
      ),
      textAlign: TextAlign.justify,
    );
  }
}
