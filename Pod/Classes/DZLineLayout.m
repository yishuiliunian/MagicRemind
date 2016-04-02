//
//  DZLineLayout.m
//  DZLineText
//
//  Created by baidu on 15/12/14.
//  Copyright © 2015年 dzpqzb. All rights reserved.
//

#import "DZLineLayout.h"
#import "DZRunRef.h"




@implementation DZLineLayout
- (void) dealloc
{
    if (_lineRef) {
        CFRelease(_lineRef);
    }
}
- (instancetype) initWithBounds:(CGRect)bounds string:(NSAttributedString *)string
{
    self = [super init];
    if (!self) {
        return self;
    }
    _bounds = bounds;
    _lineRef = CTLineCreateWithAttributedString((__bridge CFAttributedStringRef)string);
    CFArrayRef runRefs = CTLineGetGlyphRuns(_lineRef);
    NSMutableArray* dzRuns = [NSMutableArray new];
    for (int i = 0, max =(int)CFArrayGetCount(runRefs); i < max; i++) {
        CTRunRef run = CFArrayGetValueAtIndex(runRefs, i);
        DZRunRef* dzRun = [[DZRunRef alloc] initWithRunRef:run];
        [dzRuns addObject:dzRun];
    }
    _runs = dzRuns;
    return self;
}

- (void) drawInContext:(CGContextRef)context
{
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGFloat width = self.bounds.size.width;
    CGFloat height = CGRectGetHeight(self.bounds);
    for (int i = 0; i < self.runs.count; i++) {
        DZRunRef* run = self.runs[i];
        if (i == 0) {
            CGContextSetTextPosition(context,
                                     0,
                                     height /2 -(run.height - run.ascent));
        } else {
            CGContextSetTextPosition(context,
                                     width - run.width - run.position.x,
                                     height /2 -(run.height - run.ascent));
        }
        CTRunDraw(run.runRef, context, CFRangeZero);
            
    }
    

}

@end
