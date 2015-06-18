//
//  ReadViewController.m
//  MyMap
//
//  Created by 李康 on 15/6/16.
//  Copyright (c) 2015年 Luck. All rights reserved.
//

#import "ReadViewController.h"
#import "MoreViewController.h"

@interface ReadViewController ()<UIPageViewControllerDataSource,UIPageViewControllerDelegate>
{
    UIPageViewController *_pageVC;
}

@property (nonatomic,strong) NSArray *pageContent;

@end

@implementation ReadViewController

- (void)creatContentPages{
    NSMutableArray *array = [NSMutableArray array];
    
    
    for (int i = 0; i<10; i++) {
        
        NSDictionary *diction = [[NSDictionary dictionaryWithDictionary:self.dic] mutableCopy];

        [diction setValue:[NSString stringWithFormat:@"%d",i] forKey:@"customID"];
        
        [array addObject:diction];
    }
    _pageContent = [NSArray arrayWithArray:array];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self creatContentPages];
    self.title = self.dic[@"bookname"];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor colorWithRed:.9 green:0.8 blue:0.7 alpha:1.0];
    
    [self creatItem];
    
    self.navigationController.hidesBarsOnTap = YES;

    
   _pageVC = [[UIPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    _pageVC.view.frame = self.view.bounds;
    _pageVC.doubleSided = YES;
    _pageVC.delegate = self;
    _pageVC.dataSource = self;
    NSArray *arr = [NSArray arrayWithObjects:[self viewControllerAtIndex:0],nil];
   
    [_pageVC setViewControllers:arr direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:^(BOOL finished) {
    
    }];
    [self addChildViewController:_pageVC];
    
    [self.view addSubview:_pageVC.view];
    
}
- (void)creatItem{
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"button_back_on"] style:UIBarButtonItemStylePlain target:self action:@selector(backClick)];
    leftItem.tintColor = [UIColor grayColor];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"button_shuqian_on"] style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemClick)];
    rightItem.tintColor = [UIColor grayColor];
    self.navigationItem.rightBarButtonItem = rightItem;
}
- (MoreViewController *)viewControllerAtIndex:(NSInteger)index{
    if (index>=self.pageContent.count||self.pageContent == 0) {
        return nil ;
    }
    MoreViewController *more = [[MoreViewController alloc]init];
    more.content = self.pageContent[index];
    
    return more;
}

- (NSInteger)indexOfViewController:(MoreViewController *)viewcontroller{
    
    NSInteger index =[self.pageContent indexOfObject:viewcontroller.content];
    
    NSLog(@"--index%ld ",(long)index);
    
    return index;
    
}
-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{

    NSInteger index = [self indexOfViewController:(MoreViewController *)viewController];

    NSLog(@"After--index%ld ",(long)index);
    
    if (index == NSNotFound||index == (self.pageContent.count-1)) {
        return nil  ;
    }
    index++;
    
    return [self viewControllerAtIndex:index];
}
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    
    NSInteger index = [self indexOfViewController:(MoreViewController *)viewController];
   
    NSLog(@"Before--index%ld ",(long)index);

    if (index == NSNotFound||index == 0) {
        return nil  ;
    }
    index--;
    
    return [self viewControllerAtIndex:index];
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
