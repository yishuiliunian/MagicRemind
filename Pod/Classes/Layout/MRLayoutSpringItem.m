//
//  MRLayoutSpringItem.m
//  MagicRemind
//
//  Created by baidu on 15/11/5.
//  Copyright © 2015年 dzpqzb. All rights reserved.
//

#import "MRLayoutSpringItem.h"
NSString* const kMRLayoutSpringType = @"spring";


@implementation MRLayoutSpringItem

- (NSDictionary*) toDictionary
{
    NSMutableDictionary* infos = [[super toDictionary] copy];
    NSDictionary* myInfos = @{};
    [infos addEntriesFromDictionary:myInfos];
    return infos;
}
@end
