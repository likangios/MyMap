//
//  MuLuTableViewController.h
//  MyMap
//
//  Created by 李康 on 15/6/25.
//  Copyright (c) 2015年 Luck. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CellClickBlocks)(NSDictionary *dic);

@interface MuLuTableViewController : UITableViewController

@property (nonatomic,strong) NSArray *tableViewData;

@property (nonatomic,assign) NSInteger currentPage;

@property (nonatomic,copy)  CellClickBlocks cellBlocks;
@end
