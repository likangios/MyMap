//
//  BitMask.m
//  xuexuecan
//
//  Created by teng.tang on 15/4/9.
//  Copyright (c) 2015年 ICan. All rights reserved.
//

#import "BitMask.h"

@implementation BitMask

+(BOOL) is_set:(NSNumber *) value AtBit:(NSNumber *) bit
{
    if( !value || !bit )
        return NO;
    
    unsigned long long v = [value unsignedLongLongValue];
    unsigned long long b = [bit unsignedLongLongValue];
    if( v & (1<<(b - 1)) )
        return YES;
    
    return NO;
}

+(NSNumber *) set:(NSNumber *) value AtBit:(NSNumber *) bit
{
    if( !value || !bit )
        return nil;

    unsigned long long v = [value unsignedLongLongValue];
    unsigned long long b = [bit unsignedLongLongValue];
    unsigned long long nv = v | (1 << (b - 1 ));
    return [NSNumber numberWithLongLong:nv];
}

+(NSNumber *) un_set:(NSNumber *) value AtBit:(NSNumber *) bit
{
    if( !value || !bit )
        return nil;
    
    unsigned long long v = [value unsignedLongLongValue];
    unsigned long long b = [bit unsignedLongLongValue];
    if( b <= 0 )
        return nil;
    unsigned long long nb = b - 1;
    unsigned long long nv = v;
    nv &= ~(1 << nb);
    return [NSNumber numberWithLongLong:nv];
}

+(NSNumber *) reset:(NSNumber *) value
{
    return @0;
}


+(NSNumber *) setFromBitArray:(NSNumber *) value FromArray:(NSArray *) array
{
    NSNumber * new_value = [NSNumber numberWithUnsignedLongLong:[value unsignedLongLongValue]];

    for (id elm in array) {
        if( [elm isKindOfClass:[NSNumber class]] )
        {
            new_value = [BitMask set:new_value AtBit:elm];
        }
    }
    
    return new_value;
}

+(NSArray *) extractToArray:(NSNumber *) value StartBit:(NSNumber *) start_bit EndBit:(NSNumber *) end_bit
{
    if( !value || !start_bit || !end_bit )
        return nil;

    unsigned long long sb = [start_bit unsignedLongLongValue];
    unsigned long long eb = [end_bit unsignedLongLongValue];
    if( sb > eb )
        return nil;
    
    NSMutableArray * result = [[NSMutableArray alloc] init];

    for( unsigned long long i = sb; i <= eb ; i++ )
    {
        if( [BitMask is_set:value AtBit:[NSNumber numberWithUnsignedLongLong:i]] )
        {
            [result addObject:[NSNumber numberWithUnsignedLongLong:i]];
        }
    }
    
    return result;
}




@end
