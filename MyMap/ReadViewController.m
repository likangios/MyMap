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
#import "MuLuTableViewController.h"


@interface ReadViewController ()<UIPageViewControllerDataSource,UIPageViewControllerDelegate,UINavigationControllerDelegate,UINavigationBarDelegate>
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
    
    /**
     *  当前页码
     */
    NSInteger _currentPage;
    /**
     *  目录
     */
    NSMutableArray *_directory;
}

@property (nonatomic,strong) NSMutableArray *pageContent;

@end


@implementation ReadViewController

- (void)initData{
    _pageContent = [NSMutableArray array];
    
    [_pageContent addObject:self.dic];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self creatContentPages];
    });
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.toolbarHidden = NO;
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self initData];
    self.title = self.dic[@"bookname"];
    [self.dic setValue:@0 forKey:@"startPage"];
    [self.dic setValue:@0 forKey:@"endPage"];
    
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
- (void)creatItem{
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"button_back_on"] style:UIBarButtonItemStylePlain target:self action:@selector(backClick)];
    
    leftItem.tintColor = [UIColor grayColor];
    
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"button_shuqian_on"] style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemClick)];
    rightItem.tintColor = [UIColor grayColor];
    
    self.navigationItem.rightBarButtonItem = rightItem;
    
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.bounds = CGRectMake(0, 0, 200, 44);
    _titleLabel.text= @"封面";
    _titleLabel.font = [UIFont systemFontOfSize:13];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.center = CGPointMake(Screen_width/2.0, 42);
    [self.view addSubview:_titleLabel];
    
    
    _pageNumberLabel  = [[UILabel alloc]init];
    _pageNumberLabel.bounds = CGRectMake(0, 0, 40, 44);
    _pageNumberLabel.font = [UIFont systemFontOfSize:13];
    _pageNumberLabel.text = @"1/1";
    _pageNumberLabel.textAlignment = NSTextAlignmentRight;
    _pageNumberLabel.center  =CGPointMake(Screen_width-10-CGRectGetWidth(_pageNumberLabel.frame)/2.0, 42);
    [self.view addSubview:_pageNumberLabel];
    
    
    UIView *toolbar = [[UIView alloc]   initWithFrame:CGRectMake(0, 0, Screen_width, 44)];
    toolbar.backgroundColor = [UIColor snowColor];
    NSArray *butArray = @[@"button_zuo",@"button_zidaxiao",@"button_liangdu",@"button_mulu",@"button_you"];
    
    CGFloat butWidth = (Screen_width-20)/butArray.count;
    
    CGFloat butHeight = 44;
    
    for (int i = 0; i<butArray.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(10+i*butWidth, 0, butWidth, butHeight);
        [button setImage:[UIImage imageNamed:butArray[i]] forState:UIControlStateNormal];
        button.tag = 1+i;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [toolbar addSubview:button];
    }
    
    self.navigationController.toolbarHidden = NO;
    
    self.navigationController.toolbar.frame =CGRectMake(0, Screen_height-44, Screen_width, 44);
    
    self.navigationController.toolbar.tintColor = [UIColor greenColor];

    [self.navigationController.toolbar addSubview:toolbar];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick)];
    [self.view addGestureRecognizer:tap];
    
}
/**
 *  获取前面一章的起始页码
 *
 *  @param currentpage 当前页码
 *
 *  @return 返回前一章的起始页码
 */
