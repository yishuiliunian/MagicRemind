//
//  MRItem.h
//  MagicRemind
//
//  Created by baidu on 15/11/5.
//  Copyright © 2015年 dzpqzb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MRItem : NSObject
@property (nonatomic, assign, readonly) BOOL neeedUpdate;
@property (nonatomic, strong) NSString* identifier;
@property (nonatomic, assign) BOOL show;
@property (nonatomic, strong) NSArray* layoutItems;
- (void) setNeeedUpdate:(BOOL)neeedUpdate;
@end
