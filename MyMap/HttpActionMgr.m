//
//  HttpActionMgr.m
//  MyMap
//
//  Created by 李康 on 15/6/15.
//  Copyright (c) 2015年 Luck. All rights reserved.
//

#import "HttpActionMgr.h"

static HttpActionMgr *sharedMgr = nil;

@interface HttpActionMgr ()

@property (nonatomic,strong)AFHTTPRequestOperationManager *httpRequestMgr;

@end
@implementation HttpActionMgr


- (NSString *)getBaseUrlString{
    
    return [NSString stringWithFormat:@""];

}
- (AFHTTPRequestOperationManager *)getHttpActionMgr{
    
    return self.httpRequestMgr;
    
}
+(id)shared{
    if (!sharedMgr) {
        @synchronized(self){
            if (!sharedMgr) {
                
                sharedMgr = [[self alloc]init];
                NSURL *base_url = [NSURL URLWithString:[sharedMgr getBaseUrlString]];
                
                AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]initWithBaseURL:base_url];
//                返回格式JSON
                manager.responseSerializer = [AFJSONResponseSerializer serializer];
                
                sharedMgr.httpRequestMgr = manager;
            }
        }
    }

    return sharedMgr;
    
}
-(void)ClearCookies{
    NSURL *base_url = [NSURL URLWithString:[sharedMgr getBaseUrlString]];
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL:base_url];
    for (NSHTTPCookie *cookie in cookies) {
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
    }
    
}
@end
