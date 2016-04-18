//
//  MRDependencyReleation.h
//  Pods
//
//  Created by baidu on 16/4/13.
//
//

#import <Foundation/Foundation.h>

@interface MRDependencyReleation : NSObject
+ (MRDependencyReleation*) shareManager;
- (instancetype) initWithMap:(NSDictionary*)ship;


- (void) addDependency:(NSString*)father child:(NSString*)child;

/**
 *  check is there any circle dendency
 *
 *  @return if exist return yes(and assertion crash), otherwise return no
 */
- (BOOL) isExistCircleDependency;
@end
