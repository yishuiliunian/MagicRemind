//
//  MRLayoutNumberItem.h
//  Pods
//
//  Created by stonedong on 16/5/14.
//
//

#import "MRLayoutTextItem.h"
extern NSString* const kMRLayoutNumberType;
@interface MRLayoutNumberItem : MRLayoutTextItem
@property (nonatomic, strong) NSString* text NS_UNAVAILABLE;
@property (nonatomic, assign) int number;
@end
