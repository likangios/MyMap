//
//  HttpActionMgr.h
//  MyMap
//
//  Created by 李康 on 15/6/15.
//  Copyright (c) 2015年 Luck. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
@interface HttpActionMgr : NSObject


+(id)shared;

-(void)ClearCookies;

- (AFHTTPRequestOperationManager *)getHttpActionMgr;

@end
