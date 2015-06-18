//
//  LActionBase.h
//  MyMap
//
//  Created by 李康 on 15/6/15.
//  Copyright (c) 2015年 Luck. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpActionMgr.h"
@class LActionBase;

typedef void(^ActionSuccessBlock)(LActionBase *action,id responseObj,AFHTTPRequestOperation *operation);

typedef void(^ActionFailureBlock)(LActionBase *action,NSError *error,AFHTTPRequestOperation *operation);

@interface LActionBase : NSObject


@property (nonatomic,strong) NSMutableDictionary *parameters;

- (id)initWithActionURLString:(NSString *)str_url;


- (BOOL)DoActionWithSuccess:(ActionSuccessBlock) success Failure:(ActionFailureBlock)failure;


@end

@interface GetActionBase : LActionBase


@end

@interface PostActionBase : LActionBase

@end
