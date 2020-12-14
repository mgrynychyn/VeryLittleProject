//
//  MyFile.swift
//  LittleProject
//
//  Created by Maria Grynychyn on 10/4/20.
//

import Foundation
import React
//import FlipperKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, RCTBridgeDelegate{
    
  var window: UIWindow?
  
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    // Override point for customization after application launch.
    let bridge:RCTBridge = RCTBridge.init(delegate: self, launchOptions: launchOptions)
    let _ = Experimental()
    
 //   let props = ["test" : "Native"]
    let props = propsInit();
    let rootView = RCTRootView(bridge: bridge, moduleName: "LittleProject", initialProperties: props as? [AnyHashable : Any])
    rootView.backgroundColor =  UIColor(displayP3Red: 1.0, green: 1.0, blue: 1.0, alpha: 1)
    let vc = UIViewController()
    vc.view = rootView
    
    self.window = UIWindow.init(frame: UIScreen.main.bounds)
    //      self.present(vc, animated: true, completion: nil)
    self.window?.rootViewController = vc
    self.window?.makeKeyAndVisible()
    return true
}

  func propsInit () -> NSDictionary {
    
    let ud = UserDefaults.standard
    let keyAr = ["secret", "recipients", "notification"]
    var fileAr:[String] = []
    var stale=false
    
  //  if let dict:[String:Data] = ud.object(forKey: "Bookmarked") as? [String : Data] {
    
   //   if let secret = dict[keyAr[0]]{
    if let secret = ud.object(forKey: keyAr[0]) as? Data{
        if let bookmarked=try? URL.init(resolvingBookmarkData: secret, options: [NSURL.BookmarkResolutionOptions.withoutUI], relativeTo: nil, bookmarkDataIsStale: &stale){
          print("stale: \(stale)")
          fileAr.append(bookmarked.lastPathComponent)
          
        }
        else{
          fileAr.append("")
        }
      }
    else {
      
      fileAr.append("")
    }
    if let recipients = ud.object(forKey: keyAr[1]) as? Data{
        
        if let bookmarked=try? URL.init(resolvingBookmarkData: recipients, options: [NSURL.BookmarkResolutionOptions.withoutUI], relativeTo: nil, bookmarkDataIsStale: &stale){
          print("stale: \(stale)")
          fileAr.append(bookmarked.lastPathComponent)
          
        }
        else{
          fileAr.append("")
        }
      }
//    }
    else {
      
      
      fileAr.append("")
      
    }
    
    if let notif = shoppingListURL() {
      
      fileAr.append(notif.lastPathComponent)
      
      }
      else {
        fileAr.append("")
    }
    
  
    return NSDictionary.init(objects: fileAr, forKeys: keyAr  as [NSCopying])
    
  }
  
  func shoppingListURL ()->URL?
  {
    //if let baseURL = FileManager.default.urls(for : .documentDirectory, in : .userDomainMask).last
    let fm = FileManager.default
    var newDocumentURL:URL?
    if let baseURL = fm.url(forUbiquityContainerIdentifier: "com.apple.CloudDocs"){
      /*        if   let dir = try? fm.createDirectory(at: baseURL, withIntermediateDirectories: false, attributes: nil){
       newDocumentURL=baseURL.appendingPathComponent(dir.p)
       }*/
      //        newDocumentURL=baseURL.appendingPathComponent("APNfromThePhone", isDirectory:true).appendingPathComponent("Untitled10.json")
      if   (try? fm.createDirectory(at:baseURL.appendingPathComponent("APNfromThePhone"), withIntermediateDirectories: true, attributes:nil)) != nil{
        newDocumentURL=baseURL.appendingPathComponent("APNfromThePhone").appendingPathComponent("Untitled.json")
        let newDocument = Document.init(fileURL: newDocumentURL!)
        newDocument.text="{\n\t\"aps\":\n\t\t{\n\t\t\t\"content-available\":1\n\t\t}\n}"
        newDocument.save(to: newDocumentURL!, for: .forCreating, completionHandler: {(success) in
          if success {
            newDocument.close(completionHandler: {(success) in
              if !success {
                print("first not success")
                newDocumentURL = nil
              }
            })
          }
          else{
            newDocumentURL = nil
            print("second one")
          }
        })
      }
      print("before the first one")
      return newDocumentURL
    }
    
    return nil
  }
  func sourceURL(for bridge: RCTBridge!) -> URL! {
   //       #if DEBUG
  //  return URL(string: "http://localhost:8081/index.bundle?platform=ios")
  return  RCTBundleURLProvider.sharedSettings()?.jsBundleURL(forBundleRoot: "index", fallbackResource: nil)
   //         #else
   //      return Bundle.main.url(forResource:"main", withExtension:"jsbundle");
   //        #endif
    
    /*
     When moving your app to production, the NSURL can point to a pre-bundled file on disk via something like let mainBundle = NSBundle(URLForResource: "main" withExtension:"jsbundle"). You can use the react-native-xcode.sh script in node_modules/react-native/scripts/ to generate that pre-bundled file.
     */
}

  func applicationWillResignActive(_ application: UIApplication) {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
  }
  
  func applicationDidEnterBackground(_ application: UIApplication) {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
  }
  
  func applicationWillEnterForeground(_ application: UIApplication) {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
  }
  
  func applicationDidBecomeActive(_ application: UIApplication) {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
  }
  
  func applicationWillTerminate(_ application: UIApplication) {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
  }
}

/*
 ld: warning: directory not found for option '-L/Users/mariagrynychyn/Downloads/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/swift-5.0/iphonesimulator'
 Undefined symbols for architecture x86_64:
 "_OBJC_CLASS_$_AppDelegate", referenced from:
 objc-class-ref in main.o
 ld: symbol(s) not found for architecture x86_64
 clang: error: linker command failed with exit code 1 (use -v to see invocation)
*/
