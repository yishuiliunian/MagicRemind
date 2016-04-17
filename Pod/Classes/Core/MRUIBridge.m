//
//  MRUIBridge.m
//  MagicRemind
//
//  Created by baidu on 15/11/5.
//  Copyright © 2015年 dzpqzb. All rights reserved.
//

#import "MRUIBridge.h"
#import "MRStorage.h"
#import "MRItem.h"
#import "MRNotification.h"
@implementation MRUIBridge
- (instancetype) initWithIdentifier:(NSString *)identifier
{
    self = [super init];
    if (!self) {
        return self;
    }
    _identifier = identifier;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stateChanged:) name:MRNotificationKey(_identifier) object:nil];
    return self;
}

- (void) stateChanged:(NSNotification*)nc
{
    [self.layoutView setNeedsLayout];
}

- (MRItem*) magicRemindItem
{
    return [[MRStorage shareStorage] itemWithIdentifier:self.identifier];
}

- (void) hidden
{
    [[MRStorage shareStorage] hiddenRemind:self.identifier];
    [self.layoutView setNeedsLayout];
}

@end
