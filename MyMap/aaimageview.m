
//
//  aaimageview.m
//  MyMap
//
//  Created by 李康 on 15/5/12.
//  Copyright (c) 2015年 Luck. All rights reserved.
//

#import "aaimageview.h"

@implementation aaimageview

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

- (void)drawRect:(CGRect)rect {
    
    
    
    
    CGContextRef con = UIGraphicsGetCurrentContext();
//
//    CGContextAddEllipseInRect(con, CGRectMake(0,0,100,100));
//    
//    CGContextSetFillColorWithColor(con, [UIColor blueColor].CGColor);
//    
//    CGContextFillPath(con);
    
    /*
//    没边框
    CGContextSetRGBFillColor(con, 0.2, 0.3, 0.4, 1.0);
    CGContextFillRect(con, CGRectMake(100, 0, 100, 100));
    CGContextStrokePath(con);

//    边框
    CGContextSetRGBStrokeColor(con, 0.8, 0.1, 0.8, 1.0);
    CGContextSetLineWidth(con, 1);
    CGContextAddRect(con, CGRectMake(10, 10, 30, 30));
    CGContextStrokePath(con);

    //    一条线
    CGContextSetRGBStrokeColor(con, 0.1, 0.8, 0.9, 1.0);
    CGContextMoveToPoint(con, 10, 100);
    CGContextAddLineToPoint(con, 10, 200);
    CGContextStrokePath(con);

    //    圆框
    CGContextSetRGBStrokeColor(con, 0.15, 0.11, 0.15, 1.0);
    CGContextAddEllipseInRect(con, CGRectMake(10, 120, 10, 10));
    
    CGContextStrokePath(con);
    
//    中间镂空 方块
    CGContextTranslateCTM(con, 150,100);//位置
    CGContextScaleCTM(con, 1, -1);//缩放
    UIGraphicsPushContext(con);
    CGContextSetLineWidth(con, 10);
    CGContextSetRGBStrokeColor(con, 1, 0.1, 0.98, 1.0);
    CGContextStrokeRect(con, CGRectMake(0, 0, 50, 50));
    UIGraphicsPopContext();
//
//    CGContextBeginPath(con);
//    CGContextSetRGBStrokeColor(con, 0.2, 0.1, 0.8, 1.0);
//    CGContextAddArc(con,0, 100, 30, 0, M_PI, 0);
//    CGContextStrokePath(con);
    */
//    圆弧
    CGContextBeginPath(con);
    CGContextSetRGBStrokeColor(con, 0, 1, 0, 1);
    CGContextAddArc(con, 100, 100, 50,0,M_PI*3/2,0);
    CGContextStrokePath(con);
    
    
    
    
//    for (int i =0; i<100;i++) {
//        CGContextMoveToPoint(con, 0, 100+i);
//        CGContextAddLineToPoint(con, 100-i, 150);
//    }
//    
//    CGContextSetRGBStrokeColor(con, 0.8, 0.14, 0.5, 1.0);
//    for (int i =0; i<50;i++) {
//        CGContextMoveToPoint(con,i*4,200);
//        CGContextAddLineToPoint(con,200, 200-8*i);
//    }
//    CGContextStrokePath(con);

    /*
    CGContextSetRGBStrokeColor(context, 0.53, 0.123, 0.132, 1.0);
    CGContextFillRect(context, CGRectMake(10, 10, 50, 50));
    CGContextStrokePath(context);
    
    
    //    UIColor*aColor = [UIColor colorWithRed:0 green:1.0 blue:0 alpha:0];
    CGContextSetRGBStrokeColor(context, 1.0, 0, 0, 1.0);
    //   CGContextSetFillColorWithColor(context, aColor.CGColor);
    CGContextSetLineWidth(context, 4.0);
    CGPoint aPoints[5];
    aPoints[0] =CGPointMake(60, 60);
    aPoints[1] =CGPointMake(260, 60);
    aPoints[2] =CGPointMake(260, 300);
    aPoints[3] =CGPointMake(60, 300);
    aPoints[4] =CGPointMake(60, 60);
    CGContextAddLines(context, aPoints, 5);
    CGContextDrawPath(context, kCGPathStroke); //开始画线*/
    [self performSelector:@selector(clipImage) withObject:nil afterDelay:2.0];
}
- (void)clipImage{
    UIGraphicsBeginImageContext(self.bounds.size);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image=UIGraphicsGetImageFromCurrentImageContext();
//把得到的图片 裁剪指定的区域
    UIImage *img = [UIImage imageWithCGImage:CGImageCreateWithImageInRect(image.CGImage, CGRectMake(0, 0, self.bounds.size.width,self.bounds.size.height))];
    UIGraphicsEndImageContext();
    UIImageWriteToSavedPhotosAlbum(img,self,nil, nil);
}
@end
