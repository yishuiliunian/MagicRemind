//
//  MRLayoutItem.m
//  MagicRemind
//
//  Created by baidu on 15/11/5.
//  Copyright © 2015年 dzpqzb. All rights reserved.
//

#import "MRLayoutItem.h"
#import "MRLayoutTextItem.h"
#import "MRLayoutSpringItem.h"
NSString* const kMRLayoutItemType = @"type";

@implementation MRLayoutItem
+ (MRLayoutItem*) layoutItemWithInfos:(NSDictionary *)infos
{
    NSString* type = infos[kMRLayoutItemType];
    MRLayoutItem* item = nil;
    if ([type isEqualToString:kMRLayoutTextType]) {
        item = [MRLayoutTextItem new];
    } else if ([type isEqualToString:kMRLayoutSpringType]) {
        item = [MRLayoutSpringItem new];
    }
    [item setValuesForKeysWithDictionary:infos];
    return item;
}

- (NSDictionary*) toDictionary
{
    return [self dictionaryWithValuesForKeys:@[kMRLayoutItemType, kMRLayoutSpringType]];
}

- (id) valueForKey:(NSString *)key
{
    if ([kMRLayoutItemType isEqualToString:key]) {
        if ([self isKindOfClass:[MRLayoutTextItem class]]) {
            return kMRLayoutTextType;
        } else if ([self isKindOfClass:[MRLayoutSpringItem class]]) {
            return kMRLayoutSpringType;
        }
    }
    return [NSNull null];
}


- (CGSize) size
{
    return CGSizeZero;
}
- (void) setValuesForKeysWithDictionary:(NSDictionary<NSString *,id> *)keyedValues
{
    [super setValuesForKeysWithDictionary:keyedValues];
    [self prelayout];
}

- (void) prelayout
{
    
}
@end
