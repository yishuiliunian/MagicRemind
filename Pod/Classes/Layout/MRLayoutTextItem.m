//
//  MRLayoutTextItem.m
//  MagicRemind
//
//  Created by baidu on 15/11/5.
//  Copyright © 2015年 dzpqzb. All rights reserved.
//

#import "MRLayoutTextItem.h"

NSString* const kMRLayoutTextType = @"text";


static NSString* kTextItemText = @"text";
static NSString* kTextItemTextColor = @"textColor";
static NSString* kTextItemFontSize = @"fontSize";
static NSString* kTextItemBackgroundColor = @"bgColor";
static NSString* kTextItemCornerRatio = @"corner";

@interface MRLayoutTextItem ()
{
    CATextLayer* _textLayer;
}
@end

@implementation MRLayoutTextItem

- (instancetype) init
{
    self = [super init];
    if (!self) {
        return self;
    }
    _fontSize = 13;
    _textColor = @"#323232";
    _backgroundColor = @"";
    return self;
}

- (void) prelayout
{
    _textLayer = [CATextLayer new];
}

- (void) setValue:(id)value forKey:(NSString *)key
{
    [super setValue:value forKey:key];
    if ([kTextItemText isEqualToString:key]) {
        _text = value;
    } else if ([key isEqualToString:kTextItemTextColor])
    {
        _textColor = value;
    } else if ([key isEqualToString:kTextItemFontSize])
    {
        _fontSize = [value floatValue];
    } else if ([key isEqualToString:kTextItemBackgroundColor]) {
        _backgroundColor = value;
    } else if ([key isEqualToString:kTextItemCornerRatio])
    {
        _cornerRediusRatio = [value floatValue];
    }
}

- (id) valueForKey:(NSString *)key
{

    if ([kTextItemText isEqualToString:key]) {
        return _text;
    } else if ([key isEqualToString:kTextItemTextColor])
    {
        return _textColor;
    } else if ([key isEqualToString:kTextItemFontSize])
    {
        return @(_fontSize);
    } else if ([key isEqualToString:kTextItemBackgroundColor]) {
        return _backgroundColor;
    } else if ([key isEqualToString:kTextItemCornerRatio])
    {
        return @(_cornerRediusRatio);
    }
    
    id value = [super valueForKey:key];
    if (value && ![value isKindOfClass:[NSNull class]]) {
        return value;
    }
    return [NSNull null];
}

- (NSDictionary*) toDictionary
{
    NSMutableDictionary* infos = [[super toDictionary] copy];
    NSDictionary* myInfos = [self dictionaryWithValuesForKeys:@[kTextItemCornerRatio, kTextItemBackgroundColor, kTextItemTextColor, kTextItemFontSize, kTextItemText]];
    [infos addEntriesFromDictionary:myInfos];
    return infos;
}

@end
