//
//  OpTableViewHeaderCell.h
//  OpNestedTableview
//
//  Created by wuxjim on 12-9-8.
//  Copyright (c) 2012年 wuxjim. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kfArrowWith 40.0f
#define kfArrowHeight 40.0f

#define kfTitleFontSize 20.0f

#define kfBoarder 5.0f

#define ksBgviewImgKey @"bgImg"
#define ksTitleKey @"title"
/*
typedef enum
{
	OpTableViewHeaderCellStatusFolded,
	OpTableViewHeaderCellStatusUnFolded
}
OpTableViewHeaderCellStatus;
*/

#define OpTableViewHeaderCellStatusUnFolded YES
#define OpTableViewHeaderCellStatusFolded NO
@protocol OpTableviewDelegte;

@interface OpTableViewHeaderCell : UIView
{
	UIImageView *arrowView;
	UILabel *sectionTitle;
	UIImageView *backGroundView;
	UIButton *sectionButton;
}
@property(nonatomic,retain)UILabel *sectionTitle;
@property(nonatomic,assign)id<OpTableviewDelegte> delegate;
@property(nonatomic, readwrite)BOOL foldedstatus;
@property(nonatomic, readwrite)NSInteger sectionIndex;

-(void)changeBackGroundView:(UIImage*)bgImg;
-(void)confirgSection:(NSDictionary*)secDic;

@end


@protocol OpTableviewDelegte <NSObject>
@optional
-(void)SectionHasPressed:(OpTableViewHeaderCell*)sender;

@end