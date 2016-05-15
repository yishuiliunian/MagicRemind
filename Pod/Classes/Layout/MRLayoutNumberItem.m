//
//  MRLayoutNumberItem.m
//  Pods
//
//  Created by stonedong on 16/5/14.
//
//

#import "MRLayoutNumberItem.h"

NSString* const kMRLayoutNumberBiggest = @"...";

NSString* const kMRLayoutNumberType = @"number";
NSString* const kMRLayoutNumberNumber = @"number";
@implementation MRLayoutNumberItem
@synthesize number = _number;
- (void) setValue:(id)value forKey:(NSString *)key
{
    if ([key isEqualToString:kMRLayoutNumberNumber]) {
        _number = [value integerValue];
    } else {
        [super setValue:value forKey:key];
    }
}

- (id) valueForKey:(NSString *)key
{
    if ([key isEqualToString:kMRLayoutNumberNumber]) {
        return @(_number);
    } else {
        return [super valueForKey:key];
    }
}

- (void)  setNumber:(int)number
{
    if (number > 99) {
        _text = kMRLayoutNumberBiggest;
    } else {
        _text = [@(number) stringValue];
    }
    _number = number;
}

- (int)number
{
    return _number;
}
@end

