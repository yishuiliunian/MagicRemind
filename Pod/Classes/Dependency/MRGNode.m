//
//  MRGNode.m
//  Pods
//
//  Created by stonedong on 16/4/17.
//
//

#import "MRGNode.h"

@implementation MRGNode

- (BOOL) isEqual:(MRGNode*)object
{
    if (![object isKindOfClass:[MRGNode class]]) {
        return NO;
    }
    if ([self.identifier isEqualToString:object.identifier]) {
        return YES;
    } else {
        return NO;
    }
}

- (NSString*) description
{
    return [NSString stringWithFormat:@"Node:#{%@}",self.identifier];
}
@end
