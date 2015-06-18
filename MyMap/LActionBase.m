//
//  LActionBase.m
//  MyMap
//
//  Created by 李康 on 15/6/15.
//  Copyright (c) 2015年 Luck. All rights reserved.
//

#import "LActionBase.h"

@interface LActionBase ()

@property (nonatomic,strong)NSString *url;

@end

@implementation LActionBase


- (id)initWithActionURLString:(NSString *)str_url{
   
    self = [super init];
    if (self) {
        
    self.url = str_url;
        
    }
    return self;
}
- (NSString *)get_action_url{

    return self.url;
}
-(BOOL)DoActionWithSuccess:(ActionSuccessBlock)success Failure:(ActionFailureBlock)failure{

    return YES;
}
@end

@implementation GetActionBase

-(BOOL)DoActionWithSuccess:(ActionSuccessBlock)success Failure:(ActionFailureBlock)failure{
 
    AFHTTPRequestOperationManager *http_request_mgr = [[HttpActionMgr shared] getHttpActionMgr];
    if (!http_request_mgr) {
        return NO;
    }
    [http_request_mgr GET:[self get_action_url] parameters:self.parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(self,responseObject,operation);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(self,error,operation);
    }];
    
    return YES;
}
@end

@implementation PostActionBase

-(BOOL)DoActionWithSuccess:(ActionSuccessBlock)success Failure:(ActionFailureBlock)failure{
    
    AFHTTPRequestOperationManager *http_request_mgr = [[HttpActionMgr shared] getHttpActionMgr];
    if (!http_request_mgr) {
        return NO;
    }
    [http_request_mgr POST:[self get_action_url] parameters:self.parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    return YES;
}

@end
