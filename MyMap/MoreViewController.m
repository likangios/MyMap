//
//  MoreViewController.m
//  MyMap
//
//  Created by 李康 on 15/6/18.
//  Copyright (c) 2015年 Luck. All rights reserved.
//

#import "MoreViewController.h"

@interface MoreViewController ()

@end

@implementation MoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 70, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-70)];
    label.backgroundColor = [UIColor colorWithRed:arc4random()%10/10.0 green:arc4random()%10/10.0 blue:arc4random()%10/10.0 alpha:1.0];
    label.text = self.content[@"bookname"];
    [self.view addSubview:label];
    
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(20, 90, 70, 92)];
    
    NSString *path = [[[NSBundle mainBundle] pathsForResourcesOfType:@".jpg" inDirectory:self.content[@"img"]] firstObject];
    
    [imageview setImage:[UIImage imageWithContentsOfFile:path]];
    
    
    [self.view addSubview:imageview];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
