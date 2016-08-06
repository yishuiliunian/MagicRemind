//
//  MRSimpleContentView.m
//  Pods
//
//  Created by baidu on 16/4/11.
//
//

#import "MRSimpleContentView.h"
#import "MRLayoutItem.h"
#import "MRItem.h"
#import "MRLayoutTextItem.h"
#import "DZBadgeView.h"
@interface MRSimpleContentView ()
@property (nonatomic, strong) DZBadgeView* badgeView;
@property (nonatomic, strong) MRItem* item;
@end

@implementation MRSimpleContentView
- (instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) {
        return self;
    }
    _badgeView = [[DZBadgeView alloc] init];
    [self addSubview:_badgeView];
    return self;
}

- (void) sizeToFit
{
    MRLayoutItem* layoutItem = _item.layoutItems.lastObject;
    if ([layoutItem isKindOfClass:[MRLayoutTextItem class]]) {
        MRLayoutTextItem* textItem = (MRLayoutTextItem*)layoutItem;
        _badgeView.horiticalCenter = self.horiticalCenter;
        _badgeView.text= textItem.text;
    }
    CGRect rect = self.frame;
    rect.size = _badgeView.contentSize;
    self.frame = rect;
}

- (void) layoutMRItem:(MRItem *)item
{
    _item = item;
    [self setNeedsLayout];
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    MRLayoutItem* layoutItem = _item.layoutItems.lastObject;
    if ([layoutItem isKindOfClass:[MRLayoutTextItem class]]) {
        MRLayoutTextItem* textItem = (MRLayoutTextItem*)layoutItem;
        _badgeView.horiticalCenter = self.horiticalCenter;
        _badgeView.text= textItem.text;
        _badgeView.frame = self.bounds;
    }
}
@end
