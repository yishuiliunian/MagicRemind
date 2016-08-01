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
static NSString* kMagicRemindKey  = @"kMagicRemindKey";
@interface MRStorage ()
{
    NSMutableDictionary* _magicRemindCache;
    NSMutableArray* _allListener;
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
    _allListener = [NSMutableArray new];
    [self registerChangeListender:[MRDependencyReleation shareManager]];
    [self loadStorage];
    NSNotificationCenter* ncenter = [NSNotificationCenter defaultCenter];
    [ncenter addObserver:self selector:@selector(archiveStorage) name:
     UIApplicationDidEnterBackgroundNotification
                  object:nil];
    [ncenter addObserver:self selector:@selector(archiveStorage) name:
     UIApplicationDidReceiveMemoryWarningNotification
                  object:nil];
    [ncenter addObserver:self selector:@selector(archiveStorage) name:UIApplicationWillResignActiveNotification object:nil];
    [ncenter addObserver:self selector:@selector(archiveStorage) name:UIApplicationWillTerminateNotification object:nil];
    
    return self;
}

- (MRItem*) itemWithIdentifier:(NSString *)identifier
{
    return _magicRemindCache[identifier];
}

- (void) cacheItem:(MRItem*)item
{
    if (item.identifier) {
        _magicRemindCache[item.identifier] = item;
        [self archiveStorage];
    }
}

- (void) updateItem:(MRItem*)item
{
    if (!item) {
        return;
    }
    [self cacheItem:item];
    for (id<MRStatesProtocol> l in _allListener) {
        if ([l respondsToSelector:@selector(storage:willChangeItem:showState:)]) {
            [l storage:self willChangeItem:item showState:NO];
        }
    }
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
    for (id<MRStatesProtocol> l in _allListener) {
        if ([l respondsToSelector:@selector(storage:willChangeItem:showState:)]) {
            [l storage:self willChangeItem:item showState:NO];
        }
    }
    //
    [[NSNotificationCenter defaultCenter] postNotificationName:MRNotificationKey(item.identifier) object:nil];
}

- (void) loadStorage
{
    NSData* data = [[NSUserDefaults standardUserDefaults] objectForKey:kMagicRemindKey];
    if (!data) {
        return;
    }

    NSDictionary* cache = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    [_magicRemindCache addEntriesFromDictionary:cache];
}

- (void) archiveStorage
{
    NSDictionary* cache = [_magicRemindCache copy];
    NSData* allItems = [NSKeyedArchiver archivedDataWithRootObject:cache];
    [[NSUserDefaults standardUserDefaults] setObject:allItems forKey:kMagicRemindKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void) registerChangeListender:(id<MRStatesProtocol>)listener
{
    [_allListener addObject:listener];
}
@end
