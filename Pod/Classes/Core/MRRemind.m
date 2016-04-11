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
BOOL MRExtendViewRemindLogic(UIView* view, NSString* identifier)
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
}

