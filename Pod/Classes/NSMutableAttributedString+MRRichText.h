//
//  NSMutableString+MRRichText.h
//  MagicRemind
//
//  Created by stonedong on 15/12/12.
//  Copyright © 2015年 dzpqzb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreText/CoreText.h>
@interface NSMutableAttributedString (MRRichText)
- (void) setTextAlignment:(CTTextAlignment)align;
@end
