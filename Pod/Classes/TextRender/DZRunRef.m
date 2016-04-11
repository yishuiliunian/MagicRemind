//
//  DZRunRef.m
//  DZLineText
//
//  Created by baidu on 15/12/14.
//  Copyright © 2015年 dzpqzb. All rights reserved.
//

#import "DZRunRef.h"
#import <UIKit/UIKit.h>
NSString* const kDZTextAlignment = @"kDZTextAlignment";

@implementation DZRunRef

- (void) dealloc
{
    CFRelease(_runRef);
}

- (instancetype) initWithRunRef:(CTRunRef)run
{
    self = [super init];
    if (!self) {
        return self;
    }
    NSAssert(run != NULL, @"using a invaild run ref to init DZRunRef, it must not be null");
    _runRef = CFRetain(run);
    _attributes  = (__bridge  NSDictionary*)CTRunGetAttributes(run);
    _glyphCount = CTRunGetGlyphCount(_runRef);
    _status = CTRunGetStatus(_runRef);
    CGPoint* positions = malloc(sizeof(CGPoint)*_glyphCount);
    CTRunGetPositions(run, CFRangeZero , positions);
    NSMutableArray* pos = [NSMutableArray new];
    for (int i = 0; i < _glyphCount; i++) {
        CGPoint point = positions[i];
        [pos addObject:[NSValue valueWithCGPoint:point]];
    }
    free(positions);
    _positions = pos;
    _width = CTRunGetTypographicBounds(_runRef, CFRangeZero, &_ascent, &_descent, &_leading);
    _textAlignment = [_attributes[kDZTextAlignment] integerValue];
    _height = _descent + _ascent;
    CGPoint* point = (CGPoint*)CTRunGetPositionsPtr(_runRef);
    _position.x = point->x;
    _position.y = point->y;
    return self;
}

- (CGRect) frame
{
    CGRect frame = CTRunGetImageBounds(_runRef, NULL, CFRangeMake(0, 0));
    return frame;
}

@end
