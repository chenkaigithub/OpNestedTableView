//
//  OpTableViewHeaderCell.m
//  OpNestedTableview
//
//  Created by wuxjim on 12-9-8.
//  Copyright (c) 2012年 wuxjim. All rights reserved.
//

#import "OpTableViewHeaderCell.h"
#import <QuartzCore/QuartzCore.h>
#define FLIP_ANIMATION_DURATION 0.18f


@interface OpTableViewHeaderCell (private)
-(void)buttonPressed;

@end

@implementation OpTableViewHeaderCell

@synthesize sectionTitle = _sectionTitle;
@synthesize delegate = _delegate;
@synthesize foldedstatus = _foldedstatus;
@synthesize sectionIndex;

-(id)initWithFrame:(CGRect)frame
{
	if (self = [super initWithFrame:frame]) {
		arrowView = [[UIImageView alloc] init];
		backGroundView = [[UIImageView alloc] init];
		_sectionTitle = [[UILabel alloc] init];
		_sectionTitle.font = [UIFont systemFontOfSize:kfTitleFontSize];
		_sectionTitle.numberOfLines = 1;
		sectionButton = [[UIButton alloc] init];
		[sectionButton setBackgroundColor:[UIColor clearColor]];
		[sectionButton addTarget:self action:@selector(buttonPressed) forControlEvents:UIControlEventTouchUpInside];
		//默认配置
		backGroundView.backgroundColor = [UIColor purpleColor];
		[arrowView setImage:[UIImage imageNamed:@"arrow.png"]];
		[CATransaction begin];
		[CATransaction setAnimationDuration:FLIP_ANIMATION_DURATION];
		arrowView.transform  = CGAffineTransformMakeRotation(M_PI/2);  // CATransform3DMakeRotation((M_PI / 180.0) * 180.0f, 0.0f, 0.0f, 1.0f);
		[CATransaction commit];
		_foldedstatus = OpTableViewHeaderCellStatusUnFolded;

	}
	return self;
}


-(void)buttonPressed
{
	if ([_delegate respondsToSelector:@selector(SectionHasPressed:)]) {
		[_delegate SectionHasPressed:self];
	}
}

-(void)layoutSubviews
{
	CGRect selfBounds= self.bounds;
	backGroundView.frame = selfBounds;
	sectionButton.frame = selfBounds;
	
	CGFloat topDistence = (selfBounds.size.height - kfArrowHeight)/2;
	arrowView.frame = CGRectMake(topDistence, topDistence, kfArrowWith, kfArrowHeight);
	
	CGFloat titleXoffset = topDistence+kfBoarder+kfArrowWith;
	_sectionTitle.frame = CGRectMake(titleXoffset , topDistence, selfBounds.size.width - titleXoffset - kfBoarder , kfArrowHeight);
	
	[self addSubview:backGroundView];
	[self addSubview:arrowView];
	[self addSubview:_sectionTitle];
	[self addSubview:sectionButton];
	[self bringSubviewToFront:sectionButton];
}


-(void)changeBackGroundView:(UIImage*)bgImg
{
	[backGroundView setImage:bgImg];
}

-(void)confirgSection:(NSDictionary*)secDic
{
	if (secDic == nil) {//set default section
		[self changeBackGroundView:nil];
		[self setBackgroundColor:[UIColor whiteColor]];
		_sectionTitle.text = @"加载中";
		return;
	}
	//subclass请自己重载些函数
	UIImage *backImg = [secDic objectForKey:ksBgviewImgKey];
	if (backImg != nil) {
		[self changeBackGroundView:backImg];
	}
	
	NSString *titleText = [secDic objectForKey:ksTitleKey];
	//如果要重置title请传入@"",否则不更改此项
	if(titleText != nil)
		_sectionTitle.text = titleText;
}

-(void)setFoldedstatus:(BOOL)foldedstatus
{
	//change arrow direction
	NSLog(@"change arrdirection");
	_foldedstatus = foldedstatus;
	CGFloat rotePi = 0;
	if (_foldedstatus == OpTableViewHeaderCellStatusUnFolded) {
		rotePi = M_PI/2;
	}
	
	[CATransaction begin];
	[CATransaction setAnimationDuration:FLIP_ANIMATION_DURATION];
	arrowView.transform  = CGAffineTransformMakeRotation(rotePi);  // CATransform3DMakeRotation((M_PI / 180.0) * 180.0f, 0.0f, 0.0f, 1.0f);
	[CATransaction commit];
}

@end
