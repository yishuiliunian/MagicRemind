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
@end
