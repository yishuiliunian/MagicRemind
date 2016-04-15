//
//  MRDependencyReleation.m
//  Pods
//
//  Created by baidu on 16/4/13.
//
//

#import "MRDependencyReleation.h"
#import "MRGraphic.hpp"

@interface MRDependencyReleation ()
{
    MagicRecord::MRGraphic _graphic;
}
@end


@implementation MRDependencyReleation

- (void) addDependency:(NSString*)father child:(NSString*)child
{
    _graphic.insertArc(father.UTF8String, child.UTF8String);
    
}
@end
