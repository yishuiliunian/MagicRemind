//
//  MRStorage.m
//  MagicRemind
//
//  Created by baidu on 15/11/5.
//  Copyright © 2015年 dzpqzb. All rights reserved.
//

#import "MRStorage.h"
#import "MRItem.h"
@interface MRStorage ()
{
    NSMutableDictionary* _magicRemindCache;
}
@end


@implementation MRStorage
+ (MRStorage*) shareStorage
{
    static MRStorage* storage = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        storage = [MRStorage new];
    });
    return storage;
}

- (instancetype) init
{
    self = [super init];
    if (!self) {
        return self;
    }
    _magicRemindCache = [NSMutableDictionary new];
    return self;
}

- (MRItem*) itemWithIdentifier:(NSString *)identifier
{
    MRItem* item = [MRItem new];
    item.identifier = identifier;
    item.show = YES;
    item.layoutItems = @[];
    return item;
}

- (void) cacheItem:(MRItem*)item
{
    if (!item.identifier) {
        _magicRemindCache[item.identifier] = item;
    }
}

- (void) loadStorage
{
    
}

- (void) archiveStorage
{
    
}
@end
