//
//  DZRunRef.h
//  DZLineText
//
//  Created by baidu on 15/12/14.
//  Copyright © 2015年 dzpqzb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreText/CoreText.h>

#define CFRangeZero  __CFRangeZero()

static inline CFRange __CFRangeZero()
{
    return CFRangeMake(0, 0);
}

typedef NS_OPTIONS(NSUInteger, DZTextAlignment)
{
    DZTextAlignmentLeft,
    DZTextAlignmentRight,
    DZTextAlignmentCenter
};

extern NSString* const kDZTextAlignment;

@interface DZRunRef : NSObject
@property (nonatomic, strong, readonly) NSDictionary* attributes;
@property (nonatomic, assign, readonly) CTRunRef runRef;
@property (nonatomic, assign, readonly) CGRect frame;
@property (nonatomic, assign, readonly) CFIndex glyphCount;
@property (nonatomic, assign, readonly) CTRunStatus status;
@property (nonatomic, strong, readonly) NSArray* positions;
@property (nonatomic, assign, readonly) CGFloat ascent;
@property (nonatomic, assign, readonly) CGFloat descent;
@property (nonatomic, assign, readonly) CGFloat leading;
@property (nonatomic, assign, readonly) CGFloat width;
@property (nonatomic, assign, readonly) CGFloat height;
@property (nonatomic, assign, readonly) CGPoint position;
@property (nonatomic, assign, readonly) DZTextAlignment textAlignment;
@property (nonatomic, assign) CGFloat offet;
- (instancetype) initWithRunRef:(CTRunRef)run;
@end
