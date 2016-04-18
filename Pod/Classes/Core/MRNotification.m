//
//  MRNotification.m
//  Pods
//
//  Created by stonedong on 16/4/17.
//
//

#import "MRNotification.h"


NSString* MRNotificationKey(NSString* identifier) {
    return [NSString stringWithFormat:@"MagicRemind-%@",identifier];
}