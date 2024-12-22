import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
class FacebookPost extends StatelessWidget {
  final String userName;
  final String postText;
  final String imageUrl;

  const FacebookPost({
    required this.userName,
    required this.postText,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top:MediaQuery.of(context).size.width * 0.051,
        left:MediaQuery.of(context).size.width * 0.01,
        right:MediaQuery.of(context).size.width * 0.01,
        bottom:MediaQuery.of(context).size.width * 0.051,),
      child:Stack(
      alignment: AlignmentDirectional.bottomEnd,
      children: [
        Container(
          width: double.infinity,
          child:
        
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: 
            CachedNetworkImage(
              imageUrl: imageUrl,
              errorWidget: (context, url, error) => SizedBox(
                height: 3,
              ),
              fit: BoxFit.cover, // Or any other BoxFit mode you prefer
            ),
        ),
        ),
        Container(
          width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15.0),
                bottomRight: Radius.circular(15.0),
                ),
              color: Colors.black.withOpacity(0.6),
            ),
            padding: EdgeInsets.only(
              top:MediaQuery.of(context).size.width * 0.05,
              right:MediaQuery.of(context).size.width * 0.025,
              left:MediaQuery.of(context).size.width * 0.025,
              bottom:MediaQuery.of(context).size.width * 0.05,
            ),  
            
            child:
                Text(
                    postText,
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.045,
                      fontFamily: 'RaleWay',
                      fontWeight: FontWeight.w500
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    
                    textAlign: TextAlign.center,
                ),
                
              
            
          ),
        
      ],
    )
    );
  }
}
