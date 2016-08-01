//
//  MRDependencyReleation.m
//  Pods
//
//  Created by baidu on 16/4/13.
//
//

#import "MRDependencyReleation.h"
#import "MRGraph.h"
#import "MRStorage.h"
#import "MRItem.h"
#import "MRGNode.h"
@interface MRDependencyReleation () <MRStatesProtocol>
{
    MRGraph* _graphic;
}
@end


@implementation MRDependencyReleation
+ (MRDependencyReleation*) shareManager
{
    static MRDependencyReleation* share = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        share = [MRDependencyReleation new];
    });
    return share;
}
- (instancetype) init
{
    self = [super init];
    if (!self) {
        return self;
    }
    _graphic = [MRGraph new];
    return self;
}
- (void) addDependency:(NSString*)father child:(NSString*)child
{
    [_graphic insertArcWithHeader:father tailer:child];
}

- (BOOL) isExistCircleDependency
{
    BOOL exist =  [_graphic checkCircle];
    NSAssert(!exist, @"it exist circle dependency please remove it");
    return exist;
}


- (void) storage:(MRStorage *)storage willChangeItem:(MRItem *)item showState:(BOOL)aimState
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        NSArray* nodes =[_graphic allLinkInterNodes:item.identifier];
        for (MRGNode* node in nodes) {
            NSArray* allDenp = [_graphic allLinkOuterNodes:node.identifier];
            MRItem* item = nil;
            for (MRGNode* childNode in allDenp) {
                MRItem* joinedItem = [storage itemWithIdentifier:childNode.identifier];
                if (!joinedItem) {
                    continue;
                }
                item = [joinedItem joinWithItem:item];
            }
            item.identifier = node.identifier;
            if (item) {
                [[MRStorage shareStorage] updateItem:item];
            } else {
                [[MRStorage shareStorage] hiddenRemind:node.identifier];
            }
        }
    });

}
@end
