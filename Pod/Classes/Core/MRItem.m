//
//  MRItem.m
//  MagicRemind
//
//  Created by baidu on 15/11/5.
//  Copyright © 2015年 dzpqzb. All rights reserved.
//

#import "MRItem.h"
#import "MRItem_Private.h"
#import "MRLayoutItem.h"
#import "MRLayoutTextItem.h"
#import "MRLayoutNumberItem.h"
static NSString* kMRItemIdentifier = @"I";
static NSString* kMRItemShow = @"S";
static NSString* kMRItemLayoutItems = @"L";
@implementation MRItem

- (instancetype) initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (!self) {
        return self;
    }
    self.identifier = [aDecoder decodeObjectForKey:kMRItemIdentifier];
    self.show = [aDecoder decodeBoolForKey:kMRItemShow];
    NSArray* layouts = [aDecoder decodeObjectForKey:kMRItemLayoutItems];
    NSMutableArray* array = [NSMutableArray new];
    for (NSDictionary* dic  in layouts) {
        MRLayoutItem* item = [MRLayoutItem layoutItemWithInfos:dic];
        if (item) {
            [array addObject:item];
        }
    }
    self.neeedUpdate = YES;
    self.layoutItems = array;
    return self;
}

- (void) encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeBool:self.show forKey:kMRItemShow];
    [aCoder encodeObject:self.identifier forKey:kMRItemIdentifier];
    NSMutableArray* layouts = [NSMutableArray new];
    for (MRLayoutItem* item  in self.layoutItems) {
        NSDictionary* info = [item toDictionary];
        if (info) {
            [layouts addObject:info];
        }
    }
    [aCoder encodeObject:layouts forKey:kMRItemLayoutItems];
}

- (int) unreadNumber
{
    int i = 0;
    for (MRLayoutItem* item  in self.layoutItems) {
        if ([item isKindOfClass:[MRLayoutNumberItem class]]) {
            i += [(MRLayoutNumberItem*)item  number];
        }
    }
    return i;
}

- (MRItem*) joinWithItem:(MRItem *)item
{
    if (!item) {
        return [self copy];
    }
    if (!item.show) {
        return [self copy];
    }
    int sUN = [self unreadNumber];
    int oUN = [item unreadNumber];
    if (sUN || oUN) {
        return [MRItem numberItem:sUN + oUN];
    }
    return nil;
}


+ (MRItem*) numberItem:(int)number
{
    MRItem* item = [MRItem new];
    item.show = YES;
    MRLayoutNumberItem* numberLayout= [MRLayoutNumberItem new];
    numberLayout.number= number;
    item.layoutItems = @[numberLayout];
    if (number > 0) {
        item.show = YES;
    } else {
        item.show = NO;
    }
    return item;
}

- (instancetype) copyWithZone:(NSZone *)zone
{
    MRItem* item = [[MRItem allocWithZone:zone] init];
    item.layoutItems  = [self.layoutItems copy];
    item.identifier = self.identifier;
    item.show = self.show;
    item.neeedUpdate = self.neeedUpdate;
    return item;
}
@end
