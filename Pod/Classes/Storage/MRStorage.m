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
static NSString* kMagicRemindKey  = @"kMagicRemindKey";
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


- (void) updateRemind:(NSString *)identifier text:(NSString *)text
{
    MRItem* item = [[MRItem alloc] init];
    item.show = YES;
    MRLayoutTextItem* textLayout= [MRLayoutTextItem new];
    textLayout.text = text;
    item.layoutItems = @[textLayout];
    item.identifier = identifier;
    [self cacheItem:item];
}

- (void) hiddenRemind:(NSString *)identifier
{
    MRItem* item  = [self itemWithIdentifier:identifier];
    item.show = NO;
    
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


@end
