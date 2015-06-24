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
    
    _contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 70, [UIScreen mainScreen].bounds.size.width-20, [UIScreen mainScreen].bounds.size.height-70)];
    _contentLabel.backgroundColor = [UIColor clearColor];
    _contentLabel.textAlignment = NSTextAlignmentLeft;
    _contentLabel.text = self.content;
    _contentLabel.numberOfLines = 0;
    _contentLabel.font = [UIFont systemFontOfSize:ContentFont_Size];
    
    _contentLabel.frame = CGRectMake(10, 70, [UIScreen mainScreen].bounds.size.width-20, [self CalSizeByString:self.content ForWidth:CGRectGetWidth(_contentLabel.frame) ForFont:_contentLabel.font].height);
    [self.view addSubview:_contentLabel];
    
}
-(CGSize)CalSizeByString:(NSString *)str ForWidth:(CGFloat)width ForFont:(UIFont *)font
{
    
    CGSize constraint = CGSizeMake(width, CGFLOAT_MAX);
    CGSize size;
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")) {
        size = [str boundingRectWithSize:constraint options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil] context:nil].size;
    }
    else
        size = [str sizeWithFont:font constrainedToSize:constraint];
    return size;
    
    
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