- (NSInteger )getBeforPageWith:(NSInteger)currentpage{
    
    NSDictionary *currentDic = self.pageContent[currentpage];
    NSNumber *startN = currentDic[@"startPage"];
    NSInteger startP = startN.integerValue;
    NSDictionary *beforDic = self.pageContent[startP-1];
    NSNumber *beforN = beforDic[@"startPage"];
    NSInteger beforP = beforN.integerValue;
    return beforP;
}
- (NSInteger )getAfterPageWith:(NSInteger)currentpage{
    NSDictionary *currentDic = self.pageContent[currentpage];
    NSNumber *endN = currentDic[@"endPage"];
    NSInteger endP = endN.integerValue;
    NSDictionary *afterDic = self.pageContent[endP+1];
    NSNumber *afterN = afterDic[@"startPage"];
    NSInteger afterP = afterN.integerValue;
    return afterP;
}
- (void)buttonClick:(UIButton *)button{
    switch (button.tag) {
        case 1:{
            if (_currentPage>0) {
                
            NSInteger beforP = [self getBeforPageWith:_currentPage];
                typeof(self) _weakSelf = self;
            UIViewController *vc = [self viewControllerAtIndex:beforP];
            [_pageVC setViewControllers:@[vc] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:^(BOOL finished) {
                _currentPage = beforP;
                [_weakSelf changeTitleAndPage:beforP];
            }];
           
            }
            
        }
            NSLog(@"前一章");
            break;
        case 2:
            NSLog(@"字体");
            break;
        case 3:
            NSLog(@"亮度");
            break;
        case 4:{
            NSLog(@"目录");
            MuLuTableViewController *mulu = [[MuLuTableViewController alloc]init];
            mulu.currentPage = _currentPage;
            mulu.tableViewData = _directory;
            [mulu setCellBlocks:^(NSDictionary *dic){
                
                NSNumber *selectPage = dic[@"startPage"];
                NSInteger page = selectPage.integerValue;
                typeof(self) _weakSelf = self;
                
                UIViewController *vc = [self viewControllerAtIndex:page];
                [_pageVC setViewControllers:@[vc] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:^(BOOL finished) {
                    _currentPage = page;
                    [_weakSelf changeTitleAndPage:page];
                    [_weakSelf.navigationController popViewControllerAnimated:YES];
                }];
            }];
        
            [self.navigationController pushViewController:mulu animated:YES];
        }
            break;
            
        case 5:    {
            if ((_currentPage+1)<self.pageContent.count) {
                typeof(self) _weakSelf = self;

            NSInteger afterP = [self getAfterPageWith:_currentPage];
            UIViewController *vc = [self viewControllerAtIndex:afterP];
            [_pageVC setViewControllers:@[vc] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:^(BOOL finished) {
                _currentPage = afterP;
            [_weakSelf changeTitleAndPage:afterP];
            }];
            }
            NSLog(@"后一章");

        }
            break;
            
        default:
            break;
    }
}
- (void)HiddenBar{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self.navigationController setToolbarHidden:self.navigationController.navigationBarHidden animated:YES];
}
- (void)tapClick{
    
    [self.navigationController setNavigationBarHidden:!self.navigationController.navigationBarHidden animated:YES];
    [self.navigationController setToolbarHidden:self.navigationController.navigationBarHidden animated:YES];
    
}
- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray *)pendingViewControllers{
    [self HiddenBar];
}
-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{

    NSInteger index = [self indexOfViewController:viewController];
    
    if (index == NSNotFound||index == (self.pageContent.count-1)) {
        return nil  ;
    }
    index++;
    
    return [self viewControllerAtIndex:index];
}
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    
    NSInteger index = [self indexOfViewController:viewController];

    if (index == NSNotFound||index == 0) {
        return nil  ;
    }
    index--;

    return [self viewControllerAtIndex:index];
}
- (UIViewController *)viewControllerAtIndex:(NSInteger)index{
    
    if (index>=self.pageContent.count||self.pageContent == 0) {
        
        return nil ;
    }
    if (index == 0) {
        FengMianViewController *fengmian = [[FengMianViewController alloc]init];
        fengmian.BIntroduction = self.dic[@"info"];
        fengmian.diction = self.pageContent[index];
        fengmian.FrontCoverImage = [UIImage imageNamed:self.dic[@"img"]];
        fengmian.BAuthor  = self.dic[@"author"];
        fengmian.BName = self.dic[@"bookname"];
        return fengmian;
    }
    MoreViewController *more = [[MoreViewController alloc]init];
    more.content = self.pageContent[index][@"content"];
    more.diction =self.pageContent[index];

    return more;
}
- (NSInteger)indexOfViewController:(UIViewController *)viewcontroller{
    
    NSInteger index;
    if ([viewcontroller isKindOfClass:[FengMianViewController class]]) {
        index =  0;
    }else{
        MoreViewController *more = (MoreViewController *)viewcontroller;
         index =[self.pageContent indexOfObject:more.diction];
    }
    _currentPage = index;
    
    [self changeTitleAndPage:index];

    NSLog(@"currentPage-----%ld",(long)_currentPage);
    return index;

}
- (void)changeTitleAndPage:(NSInteger)index{
    
    if (index == 0) {
        _titleLabel.text = @"封面";
        _pageNumberLabel.text = @"1/1";
    }else{
        NSDictionary *diction = self.pageContent[index];
    _titleLabel.text = diction[@"title"];
        _pageNumberLabel.text = diction[@"page"];
    }
    
}
#pragma actio
- (void)backClick{
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)rightBarButtonItemClick{
    
    NSMutableDictionary *shuqian = [NSMutableDictionary dictionaryWithDictionary:self.pageContent[_currentPage]];
    
    [shuqian setValue:self.dic[@"bookname"] forKey:@"bookname"];

    [shuqian setValue:[NSNumber numberWithInteger:_currentPage] forKey:@"currentPage"];

    NSUserDefaults *defau = [NSUserDefaults standardUserDefaults];
    
    NSMutableArray *array = [defau valueForKey:KBookMark];
    if (array) {
        [array addObject:shuqian];
    }else{
        array = [NSMutableArray arrayWithObject:shuqian];
    }
    [defau setValue:array forKey:KBookMark];
    [defau synchronize];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (id)JSONSerializationWithString:(NSString*)jsonString{
    
    NSData *data = [NSData dataWithContentsOfFile:jsonString];
    
    id obj =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    return obj;
}

/**
 *  PageVeiwController Data
 */
- (void)creatContentPages{
    
    NSArray *txts = [[NSBundle mainBundle] pathsForResourcesOfType:@"txt" inDirectory:[NSString stringWithFormat:@"/novel_zip/novel_content/book_%@",self.dic[@"id"]]];
    
    NSDictionary *chapters = [self JSONSerializationWithString:[txts lastObject]];
    
    _directory = [NSMutableArray array];
    
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"封面",@"title",[NSNumber numberWithInteger:0],@"startPage",[NSNumber numberWithInteger:0],@"endPage",nil];
    [_directory addObject:dic];
    for (int i = 0; i<txts.count-1;i++) {
        
        NSString *path = txts[i];
        
        NSDictionary *dic = [self JSONSerializationWithString:path];
        
        NSArray *rangeArray = [self contentProcess:dic[@"content"]];
        
        NSInteger startPage = _pageContent.count;
        NSInteger endPage = _pageContent.count+rangeArray.count-1;
        
        NSDictionary *diction = [NSDictionary dictionaryWithObjectsAndKeys:dic[@"title"],@"title",[NSNumber numberWithInteger:startPage],@"startPage",[NSNumber numberWithInteger:endPage],@"endPage",nil];
        
        [_directory addObject:diction];
        for (int i = 0 ; i<rangeArray.count;i++ ) {
            
            NSString *string=  rangeArray[i];
            
            NSString *pageStr = [NSString stringWithFormat:@"%d/%lu",i+1,(unsigned long)rangeArray.count];
            
            NSDictionary *diction = [NSDictionary dictionaryWithObjectsAndKeys:dic[@"title"],@"title",string,@"content",pageStr,@"page",[NSNumber numberWithInteger:startPage],@"startPage",[NSNumber numberWithInteger:endPage],@"endPage", nil];
            
            [_pageContent addObject:diction];
        }
    }
}

