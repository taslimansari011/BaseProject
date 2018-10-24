# BasicAPP

This application is designed to include basic structure of any iOS application. It has swiftlint setup, fabric setup, and two schemes added one for QA and other for Live.


## Getting Started

1. [Download](https://developer.apple.com/xcode/download/) the Xcode 9.4 release.
2. Clone [this] repository.
3. Build the project in xcode.


## Branches

* master - It consists of all code

## Project schemes

* BasicApp-Dev  ->For Development
* BasicApp-QA  -> For Testing
* BasicApp  -> For Production


## Dependencies

These are the following libraries -


### 3rd party

- 'Alamofire' - is used to handle APIs request
- 'IQKeyboardManagerSwift' (https://github.com/hackiftekhar/IQKeyboardManager) - allows you to prevent issues of the keyboard sliding up and cover UITextField/UITextView
- 'Fabric' - is used for reporting crash
- 'Crashlytics'
- 'MBProgressHUD' - 
- 'SDWebImage' - is used for image caching
- 'SwiftyJSON'
- 'FLEX' - [ https://github.com/Flipboard/FLEX ]


## OS Version

It supports iOS 9 and above.



## Set Your App Name

- Select your project  and change project name from the Attribute Inspector under Identity and type. A pop up will come with rename project content items. Select Rename and continue.
- Open pod file change the target name with your target name
- Delete .xcworkspace, Podfile.lock and Pods folder, and run pod install
- Rename your Project folder name, now when you will open your project you have to readd your project folder.
- Now change the path of info.plist file under build setting, you will have to change project folder name.
- Now when you run your project you will get 1 warning and one error. 
- To remove the warning select info.plist file untick target MemberShip from right sidemenu. 
- To remove the error select your project->General, see under Linked frameworks and Libraries, a pod framework  Pods_BasicApp.framework is added, remove that. Now run your project.
- Just one more step to get everything done :). Now Select Scheme -> Manage Scheme, rename all the three schemes. Now you are done with the project setup.


## Set Bundle Identifier

-  Select Project -> Targets -> Build Settings -> Product Bundle Identifier, replace with yours for all the three schemes


## Setup fabric for your project
- Your new project already have pre installed Crashlytics and Answers Kit ([fabric](https://www.fabric.io/settings/organizations/5b960a2b5cd0e362f6000a5d/apps)).
- If you need setup your project with different fabric account then you need to Replace `Fabric_API_key` and `Fabric_Secret_key` from yours in Build settings under User-Defined section.
- To get new API key and build secret for your project, visit [fabric](https://www.fabric.io/settings/organizations)


## Setup your project on Jenkins
 
- Do All the steps following the below Link 
 https://medium.com/finoit/continuous-integration-using-jenkins-and-appbox-for-ios-d1c10ebd3d72
- Plist files required are already added in the project. You have to edit the info.


