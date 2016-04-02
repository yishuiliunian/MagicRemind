//
//  NSMutableString+MRRichText.m
//  MagicRemind
//
//  Created by stonedong on 15/12/12.
//  Copyright © 2015年 dzpqzb. All rights reserved.
//

#import "NSMutableAttributedString+MRRichText.h"
#import <CoreText/CoreText.h>

static inline CTParagraphStyleSetting MRRichStringAlignSetting(CTTextAlignment align)
{
    CTTextAlignment alignment = align;
    CTParagraphStyleSetting alignmentStyle;
    alignmentStyle.spec=kCTParagraphStyleSpecifierAlignment;    alignmentStyle.valueSize=sizeof(alignment);
    alignmentStyle.value=&alignment;
    return alignmentStyle;
}


inline CTParagraphStyleSetting MRRichStringLineSpace(CGFloat lineSpace)
{
    CTParagraphStyleSetting lineSpaceStyle;
    lineSpaceStyle.spec=kCTParagraphStyleSpecifierLineSpacing;//指定为行间距属性
    lineSpaceStyle.valueSize=sizeof(lineSpace);
    lineSpaceStyle.value=&lineSpace;
    return lineSpaceStyle;
}

@implementation NSMutableAttributedString (MRRichText)
- (void) setTextAlignment:(CTTextAlignment)align
{
    CTParagraphStyleSetting setting = MRRichStringAlignSetting(align);
    CTParagraphStyleSetting settings[]={
        setting
    };
    CTParagraphStyleRef paragraphStyle = CTParagraphStyleCreate(settings, sizeof(settings));
    
    [self addAttribute:(id)kCTParagraphStyleAttributeName
                   value:(id)paragraphStyle
                 range:NSMakeRange(0, [self length])];
}

@end
