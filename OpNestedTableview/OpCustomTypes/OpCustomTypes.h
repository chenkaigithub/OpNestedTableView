//
//  OpNSDictionary.h
//  iTennisForiPhone
//
//  Created by wuxjim on 12-7-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

static const NSString *rePlacedFromNull = @"NullReplaced";

@interface NSMutableDictionary(OpCustomType)

-(NSMutableDictionary*)replaceNSNullWithString:(BOOL *)erplaeced;
-(id)safeObjectForKey:(id)aKey;

@end

@interface NSDictionary(OpCustomType)

-(NSDictionary*)replaceNSNullWithString:(BOOL *)erplaeced;
-(id)safeObjectForKey:(id)aKey;

@end



@interface NSMutableArray(OpCustomType)

-(NSMutableArray*)replaceNSNullWithString:(BOOL *)erplaeced;
-(id)safeObjectAtIndex:(NSUInteger)index;
@end

@interface NSArray(OpCustomType)

-(NSArray*)replaceNSNullWithString:(BOOL *)erplaeced;
-(id)safeObjectAtIndex:(NSUInteger)index;

@end



@interface OpCustomTypes : NSObject

@end
