//
//  MRRemind.h
//  Pods
//
//  Created by baidu on 16/4/11.
//
//

#import <Foundation/Foundation.h>

@class MRInjectionView;
FOUNDATION_EXTERN id MRExtendViewRemindLogic(UIView* view, NSString* identifier);
FOUNDATION_EXTERN void MRExtendTabarItemRemindLogic(UITabBarItem* item , NSString* identifier);
FOUNDATION_EXTERN MRInjectionView* MRExternNavigationBarItemRemindLogic(UIBarButtonItem* item, NSString* identifier);
