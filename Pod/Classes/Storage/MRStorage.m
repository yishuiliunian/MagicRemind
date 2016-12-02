//
//  MRStorage.m
//  MagicRemind
//
//  Created by baidu on 15/11/5.
//  Copyright © 2015年 dzpqzb. All rights reserved.
//

#import "MRStorage.h"
#import "MRItem.h"
#import "MRLayoutTextItem.h"
#import "MRItem_Private.h"
#import "MRDependencyReleation.h"
#import "MRNotification.h"
#import "MRLayoutNumberItem.h"
#import <DZAccountFileCache/DZAccountFileCache.h>
#import "YHAccountData.h"
#import "DZLogger.h"
static NSString* kMagicRemindKey  = @"kMagicRemindKey";

@interface MRArchiveCodec : DZCacheArchiveCodec

@end

@implementation MRArchiveCodec

- (NSData*) encode:(NSDictionary*)object error:(NSError* __autoreleasing*)error;
{
    NSMutableDictionary* dic  = [object mutableCopy];
    NSArray* allKeys = dic.allKeys;
    for (NSString* key in allKeys) {
        MRItem* item = dic[key];
        if (!item.show) {
            [dic removeObjectForKey:key];
        }
    }
    return [super encode:dic error:error];
}
@end


@interface MRStorage ()
{
    NSMutableDictionary* _magicRemindCache;
    NSMutableArray* _allListener;
    DZFileCache* _fileCache;
    //
    NSRecursiveLock * _safeLock;
}
@end


@implementation MRStorage
+ (MRStorage*) shareStorage
{
    return [[YHAccountData shareFactory] shareInstanceFor:[self class] withInitBlock:^(id object) {
        [object init];
    }];
}

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (instancetype) init
{
    self = [super init];
    if (!self) {
        return self;
    }
    _fileCache = [[DZAccountFileCache activeCache] fileCacheWithName:@"magic-remind" codec:[MRArchiveCodec new]];
    _magicRemindCache = [NSMutableDictionary new];
    _allListener = [NSMutableArray new];
    [self registerChangeListender:[MRDependencyReleation shareManager]];
    [self loadStorage];
    return self;
}

- (MRItem*) itemWithIdentifier:(NSString *)identifier
{
    __block MRItem* item;
    [_safeLock lock];
    item = _magicRemindCache[identifier];
    [_safeLock unlock];;
    return item;
}

- (void) cacheItem:(MRItem*)item
{
    [_safeLock lock];
    if (item.identifier) {
            _magicRemindCache[item.identifier] = item;
    }
    [_safeLock unlock];
    [self archiveStorage];
}

- (void) removeItem:(MRItem*)item
{
    [_safeLock lock];
    if (item.identifier) {
        [_magicRemindCache removeObjectForKey:item.identifier];
    }
    [_safeLock unlock];
    [self archiveStorage];
}
- (void) updateItem:(MRItem*)item
{
    if (!item && ![item isKindOfClass:[MRItem class]]) {
        return;
    }
    [self cacheItem:item];
    [_safeLock lock];
    for (id<MRStatesProtocol> l in _allListener) {
        if ([l respondsToSelector:@selector(storage:willChangeItem:showState:)]) {
            [l storage:self willChangeItem:item showState:NO];
        }
    }
    [_safeLock unlock];
    [[NSNotificationCenter defaultCenter] postNotificationName:MRNotificationKey(item.identifier) object:nil];
}

- (void) updateRemind:(NSString *)identifier number:(int)number
{
    MRItem* item = [self itemWithIdentifier:identifier];
    if (!item) {
        item = [[MRItem alloc] init];
    }
    MRLayoutNumberItem* numberLayout= [MRLayoutNumberItem new];
    numberLayout.number= number;
    item.layoutItems = @[numberLayout];
    item.identifier = identifier;
    if (number > 0) {
        item.show = YES;
    } else {
        item.show = NO;
    }
    [self updateItem:item];
}


- (void) updateRemind:(NSString *)identifier text:(NSString *)text
{
    MRItem* item = [self itemWithIdentifier:identifier];
    if (!item) {
        item = [[MRItem alloc] init];
    }

    item.show = YES;
    MRLayoutTextItem* textLayout= [MRLayoutTextItem new];
    textLayout.text = text;
    item.layoutItems = @[textLayout];
    item.identifier = identifier;
    [self updateItem:item];

}

- (void) updateRemindWithPoint:(NSString *)identifier
{
    MRItem* item = [self itemWithIdentifier:identifier];
    if (!item) {
        item = [[MRItem alloc] init];
    }
    
    item.show = YES;
    MRLayoutTextItem* textLayout= [MRLayoutTextItem new];
    textLayout.text = @"";
    item.layoutItems = @[textLayout];
    item.identifier = identifier;
    [self updateItem:item];
}
- (void) hiddenRemind:(NSString *)identifier
{
    MRItem* item  = [self itemWithIdentifier:identifier];
    item.show = NO;
    [self archiveStorage];
    [_safeLock lock];
    for (id<MRStatesProtocol> l in _allListener) {
        if ([l respondsToSelector:@selector(storage:willChangeItem:showState:)]) {
            [l storage:self willChangeItem:item showState:NO];
        }
    }
    [_safeLock unlock];
    //
    [[NSNotificationCenter defaultCenter] postNotificationName:MRNotificationKey(item.identifier) object:nil];
}

- (void) loadStorage
{
    NSDictionary* fileCachedObject = _fileCache.lastCachedObject;
    if ([fileCachedObject isKindOfClass:[NSDictionary class]]) {
        [_magicRemindCache addEntriesFromDictionary:fileCachedObject];
    }
}

- (void) archiveStorage
{
    [_safeLock lock];
    _fileCache.lastCachedObject = [_magicRemindCache copy];
    [_safeLock unlock];
}

- (void) registerChangeListender:(id<MRStatesProtocol>)listener
{
    [_safeLock lock];
    [_allListener addObject:listener];
    [_safeLock unlock];
}
@end
