//
//  OpDataEngine.h
//  OpNestedTableview
//
//  Created by wuxjim on 12-9-8.
//  Copyright (c) 2012年 wuxjim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MKNetworkKit.h"


typedef void (^CurrencyResponseBlock)(NSArray* reslutArr);


@interface OpDataEngine : MKNetworkEngine


-(MKNetworkOperation*) dataFromURL:(NSString*)urlstr
					  onCompletion:(CurrencyResponseBlock) completionBlock
						   onError:(MKNKErrorBlock) errorBlock;
@end
