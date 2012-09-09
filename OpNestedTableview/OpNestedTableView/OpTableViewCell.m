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
- (CGFloat)cellHeight
{
	#warning 动态cell高度使用，必须重载此函数,如果不使用动态 高度，重载并返回与heightforcell中相同的值
	NSLog(@"\n 必须在你的子类中重载此函数  \"%@\" ，否则 得不到正确的结果", NSStringFromSelector(_cmd));

	return 0;
}
@end
