//
//  FengMianViewController.m
//  MyMap
//
//  Created by 李康 on 15/6/23.
//  Copyright (c) 2015年 Luck. All rights reserved.
//

#import "FengMianViewController.h"

@interface FengMianViewController ()
{
    UIImageView *_FrontCover;
    
    UILabel *_Book_name;
    UILabel *_Book_author;
    UILabel *_Book_intro;

}
@end

@implementation FengMianViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _FrontCover = [[UIImageView alloc]initWithFrame:CGRectMake(20, 80, 113, 165)];
    
    _FrontCover.image =self.FrontCoverImage;
    
    [self.view addSubview:_FrontCover];
    
    _Book_name = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_FrontCover.frame)+30, CGRectGetMinY(_FrontCover.frame)+30, Screen_width-CGRectGetMaxX(_FrontCover.frame)-60, 25)];
    _Book_name.textAlignment = NSTextAlignmentCenter;
    _Book_name.font = [UIFont boldSystemFontOfSize:16];
    _Book_name.text = self.BName;
    
    
    _Book_author = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(_Book_name.frame), CGRectGetMaxY(_Book_name.frame)+15, CGRectGetWidth(_Book_name.frame), 25)];
    _Book_author.textAlignment = NSTextAlignmentCenter;
    _Book_author.font = [UIFont systemFontOfSize:14];
    _Book_author.text = self.BAuthor;
    
    
    _Book_intro = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(_FrontCover.frame), CGRectGetMaxY(_FrontCover.frame)+35, Screen_width-2*CGRectGetMinX(_FrontCover.frame), Screen_height-CGRectGetMaxY(_FrontCover.frame)-55)];
    _Book_intro.text = self.BIntroduction;
    _Book_intro.numberOfLines = 0;
    _Book_intro.font = [UIFont systemFontOfSize:ContentFont_Size];
    _Book_intro.textAlignment = NSTextAlignmentLeft;

    [self.view addSubview:_Book_name];
    [self.view addSubview:_Book_author];
    [self.view addSubview:_Book_intro];
    
    
    
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
