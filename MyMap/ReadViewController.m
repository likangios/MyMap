//
//  ReadViewController.m
//  MyMap
//
//  Created by 李康 on 15/6/16.
//  Copyright (c) 2015年 Luck. All rights reserved.
//

#import "ReadViewController.h"

@interface ReadViewController ()<UIPageViewControllerDataSource,UIPageViewControllerDelegate>

@end

@implementation ReadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"button_back_on"] style:UIBarButtonItemStylePlain target:self action:@selector(backClick)];
    leftItem.tintColor = [UIColor grayColor];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"button_shuqian_on"] style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemClick)];
    rightItem.tintColor = [UIColor grayColor];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    
    self.view.backgroundColor = [UIColor colorWithRed:.9 green:0.8 blue:0.7 alpha:1.0];
    
    self.title = self.dic[@"bookname"];
//    
//    UIPageViewController *pagview = [[UIPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
//    pagview.doubleSided = YES;
//    pagview.delegate = self;
//    pagview.dataSource = self;
//    NSMutableArray *arr = [NSMutableArray array];
//    
//    for (int i = 0; i<2; i++) {
//        UIViewController *vvv = [[UIViewController alloc]init];
//        vvv.view.backgroundColor = [UIColor colorWithRed:(i*20+100)/255.0 green:(i*20+200)/255.0 blue:(i*20+150)/255.0 alpha:1.0];
//        [arr addObject:vvv];
//    }
//    
//    [pagview setViewControllers:arr direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:^(BOOL finished) {
//    
//    }];
//    
//    [self.view addSubview:pagview.view];
    
}
-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    UIViewController *view = [[UIViewController alloc]init];
    view.view.backgroundColor = [UIColor greenColor];
    return view;
}
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    UIViewController *view = [[UIViewController alloc]init];
    view.view.backgroundColor = [UIColor orangeColor];
    return view;
}
#pragma action
- (void)backClick{
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)rightBarButtonItemClick{
    
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
