<h1 align="center">
  <a href="http://www.reflectcode.com">
    ReflectCode
  </a>
</h1>
<p align="center">
  <strong>Automated Source Code Transformation service</strong><br>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Platform-Android%20%7C%20iOS-green" alt="Platform - Android | iOS" />
  <a href="https://twitter.com/intent/follow?screen_name=reflectcode">
    <img src="https://img.shields.io/twitter/follow/reflectcode.svg?label=Follow%20@reflectcode" alt="Follow @reflectcode" />
  </a>
  
</p>


-----
# ReflectCode Glide Demo
**Glide** an image loading / caching library for Android focused on smooth scrolling https://bumptech.github.io/glide/
With more than 27k stars, Glide is one of the most widely used 3rd party library for Android. 

ReflectCode supports the similar functionality on iOS by using **AlamofireImage** library https://github.com/Alamofire/AlamofireImage
AlamofireImage provides all features offered by Glide, however the usage is very different.
To bridge the gap a wrapper class "RC_Glide.swift" is used to support all the APIs defined in Glide.

With this demo project RC also added support for **CocoaPods**. 
The Podfile is generated based on the 3rd party library required in target project. 


## Glide features supported
* Load drawable from local res folder
* Load image from a URL 
* Load image into UIImageView 
* Provide placeholder image while download is in progress
* Apply transition between images : CrossFade, Flip
* Image Transformation : circleCrop(), centerCrop(), fitCenter(), centerInside()
* Clear pending request
* RequestOptions class to reuse the settings between instances

## Pending features 
* priority()
* diskCacheStrategy()
* asBitmap()
* error()
* fallback()
* clearMemory()
Note - Dummy methods are added for these less frequently used features. 


## Statement Estimation
| Source File | iOS File | Statement |
|---------|------------|------------|
| MainActivity.java | MainViewController.swift | 131 |
| activity_main.xml | mainView.storyboard | 603 |
| Drawables | Asset Catalog | 90 |
| Color.xml | Asset Catalog | 30 |
| MipMap | App Icon | 50 |
| Project (app.iml) | project.pbxproj | 752 |
| AndroidManifest.xml | Info.plist | 68 |
| build.gradle | Podfile | 20 | 
| **Total** | **2496** |


## Dev Notes
* This project uses 'AlamofireImage V3.5' to load images 

-----

## Screen shots

<img src="/Visuals/ReflectCode-GlideDemo.gif" alt="ReflectCode Glide Demo GIF"/>

-----

## License

This project is made available under the MIT license. See the LICENSE file for more details.
