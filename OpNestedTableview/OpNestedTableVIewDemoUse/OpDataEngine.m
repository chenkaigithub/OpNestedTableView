//
//  OpDataEngine.m
//  OpNestedTableview
//
//  Created by wuxjim on 12-9-8.
//  Copyright (c) 2012年 wuxjim. All rights reserved.
//

#import "OpDataEngine.h"
#import "JSONKit.h"

@implementation OpDataEngine 
-(MKNetworkOperation*) dataFromURL:(NSString*)urlstr
					  onCompletion:(CurrencyResponseBlock) completionBlock
						   onError:(MKNKErrorBlock) errorBlock {
    
    MKNetworkOperation *op = [self operationWithURLString:urlstr];
    
    [op onCompletion:^(MKNetworkOperation *completedOperation)
     {
	 //just test ..use your own data geter
	 
	 
	 NSString *valueString = [completedOperation responseString];
	 
	 NSDictionary *resultDic = [valueString objectFromJSONString];
	 
	 NSArray *resultArr = [resultDic objectForKey:@"content"];
	 if([completedOperation isCachedResponse]) {
		 DLog(@"Data from cache %@", [completedOperation responseJSON]);
	 }
	 else {
		 DLog(@"Data from server %@", [completedOperation responseString]);
	 }
	 
	 completionBlock(resultArr);
	 
     }onError:^(NSError* error) {
         
         errorBlock(error);
     }];
    
    [self enqueueOperation:op];
    
    return op;
}
@end
