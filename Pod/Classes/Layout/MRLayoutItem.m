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
#import "MRLayoutNumberItem.h"
#import <objc/runtime.h>
NSString* const kMRLayoutItemType = @"type";

@implementation MRLayoutItem
+ (MRLayoutItem*) layoutItemWithInfos:(NSDictionary *)infos
{
    NSString* type = infos[kMRLayoutItemType];
    Class class = NSClassFromString(type);
    MRLayoutItem* item = nil;
    if ([class isSubclassOfClass:[MRLayoutItem class]]) {
       item = [class new];
    }
    [item setValuesForKeysWithDictionary:infos];
    return item;
}

- (void) setValue:(id)value forKey:(NSString *)key
{
    if ([key isEqualToString:kMRLayoutItemType]) {
        
    } else {
        [super setValue:value forKey:key];
    }

}

- (NSDictionary*) toDictionary
{
    return [self dictionaryWithValuesForKeys:@[kMRLayoutItemType]];
}

- (id) valueForKey:(NSString *)key
{
    if ([kMRLayoutItemType isEqualToString:key]) {
        return NSStringFromClass([self class]);
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
