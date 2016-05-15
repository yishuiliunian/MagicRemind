//
//  MRGraph.m
//  Pods
//
//  Created by stonedong on 16/4/17.
//
//

#import "MRGraph.h"
#import "MRGArc.h"
#import "MRGNode.h"
@interface MRGraph()
{
    NSMutableArray* _nodes;
}
@end
@implementation MRGraph

- (instancetype) init
{
    self = [super init];
    if (!self) {
        return self;
    }
    _nodes = [NSMutableArray new];
    return self;
}

- (NSArray*) allLinkOuterNodes:(NSString*)identifer
{
    NSMutableArray * array = [NSMutableArray new];
    MRGNode* node = [self nodeWithIdentifier:identifer];
    for (MRGArc* arc = node.firstOut; arc != nil; arc = arc.outNextLink) {
        [array addObject:arc.tailer];
    }
    return array;
}

- (NSArray*) allLinkInterNodes:(NSString*)identifier
{
    NSMutableArray * array = [NSMutableArray new];
    MRGNode* node = [self nodeWithIdentifier:identifier];
    for (MRGArc* arc = node.firstIn; arc != nil; arc = arc.inNextLink) {
        [array addObject:arc.header];
    }
    return array;
}
- (MRGNode*) nodeWithIdentifier:(NSString*)identifier
{
    for (MRGNode* node in _nodes) {
        if ([node.identifier isEqualToString:identifier]) {
            return node;
        }
    }
    return nil;
}
- (MRGNode*) insertNode:(NSString*)identifier
{
    for (MRGNode* node in _nodes) {
        if ([node.identifier isEqualToString:identifier]) {
            return node;
        }
    }
    MRGNode* node = [MRGNode new];
    node.identifier = identifier;
    [_nodes addObject:node];
    return node;
}

- (BOOL) isNodeExist:(NSString*)identifier {
    for (MRGNode* node in _nodes) {
        if ([node.identifier isEqualToString:identifier]) {
            return YES;
        }
    }
    return NO;
}

- (MRGArc*) insertArcWithHeader:(NSString*)hi tailer:(NSString*)ti
{
    MRGNode* hNode =[self insertNode:hi];
    MRGNode* tNode =[self insertNode:ti];
    
    for (MRGArc* arc = hNode.firstOut; arc; arc = arc.outNextLink) {
        if ([arc.tailer isEqual:tNode]) {
            return arc;
        }
    }
    
    MRGArc* arc = [MRGArc new];
    arc.header = hNode;
    arc.tailer = tNode;
    
    arc.outNextLink = hNode.firstOut;
    hNode.firstOut = arc;
    
    arc.inNextLink= tNode.firstIn;
    tNode.firstIn = arc;
    return arc;
}

- (BOOL) checkCircle:(NSString*)identifier fathers:(NSMutableArray*)fathers visit:(NSMutableArray*)visit
{
    MRGNode* node = [self nodeWithIdentifier:identifier];
    if (!node) {
        return NO;
    }
    [visit addObject:node];
    [fathers addObject:node];
    for (MRGArc* arc = node.firstOut; arc != nil; arc = arc.outNextLink) {
        if ([visit containsObject:arc.tailer]) {
            [fathers addObject:arc.tailer];
            return YES;
        } else {
            [visit addObject:arc.tailer];
        }
    }
    return NO;
}

- (BOOL) checkCircle
{
    NSMutableArray* fathers = [NSMutableArray new];
    NSMutableArray* visit = [NSMutableArray new];
    
    for (MRGNode* node in _nodes) {
        if ([self checkCircle:node.identifier fathers:fathers visit:visit]) {
            NSLog(@"%@", fathers);
            return YES;
        }
    }
    
    return NO;
}

@end
