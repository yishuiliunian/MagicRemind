//
//  DZLineLayout.h
//  DZLineText
//
//  Created by baidu on 15/12/14.
//  Copyright © 2015年 dzpqzb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>
@interface DZLineLayout : NSObject
@property (nonatomic, assign, readonly)  CTLineRef lineRef;
@property (nonatomic, strong, readonly)  NSArray* runs;
@property (nonatomic, assign, readonly)  CGRect bounds;
- (instancetype) init UNAVAILABLE_ATTRIBUTE;
- (instancetype) initWithBounds:(CGRect)bounds string:(NSAttributedString*)string;
- (void) drawInContext:(CGContextRef)ctx;
@end

