import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/Features/GardenV2/Data/Models/plantdataentity_model.dart';

import '../../controller/plant_controller.dart';


import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget buildImageSlider(PlantDataEntity plantData,) {
  // return Obx(() {
  //   if (plantController.imageUrls.isEmpty) {
  //     return Center(child: Text("No images available"));
  //   }

    return CarouselSlider(
      options: CarouselOptions(
        height: 200.0,
        
        autoPlay: true,
        enlargeCenterPage: true,
      ),
      items: plantData.imageUrl.map((url) {
        return ClipRRect(
         // borderRadius: BorderRadius.circular(10),
          child: CachedNetworkImage(
            imageUrl: url,
            fit: BoxFit.cover,
            width: double.infinity,
            errorWidget: (context, url, error) => Container(
              width: double.infinity,
              height: 200,
              color: Colors.grey[300], // Grey background for missing images
              child: Center(
                child: Icon(Icons.image_not_supported, color: Colors.grey[600], size: 50),
              ),
            ),
          ),
        );
      }).toList(),
    );
 
}
