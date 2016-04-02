//
//  MRLayoutItem.h
//  MagicRemind
//
//  Created by baidu on 15/11/5.
//  Copyright © 2015年 dzpqzb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
extern NSString* const kMRLayoutItemType;

@interface MRLayoutItem : NSObject

@property (assign, readonly) CGSize size;

+ (MRLayoutItem*) layoutItemWithInfos:(NSDictionary*)infos;
/**
 *  提前计算当前Item展示的大小之类的东西
 */
- (void) prelayout;
@end
