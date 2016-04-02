//
//  DZRun.h
//  MagicRemind
//
//  Created by stonedong on 15/12/13.
//  Copyright © 2015年 dzpqzb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreText/CoreText.h>
@interface DZRun : NSObject
@property (nonatomic, assign, readonly) CTRunRef run;
@property (nonatomic, assign, readonly) CGRect imageBounds;
@property (nonatomic, assign, readonly) NSUInteger glyphCount;
- (instancetype) initWithRun:(CTRunRef)run withContext:(CGContextRef)context;

@end
