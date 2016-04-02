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
#import "NSMutableAttributedString+MRRichText.h"
#import "DZRun.h"
#import "DZLineLayout.h"
@interface MRContentView()
{
    MRItem* _item;
    
}
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


- (void) layoutSubviews
{
    [super layoutSubviews];
}
- (NSArray*) shrinkLayoutItems:(NSArray*)items
{
    CGFloat width = 0;
    NSMutableArray* array = [NSMutableArray new];
    for (MRLayoutSpringItem* item  in items) {
        if ([item isKindOfClass:[MRLayoutSpringItem class]]) {
            continue;
        }
        if (item.size.height > CGRectGetHeight(self.bounds)) {
            continue;
        }
        if (item.size.width > CGRectGetWidth(self.bounds)) {
            continue;
        }
        [array addObject:item];
    }

    for (MRLayoutItem* item in array) {
        if ([item isKindOfClass:[MRLayoutSpringItem class]]) {
            continue;
        }
        width += item.size.width;
    }
    return nil;
}


- (void) drawRect:(CGRect)rect
{
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    NSMutableAttributedString* str = [[NSMutableAttributedString alloc] initWithString:@"测试"];
    [str appendAttributedString:[[NSAttributedString alloc] initWithString:@"中文"]];
    
    DZLineLayout* layout = [[DZLineLayout alloc] initWithBounds:self.bounds string:str];
    [layout drawInContext:context];
 
    
  
}

@end