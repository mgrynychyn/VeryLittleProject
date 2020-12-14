//
//  ExperimentalBridge.m
//  LittleProject
//
//  Created by Maria Grynychyn on 10/16/20.
//

#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(Experimental, NSObject)

RCT_EXTERN_METHOD(getMyInfo:(NSString *)name callback:(RCTResponseSenderBlock)callback)

@end
