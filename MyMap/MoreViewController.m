//
//  MoreViewController.m
//  MyMap
//
//  Created by 李康 on 15/6/18.
//  Copyright (c) 2015年 Luck. All rights reserved.
//

#import "MoreViewController.h"

@interface MoreViewController ()
{
    UILabel *_contentLabel;
}
@end

@implementation MoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 70, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-70)];
    _contentLabel.backgroundColor = [UIColor colorWithRed:arc4random()%10/10.0 green:arc4random()%10/10.0 blue:arc4random()%10/10.0 alpha:1.0];
    _contentLabel.text = self.content;
    [self.view addSubview:_contentLabel];
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
