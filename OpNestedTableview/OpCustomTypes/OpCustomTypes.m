//
//  OpNSDictionary.m
//  iTennisForiPhone
//
//  Created by wuxjim on 12-7-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//


#import "OpCustomTypes.h"

@implementation  NSMutableDictionary(OpCustomType)

//if use this fuction, please check the data stucture in yourself

-(NSMutableDictionary*)replaceNSNullWithString:(BOOL *)erplaeced
{/*
	BOOL tt = NO;
	[self test:&tt];
	if (tt) {
		DLog(@"Changed YES");
	}
	else {
		DLog(@"cannot Changed");
	}
	*/
	
	
	NSMutableDictionary * const m = [self mutableCopy];    
	//NSString * const empty = @"replace";
	id const nul = [NSNull null];
	NSArray * const keys = [m allKeys];
	BOOL hasReplaced = NO;
	
	for (NSUInteger idx = 0, count = [keys count]; idx < count; ++idx) {
		id const key = [keys safeObjectAtIndex:idx];
		id const obj = [m objectForKey:key];
		
		if ([obj isKindOfClass:[NSDictionary class]]) {
			NSMutableDictionary *dic = [(NSDictionary*)obj mutableCopy];
			BOOL subHasReplaced = NO;
			NSMutableDictionary *new = [dic replaceNSNullWithString:&subHasReplaced];
			if(subHasReplaced)
			{
				[m setObject:new forKey:key];
				hasReplaced = YES;

				}
			//continue;

		}
		
		else if ([obj isKindOfClass:[NSArray class]]) {
			NSMutableArray *arr = [(NSArray*)obj mutableCopy];
			BOOL subHasReplaced = NO;
			NSMutableArray *new = [arr replaceNSNullWithString:&subHasReplaced];
			
			if(subHasReplaced)
			{
				[m setObject:new forKey:key];
				hasReplaced = YES;
				
			}
			//continue;
		}
		
		else if (nul == obj) {
			[m setObject:rePlacedFromNull forKey:key]; 
			hasReplaced = YES;
			//continue;
		}
		
	}
	
	*erplaeced = hasReplaced;
	
	return hasReplaced? [m copy]:self;
}

-(id)safeObjectForKey:(id)aKey
{
	id ori = [self objectForKey:aKey];
	if ([ori isKindOfClass:[NSString class]]) {
		if ([rePlacedFromNull isEqualToString:ori]) {
			return nil;
		}
	}
	return ori;
	
}
@end

@implementation NSDictionary(OpCustomType)
//if use this fuction, please check the data stucture in yourself

-(NSDictionary*)replaceNSNullWithString:(BOOL *)erplaeced
{
	return [[self mutableCopy] replaceNSNullWithString:erplaeced];
}

-(id)safeObjectForKey:(id)aKey
{
	id ori = [self objectForKey:aKey];
	if ([ori isKindOfClass:[NSString class]]) {
		if ([rePlacedFromNull isEqualToString:ori]) {
			return nil;
		}
	}
	return ori;
	
}

@end


@implementation NSMutableArray(OpCustomType)

-(NSMutableArray*)replaceNSNullWithString:(BOOL *)erplaeced
{
	NSMutableArray * const m = self;    
	
	//NSString * const empty = @"replaces aar";
	
	id const nul = [NSNull null];
	BOOL replaced = NO;
	
	for (NSUInteger idx = 0, count = [m count]; idx < count; ++idx) {
		id const obj = [m safeObjectAtIndex:idx];
		if (nul == obj) {
			[m replaceObjectAtIndex:idx withObject:rePlacedFromNull]; 
			replaced = YES;
		}
		
		else if ([obj isKindOfClass:[NSDictionary class]]) {
			NSMutableDictionary *dic = [(NSDictionary*)obj mutableCopy];
			BOOL subHasReplaced = NO;
			NSMutableDictionary *new= [dic replaceNSNullWithString:&subHasReplaced];
			if (subHasReplaced) {
				[m replaceObjectAtIndex:idx withObject:new];
				replaced = YES;
			}
		}
		
		else if ([obj isKindOfClass:[NSArray class]]) {
			NSMutableArray *arr = [(NSArray*)obj mutableCopy];
			BOOL subHasReplaced = NO;
			NSMutableArray *new = [arr replaceNSNullWithString:&subHasReplaced];
			if (subHasReplaced) {
				[m replaceObjectAtIndex:idx withObject:new];
				replaced = YES;
			}
		}
	}
	*erplaeced = replaced;
	return replaced?[m copy]:self;
}

-(id)safeObjectAtIndex:(NSUInteger)index
{
	if (index >= self.count) {
		return nil;
	}
	
	id ori = [self objectAtIndex:index];
	if ([ori isKindOfClass:[NSString class]]) {
		if ([rePlacedFromNull isEqualToString:ori]) {
			return nil;
		}
	}
	return ori;
}

@end

@implementation NSArray(OpCustomType)

-(NSArray*)replaceNSNullWithString:(BOOL *)erplaeced
{
	NSArray *d = [self mutableCopy];
	return [d replaceNSNullWithString:erplaeced];
}

-(id)safeObjectAtIndex:(NSUInteger)index
{
	if (index >= self.count) {
		return nil;
	}
	
	id ori = [self objectAtIndex:index];
	if ([ori isKindOfClass:[NSString class]]) {
		if ([rePlacedFromNull isEqualToString:ori]) {
			return nil;
		}
	}
	return ori;
}
@end



@implementation OpCustomTypes

@end
