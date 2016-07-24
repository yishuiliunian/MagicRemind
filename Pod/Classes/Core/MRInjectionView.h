//
//  MRInjectionView.h
//  MagicRemind
//
//  Created by baidu on 15/11/5.
//  Copyright © 2015年 dzpqzb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MRUIBridge.h"
@interface MRInjectionView : UIView
@property (nonatomic, strong) MRUIBridge* magicRemindBridge;
@property (nonatomic, assign) CGFloat xBadgeMargin;
@property (nonatomic, assign) CGFloat yBadgeMargin;
@property (nonatomic, assign) BOOL horizontalCenter;

- (void) enableTapClearRemind;
@end
