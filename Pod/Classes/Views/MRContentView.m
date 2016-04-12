//
//  MRContentView.m
//  MagicRemind
//
//  Created by baidu on 15/11/5.
//  Copyright © 2015年 dzpqzb. All rights reserved.
//

#import "MRContentView.h"
#import "MRItem.h"
#import "MRLayoutItem.h"
#import "MRLayoutSpringItem.h"
#import <CoreText/CoreText.h>
#import "DZRun.h"
#import "DZLineLayout.h"
@interface MRContentView()
{
    MRItem* _item;
}
@property (nonatomic, strong)  UILabel* __label;
@end
@implementation MRContentView


- (instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) {
        return self;
    }
 
    return self;
}

- (void) layoutMRItem:(MRItem *)item
{
    if (_item != item) {
        _item = item;
    }
    if (!item.neeedUpdate) {
        return;
    }
    [self setNeedsDisplay];
}




@end