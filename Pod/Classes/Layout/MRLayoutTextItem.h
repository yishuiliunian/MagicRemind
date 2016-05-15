//
//  MRLayoutTextItem.h
//  MagicRemind
//
//  Created by baidu on 15/11/5.
//  Copyright © 2015年 dzpqzb. All rights reserved.
//

#import "MRLayoutItem.h"

extern NSString* const kMRLayoutTextType;

@interface MRLayoutTextItem : MRLayoutItem
{
    @protected
    NSString* _text;
}
/**
 *  用来展示的文字信息
 */
@property (nonatomic, strong) NSString* text;
/**
 *  用来展示的文字的颜色
 */
@property (nonatomic, strong) NSString* textColor;
/**
 *  文字的大小
 */
@property (nonatomic, assign) CGFloat fontSize;
/**
 *  背景色
 */
@property (nonatomic, strong) NSString* backgroundColor;
/**
 *  边角圆弧的大小
 */
@property (nonatomic, assign) CGFloat cornerRediusRatio;
@end
