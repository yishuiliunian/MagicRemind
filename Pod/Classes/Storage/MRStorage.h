//
//  MRStorage.h
//  MagicRemind
//
//  Created by baidu on 15/11/5.
//  Copyright © 2015年 dzpqzb. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MRItem;
@interface MRStorage : NSObject
+ (MRStorage*) shareStorage;
- (MRItem*) itemWithIdentifier:(NSString*)identifier;
- (void) updateRemindWithPoint:(NSString*)identifier;
- (void) updateRemind:(NSString*)identifier number:(int)number;
- (void) updateRemind:(NSString*)identifier text:(NSString*)text;


- (void) hiddenRemind:(NSString*)identifier;
@end
