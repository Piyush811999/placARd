# Instructions 

## Building and Running the app 
Requires: Xcode 10 or later, iPhone 6s or better running iOS 12 or iOS 13 
Download the source codes 
Run ARInfo.xcodeproj
build and run on an iPhone 

## Summary of the application 
This app uses ARKit Object detection intorduced in ARKIt 2.0, After the object is detected it show the informatinon in form of spriteKit scene ( In my application it snows different information for all the different objects I have scanned ) which hovers above object above the object. 

## scanning objects
To detect the object we first need ARRefrenceObject ( it contains spatial feature information needed for ARKit to recognize the real-world object ) for that we will first need to download ARScanner ( [Download Link](https://developer.apple.com/documentation/arkit/scanning_and_detecting_3d_objects) ) source code for which is provided by apple. Use instructuions given above to build and run the application. 
Scan the object you would like to detect ( as shown in demo video )
save the results to a cloud drive ( also change it's name ). 

The file that is saved will be having a .arobject extension 

## Detecting Objects 
To detect object we must move these .arobject files to ARInfo Project, for open the ARInfo.xcodeproj (you will se name of all the files on the left section ) drag and drop the .artobjects in AR Resources sub folder.

To get results similar to the demo rename your .arobject file to one of these ( scanns which are currnetly present in app ) and replace the existing file. 
If the name of your .aronject scan is not one of the ["360","G305","M50X","SaltLamp"] than a 3D text with your .arobject file name will hover above your object. 








