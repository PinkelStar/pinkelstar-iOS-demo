In the demo app folder you will find a complete and simple test application that uses the PinkelStar framework to build and display a like or share button. When such a button is pressed, the user can publish a download or custom message to Facebook and/or Twitter.

The demo app works (almost) out of the box. Open the test_ps_framework.xcodeproj in Xcode compile and run.
You will need to add your own Application Key and Secret to the AppDeveloper.plist file first (see below for instructions), otherwise the demo will halt immediately after launch.

Instructions for using the PinkelStar iPhone library

You have downloaded the zip file from the PinkelStar server and unpacked it. It contains:
a. A PinkelStar.framework
b. A Resources folder
c. An Include folder
d. A TestApp directory
e. This ReadMe.txt file


1. Add the PinkelStar Framework to your XCode project
- Locate your target in Xcode, press the right mouse button on it, and choose "Get Info"
- Choose the "General" tab in your info window
- Add a linked library by pressing the bottom + sign
- When the selection window appears, press the "choose other" button
- Locate your copy of the downloaded PinkelStar.framework and add it

2. Add resources
- Locate the Resources directory that was part of the PinkelStar zip file you downloaded
- Select all content in finder, and then drag it into your Xcode project, onto the Resources folder.

3. Add the Include folder
- Select the Include directory that was part of the PinkelStar zip file and drag that into your Xcode project

4. Enter your application key and secret
- You have to register your iPhone app at your administration panel on www.pinkelstar.com
- If you have registered your app successfully you should now have an Application Key and Secret
- Locate the ApplicationDeveloper.plist file in your Xcode project. It should be in your Resources folder, as you just dragged it there
- Open ApplicationDeveloper.plist and enter your Application Key and Secret there
- Save the ApplicationDeveloper.plist file

5. You are now all set to add a PinkelStar share or like button anywhere in your project.
- Open the TestApp Xcode project, and look at the code there.  You need to take 5 steps to get PinkelStar working
a. add the PSShareButtonDelegate and PSMainViewControllerDelegate protocol in your ViewController
b. import <PinkelStar/PinkelStar.h> where needed
c. Create a PSShareButton anywhere
d. Implement the psShareButtonPressed delegate callback and there, create a PSMainViewController object. Add it to your view.
e. Implement the psFinished Delegate callback. This will be called when the PinkelStar process is finished or cancelled.