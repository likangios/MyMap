//
//  ViewController.m
//  MyMap
//
//  Created by 李康 on 15/5/8.
//  Copyright (c) 2015年 Luck. All rights reserved.
//

#import "ViewController.h"
#import "TestTableViewController.h"

#import "aaimageview.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"title";
    self.view.backgroundColor = [UIColor whiteColor];
    aaimageview *imageview=  [[aaimageview alloc]initWithFrame:CGRectMake(50, 200, 200, 200)];
    imageview.layer.borderColor = [UIColor redColor].CGColor;
    imageview.layer.borderWidth = 1.0;
    imageview.backgroundColor = [UIColor blackColor];
    
    imageview.layer.shadowColor = [UIColor orangeColor].CGColor;
    imageview.layer.shadowOffset = CGSizeMake(5, 5);
    imageview.layer.shadowOpacity = 1;
    imageview.layer.shadowRadius = 5;
    [self.view addSubview:imageview];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"ssss" forState:UIControlStateNormal];
    button.frame = CGRectMake(240, 350, 60, 30);
    button.backgroundColor = [UIColor blackColor];
    [button addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}
- (void)click{
    
    TestTableViewController *test =[[TestTableViewController alloc]init];
    [self.navigationController pushViewController:test animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
