//
//  MRRemind.m
//  Pods
//
//  Created by baidu on 16/4/11.
//
//

#import "MRRemind.h"
#import "MRExtendClass.h"
#import "MRInjectionView.h"
MRInjectionView*  MRExtendViewRemindLogic(UIView* view, NSString* identifier)
{
    
    void(^BuildBridge)(void) = ^(void) {
        MRInjectionView* injectionView = (MRInjectionView*)view;
        if (injectionView.magicRemindBridge == nil ||
            ![injectionView.magicRemindBridge.identifier isEqualToString:identifier]) {
            MRUIBridge* brigde = [[MRUIBridge alloc] initWithIdentifier:identifier];
            brigde.layoutView = view;
            injectionView.magicRemindBridge = brigde;
        }
    };

    if ([view respondsToSelector:@selector(magicRemindBridge)]) {
        BuildBridge();
    } else {
        MRExtendInstanceLogic(view, @[[MRInjectionView class]]);
        BuildBridge();
    }
    return view;
}


void MRExtendTabarItemRemindLogic(UITabBarItem* item , NSString* identifier) {
    UIView* tabView = [item valueForKey:@"_view"];
    UIView* aimView = nil;
    for (UIView* subView in tabView.subviews) {
        if ([subView isKindOfClass:NSClassFromString(@"UITabBarSwappableImageView")]) {
            aimView = subView;
        }
    }
    if (aimView) {
        MRExtendViewRemindLogic(aimView, identifier);
        if ([aimView respondsToSelector:@selector(xBadgeMargin)] && [aimView respondsToSelector:@selector(yBadgeMargin)]) {
            MRInjectionView* injectionView = (MRInjectionView*)aimView;
            injectionView.xBadgeMargin = 0.5;
        }
    }
}

MRInjectionView*  MRExternNavigationBarItemRemindLogic(UIBarButtonItem* item, NSString* identifier) {
    UIView* tabView = [item valueForKey:@"_view"];
    if (tabView) {
        MRExtendViewRemindLogic(tabView, identifier);
    }
    if ([tabView respondsToSelector:@selector(magicRemindBridge)]) {
        [tabView setNeedsLayout];
        return tabView;
    }
    return nil;
}


