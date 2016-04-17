//
//  MRGNode.h
//  Pods
//
//  Created by stonedong on 16/4/17.
//
//

#import <Foundation/Foundation.h>

@class MRGArc;
@interface MRGNode : NSObject
@property (nonatomic, strong) NSString* identifier;
@property (nonatomic, strong) MRGArc* firstIn;
@property (nonatomic, strong) MRGArc* firstOut;
@end
