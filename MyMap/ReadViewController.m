//
//  ReadViewController.m
//  MyMap
//
//  Created by 李康 on 15/6/16.
//  Copyright (c) 2015年 Luck. All rights reserved.
//

#import "ReadViewController.h"
#import "MoreViewController.h"
#import "FengMianViewController.h"


@interface ReadViewController ()<UIPageViewControllerDataSource,UIPageViewControllerDelegate>
{
    UIPageViewController *_pageVC;
    /**
     *  标题
     */
    UILabel *_titleLabel;
    /**
     *  页码
     */
    UILabel *_pageNumberLabel;
}

@property (nonatomic,strong) NSArray *pageContent;

@end

@implementation ReadViewController


- (id)JSONSerializationWithString:(NSString*)jsonString{
    
    NSData *data = [NSData dataWithContentsOfFile:jsonString];
    
    id obj =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    return obj;
}

- (void)creatContentPages{
    
    
    NSMutableArray *array = [NSMutableArray array];
    
    NSArray *txts = [[NSBundle mainBundle] pathsForResourcesOfType:@"txt" inDirectory:[NSString stringWithFormat:@"/novel_zip/novel_content/book_%@",self.dic[@"id"]]];
    
    NSDictionary *dic = [self JSONSerializationWithString:[txts lastObject]];

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

- (UIViewController *)viewControllerAtIndex:(NSInteger)index{
    
    if (index>=self.pageContent.count||self.pageContent == 0) {
        return nil ;
    }
    if (index == 0) {
        FengMianViewController *fengmian = [[FengMianViewController alloc]init];
        
        fengmian.BIntroduction = self.dic[@"info"];
        NSString *img = self.dic[@"img"];
        UIImage *imag = [UIImage imageNamed:[[img componentsSeparatedByString:@"/"] lastObject]];
        fengmian.FrontCoverImage = imag;
        fengmian.BAuthor  = self.dic[@"author"];
        fengmian.BName = self.dic[@"bookname"];
        return fengmian;
    }
    MoreViewController *more = [[MoreViewController alloc]init];
    
    more.content = self.pageContent[index][@"info"];
    
    return more;
}

- (NSInteger)indexOfViewController:(UIViewController *)viewcontroller{
    
    if ([viewcontroller isKindOfClass:[FengMianViewController class]]) {
        _titleLabel.text = @"封面";
        return 0;
    }else{
        
    MoreViewController *more = (MoreViewController *)viewcontroller;
    NSInteger index =[self.pageContent indexOfObject:more.content];
    
    NSLog(@"--index%ld ",(long)index);
        
    return index;

    }
    
}
-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{

    NSInteger index = [self indexOfViewController:viewController];

    NSLog(@"After--index%ld ",(long)index);
    
    if (index == NSNotFound||index == (self.pageContent.count-1)) {
        return nil  ;
    }
    index++;
    
    return [self viewControllerAtIndex:index];
}
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    
    NSInteger index = [self indexOfViewController:viewController];
   
    NSLog(@"Before--index%ld ",(long)index);

    if (index == NSNotFound||index == 0) {
        return nil  ;
    }
    index--;
    
    return [self viewControllerAtIndex:index];
}
#pragma action
- (void)creatItem{
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"button_back_on"] style:UIBarButtonItemStylePlain target:self action:@selector(backClick)];
    
    leftItem.tintColor = [UIColor grayColor];
    
    self.navigationItem.leftBarButtonItem = leftItem;
    
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"button_shuqian_on"] style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemClick)];
    
    rightItem.tintColor = [UIColor grayColor];
    
    self.navigationItem.rightBarButtonItem = rightItem;
    
    self.navigationController.hidesBarsOnTap = YES;
    
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.bounds = CGRectMake(0, 0, 100, 44);
    _titleLabel.text= @"封面";
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.center = CGPointMake(Screen_width/2.0, 42);
    [self.view addSubview:_titleLabel];
    
    
    _pageNumberLabel  = [[UILabel alloc]init];
    _pageNumberLabel.bounds = CGRectMake(0, 0, 30, 44);
    _pageNumberLabel.text = @"1/1";
    _pageNumberLabel.textAlignment = NSTextAlignmentRight;
    _pageNumberLabel.center  =CGPointMake(Screen_width-40, 42);
    [self.view addSubview:_pageNumberLabel];
}
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
