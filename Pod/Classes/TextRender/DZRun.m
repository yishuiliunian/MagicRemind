//
//  DZRun.m
//  MagicRemind
//
//  Created by stonedong on 15/12/13.
//  Copyright © 2015年 dzpqzb. All rights reserved.
//

#import "DZRun.h"

@implementation DZRun
- (instancetype) initWithRun:(CTRunRef)run withContext:(CGContextRef)context
{
    self = [super init];
    if (!self) {
        return self;
    }
    _run = run;
    _glyphCount = CTRunGetGlyphCount(run);
    if (_glyphCount == 0) {
        return self;
    }
    CFRange maxRange = CFRangeMake(0, _glyphCount);
    _imageBounds = CTRunGetImageBounds(_run, context, maxRange);
    return self;
}

@end
