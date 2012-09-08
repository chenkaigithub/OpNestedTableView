//
//  OpTableViewCell.m
//  OpNestedTableview
//
//  Created by wuxjim on 12-9-8.
//  Copyright (c) 2012年 wuxjim. All rights reserved.
//

#import "OpTableViewCell.h"

@implementation OpTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)confirgCell:(NSDictionary*)cellInfo
{
	#warning 必须重载此函数
	NSLog(@"\n 必须在你的子类中重载此函数  \"%@\" ，否则 得不到正确的结果", NSStringFromSelector(_cmd));
}
@end
