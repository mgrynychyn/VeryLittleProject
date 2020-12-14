//
//  Experimental.swift
//  LittleProject
//
//  Created by Maria Grynychyn on 10/12/20.
//

import Foundation
import React

//@objc (Experimental)
@objc (Experimental) class Experimental : NSObject, RCTBridgeModule, UIDocumentPickerDelegate {
  
  
  static func moduleName() -> String! {
    
    return "Experimental"
  }
  
  
  static func requiresMainQueueSetup()->Bool
  {
    return true;  // only do this if your module initialization relies on calling UIKit!
  }
  
//  let methodQueue = DispatchQueue.main
  
 // RCT_EXPORT_METHOD();
  @objc (getMyInfo:callback:)
  func getMyInfo(name:String, callback:RCTResponseSenderBlock){
  
    print("Pretending to create an event at %@", name);
    
    let pick = UIDocumentPickerViewController (documentTypes: ["public.text"], in: .open)
    pick.delegate=self
    pick.title=name
 /*   let dwi = DispatchWorkItem.init(block:{
      (UIApplication.shared.windows)[0].rootViewController?.present(pick, animated: true, completion: nil)
    })*/
    DispatchQueue.main.async {
     (UIApplication.shared.windows)[0].rootViewController?.present(pick, animated: true, completion: nil)
   }
  }
  
  func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
    //   let fileName = urls[0].lastPathComponent
    //problem on new Simulator for XCode v11.2.1
    print("did Pick")
//    if let bookmark=try? urls[0].bookmarkData(options: [NSURL.BookmarkCreationOptions.suitableForBookmarkFile], includingResourceValuesForKeys: nil, relativeTo: nil){
      if controller.title != nil {
        let ud = UserDefaults.standard
        let keyAr:[String] = ["secret", "recipients", "notification"]
        var fileAr:[String] = []
        
        if let dict = (((UIApplication.shared.windows)[0].rootViewController?.view) as! RCTRootView).appProperties! as NSDictionary?{
          
          for key in keyAr {
            
            if key == controller.title{
              fileAr.append(urls[0].lastPathComponent)
              
              if let bookmark=try? urls[0].bookmarkData(options: [NSURL.BookmarkCreationOptions.suitableForBookmarkFile], includingResourceValuesForKeys: nil, relativeTo: nil){
                ud.set(bookmark, forKey:controller.title!)
                
              }
            }
            else{
              
              fileAr.append(dict.object(forKey: key) as! String)
            
            }
          
        }
        
      }
        
        (((UIApplication.shared.windows)[0].rootViewController?.view)as! RCTRootView).appProperties = NSDictionary.init(objects: fileAr, forKeys: keyAr as [NSCopying]) as! [String : String]
      
    }
    
    
  }
// required by RCTBridgeMethod protocol method return type does not exist in Swift therefore cannot be mapped

/*  func methodQueue()->DispatchQueue
  {
    return DispatchQueue.main
  }*/
  
 
}
