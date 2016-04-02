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



- (MRContentView*) MR_contentView
{
    MRContentView* contentView = [self viewWithTag:self.MR_contentViewTag];
    if (!contentView) {
        contentView = [MRContentView new];
    } else {
        if (![contentView isKindOfClass:[MRContentView class]]) {
            contentView = [MRContentView new];
            self.MR_contentViewTag = self.MR_contentViewTag++;
        }
    }
    contentView.tag = self.MR_contentViewTag;
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
    
    if (!item.show) {
        UIView* view = [self viewWithTag:self.MR_contentViewTag];
        if ([view isKindOfClass:[MRContentView class]]) {
            view.hidden = YES;
        }
    } else {
        MRContentView* contentView = [self MR_contentView];
        contentView.frame = self.bounds;
        contentView.backgroundColor = [UIColor redColor];
    }
}

@end
