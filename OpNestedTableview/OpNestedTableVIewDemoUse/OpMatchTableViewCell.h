//
//  OpMatchTableViewCell.h
//  OpNestedTableview
//
//  Created by wuxjim on 12-9-8.
//  Copyright (c) 2012年 wuxjim. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "OpTableViewCell.h"

#define MaxScoreNum 7

#define Type_Singel @"single"
#define Type_Double @"double"
#define Type_Score2 @"2"
#define Type_Score3 @"3"
#define Type_Score4 @"4"
#define Type_Score5 @"5"
#define Type_originalCell @"cell"
#define Type_SectionCell @"sectionCell"


#define ksDataDicTypeKey @"typeKey"
#define ksDataDicContentKey @"contentKey"

typedef enum {
    //PublicCellTypeDiscusSubjectFisrt      = 1,      // 第一级话题，即一个文章下面的不同话题
    //PublicCellTypeDiscusSubjectSecond     = 1 << 1, // 第二级话题，即话题下的不同讨论
    //PublicCellTypeDiscusComment           = 1 << 2,  //评论级，即通常意义下的评论
    //PublicCellTypeSpecDisView             = 1<<3,    //在专栏中的cell类型。。某XB人物设计的结构与评论基本一致
    MatchScoreCellTypeSingle3         = 1 << 0,//末４位是局数，前４位为类型
    MatchScoreCellTypeDouble3         = 1 << 1,
    MatchScoreCellTypeSingle5         = 1 << 2,
    MatchScoreCellTypeDouble5         = 1 << 3,
    MatchScoreCellTypeSection         = 1 << 4
    
} MatchScoreCellType;

@interface OpMatchTableViewCell : OpTableViewCell {
    NSString *segType;
    NSString *cellType;
    
    UILabel *Player1, *Player1Score[MaxScoreNum];
    UILabel *Player2, *Player2Score[MaxScoreNum];
    UILabel *Player11;
    UILabel *Player22;
    UIImageView *dividLine;
    
    CGFloat cellHeight;
    CGRect cellSize;
}

@property (nonatomic, assign) CGRect cellSize;

//- (CGFloat)cellHeight;
//-(void)confirgCell:(NSDictionary*)cellInfo;

- (void)setCusData:(NSDictionary *)item andType:(NSString *)segtype;

@end
