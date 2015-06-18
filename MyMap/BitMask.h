//
//  BitMask.h
//  xuexuecan
//
//  Created by teng.tang on 15/4/9.
//  Copyright (c) 2015年 ICan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BitMask : NSObject

// 某一位是否设置 ( 1到64 之间)
+(BOOL) is_set:(NSNumber *) value AtBit:(NSNumber *) bit;

// 设置某一位
+(NSNumber *) set:(NSNumber *) value AtBit:(NSNumber *) bit;

// 重置某一位
+(NSNumber *) un_set:(NSNumber *) value AtBit:(NSNumber *) bit;

// 设置一系列位
+(NSNumber *) setFromBitArray:(NSNumber *) value FromArray:(NSArray *) array;

// 提取出哪些位是设置的
+(NSArray *) extractToArray:(NSNumber *) value StartBit:(NSNumber *) start_bit EndBit:(NSNumber *) end_bit;

@end
