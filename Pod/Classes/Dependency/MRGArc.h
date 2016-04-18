//
//  MRGArc.h
//  Pods
//
//  Created by stonedong on 16/4/17.
//
//

#import <Foundation/Foundation.h>

@class MRGNode;
@interface MRGArc : NSObject
@property (nonatomic, weak) MRGNode* header;
@property (nonatomic, weak) MRGNode* tailer;
@property (nonatomic, strong) MRGArc* inNextLink;
@property (nonatomic, weak) MRGArc* outNextLink;
@end
