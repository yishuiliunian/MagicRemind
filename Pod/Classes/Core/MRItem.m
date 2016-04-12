//
//  MRItem.m
//  MagicRemind
//
//  Created by baidu on 15/11/5.
//  Copyright © 2015年 dzpqzb. All rights reserved.
//

#import "MRItem.h"
#import <YYModel.h>
#import "MRItem_Private.h"
#import "MRLayoutItem.h"
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

@end