/**
 *  返回内容大小
 *
 *  @param str   内容
 *  @param width 宽
 *  @param font  字体
 *
 *  @return 返回--size
 */
-(CGSize)CalSizeByString:(NSString *)str ForWidth:(CGFloat)width ForFont:(UIFont *)font
{
    
    CGSize constraint = CGSizeMake(width, CGFLOAT_MAX);
    CGSize size;
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")) {
        
        //        NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:str];
        //        NSRange range = NSMakeRange(0, attrStr.length);
        //        NSDictionary *dic = [attrStr attributesAtIndex:0 effectiveRange:&range];   // 获取该段attributedString的属性字典
        
        
        size = [str boundingRectWithSize:constraint options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil] context:nil].size;
        
    }
    else
        size = [str sizeWithFont:font constrainedToSize:constraint];
    return size;
    
    
}
/**
 *  文字处理
 *
 *  @param content 要处理的内容
 *
 *  @return 返回处理好的数组
 */
- (NSArray *)contentProcess:(NSString *)content{
    
    content = [content stringByReplacingOccurrencesOfString:@"<p>" withString:@""];
    content = [content stringByReplacingOccurrencesOfString:@"</p>" withString:@"\n"];
    content = [content stringByReplacingOccurrencesOfString:@"<br/>" withString:@"\n"];
    content = [content stringByReplacingOccurrencesOfString:@"<br />" withString:@"\n"];
    content = [content stringByReplacingOccurrencesOfString:@"&ldquo;" withString:@"“"];
    content = [content stringByReplacingOccurrencesOfString:@"&rdquo;" withString:@"”"];
    content = [content stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
    content = [content stringByReplacingOccurrencesOfString:@"&mdash;" withString:@"—"];
    content = [content stringByReplacingOccurrencesOfString:@"&hellip;" withString:@"..."];
    
    //   内容长度
    NSUInteger textLength = content.length;
    
    UIFont *font = [UIFont systemFontOfSize:ContentFont_Size];
    
    CGSize totalTextSize = [self CalSizeByString:content ForWidth:Screen_width-20 ForFont:font];
    //    多少页
    NSUInteger referTotalPages = totalTextSize.height/(Screen_height-70)+1;
    //    每页多少字符
    NSUInteger referCharatersPerpage = textLength/referTotalPages;
    
    NSMutableArray *array = [NSMutableArray array];
    
    
    for(NSUInteger location = 0;location<textLength;){
        NSRange  range = NSMakeRange(location, referCharatersPerpage);
        
        NSString *pageText;
        
        CGSize pageTextSize;
        
        while (range.location+range.length<textLength) {
            pageText = [content substringWithRange:range];
            pageTextSize = [self CalSizeByString:pageText ForWidth:Screen_width-20 ForFont:font];
            NSLog(@"%f",Screen_height);
            if (pageTextSize.height > (Screen_height-70)) {
                
                break;
            }
            else {
                range.length += 5;
            }
        }
        if (range.location+range.length>textLength) {
            
            range.length = textLength-range.location;
        }
        
        while (range.length > 0) {
            pageText = [content substringWithRange:range];
            pageTextSize = [self CalSizeByString:pageText ForWidth:Screen_width-20 ForFont:font];
            
            if (pageTextSize.height <= Screen_height-70) {
                range.length = [pageText length];
                break;
            }
            else {
                range.length -= 1;
            }
        }
        
        location +=range.length;
        
        [array addObject:pageText];
        
        
    }
    return array;
    
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
