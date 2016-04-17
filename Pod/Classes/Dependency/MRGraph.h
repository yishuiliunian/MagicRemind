//
//  MRGraph.h
//  Pods
//
//  Created by stonedong on 16/4/17.
//
//

#import <Foundation/Foundation.h>

@class MRGArc;
@interface MRGraph : NSObject
- (MRGArc*) insertArcWithHeader:(NSString*)hi tailer:(NSString*)ti;
- (BOOL) checkCircle;
- (NSArray*) allLinkInterNodes:(NSString*)identifier;
- (NSArray*) allLinkOuterNodes:(NSString*)identifer;
@end
