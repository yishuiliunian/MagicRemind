//
//  MRItem.h
//  MagicRemind
//
//  Created by baidu on 15/11/5.
//  Copyright © 2015年 dzpqzb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MRItem : NSObject <NSCoding>
@property (nonatomic, assign) BOOL neeedUpdate;
@property (nonatomic, strong) NSString* identifier;
@property (nonatomic, assign, readonly) BOOL show;
@property (nonatomic, strong) NSArray* layoutItems;
@end
