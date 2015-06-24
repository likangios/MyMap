//
//  TestTableViewCell.m
//  MyMap
//
//  Created by 李康 on 15/6/11.
//  Copyright (c) 2015年 Luck. All rights reserved.
//

#import "TestTableViewCell.h"
#import "BitMask.h"

@implementation TestTableViewCell
{
    UIImageView *_im1;
    UIImageView *_im2;
    UIImageView *_im3;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _im1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, 135)];
        _im1.image = [UIImage imageNamed:@"main_cell_bg"];
        _im1.userInteractionEnabled = YES;
        [self.contentView addSubview:_im1];
        int imageviewcount = 3;
        CGFloat imageviewH = 100;
        CGFloat imageviewW = 74;
        CGFloat startpoint_x = 15;
        CGFloat space = ([UIScreen mainScreen].bounds.size.width-2*startpoint_x-imageviewcount*imageviewW)/(imageviewcount-1);
        for (int i = 0; i<imageviewcount; i++) {
            
            UIImageView *imageview = [[UIImageView alloc]init];
            imageview.bounds = CGRectMake(0, 0, imageviewW, imageviewH);
            imageview.center = CGPointMake(startpoint_x+imageviewW/2.0+(imageviewW+space)*i, CGRectGetMidY(_im1.frame));
            imageview.userInteractionEnabled = YES;
            imageview.image = [UIImage imageNamed:@"main_cell_shujia"];
            
            UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(0, 4, 66, 96)];
            img.tag = 1<<i;
            img.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageTap:)];
            [img addGestureRecognizer:tap];
            
            [imageview addSubview:img];
            
            [_im1 addSubview:imageview];
        }
    }
    return self;
}
- (void)imageTap:(UITapGestureRecognizer *)tap{
    
    UIImageView *imagev = (UIImageView *)tap.view;
    
    NSArray *index=  [BitMask extractToArray:[NSNumber numberWithInteger:imagev.tag] StartBit:@0 EndBit:@3];
    if (_bookclick)
    _bookclick(_images[[index.firstObject intValue]-1 ]);
}
- (void)CleanImages{
    for (int i = 0; i<3;i++) {
        UIImageView *imageview = (UIImageView *)[_im1 viewWithTag:1<<i];
        imageview.image = nil;
        imageview.superview.hidden = YES;
        imageview.hidden = YES;
    }
}
- (void)setImages:(NSArray *)images{
    _images = images;
    for (int i = 0; i<_images.count; i++) {
        UIImageView *imageview = (UIImageView *)[_im1 viewWithTag:1<<i];
        imageview.hidden = NO;
        imageview.superview.hidden = NO;
        imageview.image = [UIImage imageNamed:_images[i][@"img"]];
    }
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
