import 'package:flutter/material.dart';
import 'package:jhc_app/widgets/youtubeplayer.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class Interior extends StatefulWidget {
  String urls = "";
  List<String>? imglist = [""];
  String images = "";
  String txts = "";
  String? description = "";
  String? first = "";
  String? second = "";
  String? third = "";
  String? fourth = "";
  String? fifth = "";
  String utube = "";
  Interior({required this.urls,
      required this.images,
      required this.txts,
      required this.utube,
      this.description,
      this.fifth,
      this.first,
      this.fourth,
      this.second,
      this.third,
      this.imglist});

  @override
  // ignore: library_private_types_in_public_api, no_logic_in_create_state
  _Interior createState() =>  _Interior(urls: urls,
      images: images,
      txts: txts,
      description: description ?? "",
      first: first ?? "",
      second: second ?? "",
      third: third ?? "",
      fourth: fourth ?? "",
      fifth: fifth ?? "",
      imglist: imglist ?? [""],
      utube: utube);
}

class _Interior extends State<Interior> {
   String urls = "";
  String images = "";
  String txts = "";
  List<String> imglist = [""];

  String description = "";
  String first = "";
  String second = "";
  String third = "";
  String fourth = "";
  String fifth = "";
  String utube = "";
    _Interior( {required this.urls,
      required this.images,
      required this.txts,
      required this.description,
      required this.fifth,
      required this.first,
      required this.fourth,
      required this.second,
      required this.third,
      required this.imglist,
      required this.utube});

   bool isNumeric(String str) {
    if (str.startsWith("Rs")) {
      return true;
    } else {
      return false;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 66,
        backgroundColor: Colors.black,
        title: Text(
          txts.split(',')[0],
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
  padding: const EdgeInsets.all(16.0),
  child: Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color:  Colors.black, // Box background color
      borderRadius: BorderRadius.circular(10), // Rounded corners
      boxShadow: [
        BoxShadow(
          color: const Color.fromARGB(255, 69, 68, 68).withOpacity(0.2), // Shadow color
          blurRadius: 6, // Spread of the shadow
          offset: Offset(0, 5), // Offset for the shadow
        ),
      ],
    ),
    child: Text(
      txts.split(',')[1],
      textAlign: TextAlign.justify,
      style: TextStyle(
        fontSize: MediaQuery.of(context).size.width * 0.045,
        color: Colors.white,
      ),
    ),
  ),
),


            // Image Grid
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                ),
                itemCount: imglist.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      // Handle image tap
                    },
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child:ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: Image.network(
                        imglist[index],
                        fit: BoxFit.cover,
                      ),
                    )),
                  );
                },
              ),
            ),

            // YouTube Video Section
            if (!isNumeric(urls))
  Padding(
    padding: const EdgeInsets.all(16.0),

    child:GestureDetector(
    onTap: () async {
      // Navigate to a new page for full-screen video playback
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FullScreenVideoPlayer(videoId: utube),
        ),
      );
    },
    child: Container(
      height: MediaQuery.of(context).size.height * 0.3,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
              'https://img.youtube.com/vi/$utube/maxresdefault.jpg'), // Thumbnail URL
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
    ),
  ),),

            // Link Button
            if (!isNumeric(urls))
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton.icon(
                  onPressed: () async {
                    final Uri uri = Uri.parse(urls);
                    if (!await launchUrl(uri)) {
                      throw Exception('Could not launch $urls');
                    }
                  },
                  icon: const Icon(Icons.link, color: Colors.white),
                  label: const Text(
                    "Visit",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                  ),
                ),
              ),

            const SizedBox(height: 50),
          ],
        ),
      ),
      backgroundColor: Colors.grey[900], // Background color for contrast
    );
  }
}
