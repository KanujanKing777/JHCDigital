import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:jhc_app/Pages/ScorePage/liveCricket.dart';

class ImageDownloadPage extends StatefulWidget {
  final String team;

  ImageDownloadPage({required this.team});

  @override
  _ImageDownloadPageState createState() => _ImageDownloadPageState();
}

class _ImageDownloadPageState extends State<ImageDownloadPage> {
  String imageURL = "";

  @override
  void initState() {
    super.initState();
  }

//   Future<void> downloadImage() async {
//     try {
//       // Points to the root reference
//     // Create a storage reference from our app
// final storageRef = FirebaseStorage.instance.ref();

// // Create a reference with an initial file path and name
// final pathReference = storageRef.child("images/stars.jpg");

// // Create a reference to a file from a Google Cloud Storage URI
// final gsReference =
//     FirebaseStorage.instance.refFromURL("gs://YOUR_BUCKET/images/stars.jpg");

// // Create a reference from an HTTPS URL

// // Note that in the URL, characters are URL escaped!
// final downloadURL = 
// "https://firebasestorage.googleapis.com/v0/b/latestjhcapp.appspot.com/o/jhc.png?alt=media&token=ce4540db-9606-4816-aaaf-61151f6d59e3";  
//     setState(() {
//         imageURL = downloadURL;
//       });

//       // You can use this URL with the Image.network widget or any other image loading widget.
//     } catch (error) {
//       setState(() {});
//     }
//   }
Future<List<String>> getImageUrls() async {
  try {
    final storageRef = FirebaseStorage.instance.ref();
    final listResult = await storageRef.child('images').listAll();

    final imageUrls = await Future.wait(listResult.items.map((ref) async {
      final downloadURL = await ref.getDownloadURL();
      return downloadURL;
    }));

    return imageUrls;
  } catch (e) {
    print('Error retrieving image URLs: $e');
    return [];
  }
}
 
  Widget fun() {
    
    if(widget.team == 'jhc' || widget.team == 'JHC'){
      return Image.asset(
        'assets/images/jhc.png',
        width: 100,
        height: 100,
      );
    }
    else{
      return Icon(Icons.school, size: 100,);
    }
    
  }

  @override
  Widget build(BuildContext context) {
   
    return fun();
        
  }
}
