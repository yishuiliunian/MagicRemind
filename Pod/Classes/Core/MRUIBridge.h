//
//  MRUIBridge.h
//  MagicRemind
//
//  Created by baidu on 15/11/5.
//  Copyright © 2015年 dzpqzb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^MRUIBridgeAction)(void);

@class MRItem;
@interface MRUIBridge : NSObject
@property (nonatomic, strong, readonly) NSString* identifier;
@property (nonatomic, weak) UIView* layoutView;
@property (nonatomic, strong) MRUIBridgeAction customAction;
- (instancetype) initWithIdentifier:(NSString*)identifier;
- (MRItem*) magicRemindItem;
- (void) hidden;
@end
