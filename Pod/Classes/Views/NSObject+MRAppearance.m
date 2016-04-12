//
//  NSObject+MRAppearance.m
//  Pods
//
//  Created by baidu on 16/4/11.
//
//

#import "NSObject+MRAppearance.h"
#import <objc/runtime.h>
static void* kMRAppearanceFont = &kMRAppearanceFont;
static void* kMRAppearanceColor =  &kMRAppearanceColor;
@implementation NSObject (MRAppearance)
- (void) setMR_badgeColor:(UIColor *)MR_badgeColor
{
    objc_setAssociatedObject(self, kMRAppearanceColor, MR_badgeColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor*) MR_badgeColor
{
    return objc_getAssociatedObject(self, kMRAppearanceColor);
}

- (void) setMR_badgeFont:(UIFont *)MR_badgeFont
{
    objc_setAssociatedObject(self, kMRAppearanceFont, MR_badgeFont, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIFont*) MR_badgeFont
{
    return objc_getAssociatedObject(self, kMRAppearanceFont);
}

@end
