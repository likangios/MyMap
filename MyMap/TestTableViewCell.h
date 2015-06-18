//
//  TestTableViewCell.h
//  MyMap
//
//  Created by 李康 on 15/6/11.
//  Copyright (c) 2015年 Luck. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BookClickBlocks)(NSDictionary *bookDic);

@interface TestTableViewCell : UITableViewCell

@property (nonatomic,strong) NSArray *images;

@property (nonatomic,copy) BookClickBlocks bookclick;
- (void)CleanImages;
@end
