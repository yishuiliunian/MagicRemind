//
//  MRInjectionView.m
//  MagicRemind
//
//  Created by baidu on 15/11/5.
//  Copyright © 2015年 dzpqzb. All rights reserved.
//

#import "MRInjectionView.h"
#import <objc/runtime.h>
#import "MRContentView.h"
#import "MRItem.h"
#import "MRSimpleContentView.h"

static void* kMRUIBridge = &kMRUIBridge;
static void* kMRUIContentView = &kMRUIContentView;
@interface MRInjectionView ()
@property (nonatomic, assign) int MR_contentViewTag;
@end

@implementation MRInjectionView

- (void) setMagicRemindBridge:(MRUIBridge *)magicRemindBridge
{
    objc_setAssociatedObject(self, kMRUIBridge, magicRemindBridge, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (MRUIBridge*) magicRemindBridge
{
    return objc_getAssociatedObject(self, kMRUIBridge);
}

- (int) MR_contentViewTag
{
    NSNumber* tag = objc_getAssociatedObject(self, kMRUIContentView);
    if (!tag) {
        return 83743;
    }
    return [tag intValue];
}

- (void) setMR_contentViewTag:(int)MR_contentViewTag
{
    objc_setAssociatedObject(self, kMRUIContentView, @(MR_contentViewTag), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}



- (MRContentView*) MR_contentView:(Class)cla
{
    
    MRContentView* contentView;
    for (UIView* view in self.subviews) {
        if ([view isKindOfClass:[MRContentView class]]) {
            if ([view isKindOfClass:cla]) {
                contentView = view;
            } else {
                [view removeFromSuperview];
            }
        }
    }
    if (!contentView) {
        contentView = [cla new];
    }
    [self addSubview:contentView];
    [self bringSubviewToFront:contentView];
    return contentView;
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    MRUIBridge* bridge = self.magicRemindBridge;
    if (!bridge) {
        return;
    }
    MRItem* item = [bridge magicRemindItem];
    if (!item) {
        return;
    }
    
    if (!item.show && item.layoutItems.count == 0) {
        UIView* view = [self viewWithTag:self.MR_contentViewTag];
        if ([view isKindOfClass:[MRContentView class]]) {
            view.hidden = YES;
        }
    } else {
        if (item.layoutItems.count == 1) {
            MRContentView* contentView = [self MR_contentView:[MRSimpleContentView class]];
            contentView.frame = self.bounds;
            contentView.backgroundColor = [UIColor redColor];
            [contentView layoutMRItem:item];
        }
    }
}

@end
