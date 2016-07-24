//
//  MRContentView.h
//  MagicRemind
//
//  Created by baidu on 15/11/5.
//  Copyright © 2015年 dzpqzb. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MRItem;
@interface MRContentView : UIView
@property (nonatomic, assign) BOOL horiticalCenter;
- (void) layoutMRItem:(MRItem*)item;

@end
