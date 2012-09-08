//
//  OpMatchTableViewCell.m
//  OpNestedTableview
//
//  Created by wuxjim on 12-9-8.
//  Copyright (c) 2012年 wuxjim. All rights reserved.
//

#import "OpMatchTableViewCell.h"
#import "OpCustomTypes.h"

#define Boarder 6.0f
#define NameHeight 20.0f
#define NameWidth 115.0f
#define SingleHeight 58.0f
#define DoubleHeight 116.0f
#define SectionHeight 60.0f

#define systemFont @"Helvetica"
#define systemFontBold @"Helvetica-Bold"

#define systemFontLargeSize 22
#define systemFontMiddleSize 18
#define systemFontMiddleSize2 16
#define systemFontSmallSize 12
#define kJsonType @"category"
#define kJsonTitle @"title"
#define kJsonSubTitle @"description"
///#pragma kjsonMatchScore
#define kJsonScoreTitle @"title"
#define kJsonScoreInfo @"info"
#define kJsonScoreLink @"url"
#define kJsonScoreSegType @"segType"
#define kJsonScoreCellContent @"content"
//#define kJsonSecCell @"cell"
#define kJsonScorePlayer1 @"a"
#define kJsonScorePlayer2 @"b"
#define kJsonScoreCellType @"type"
#define kJsonScoreName @"players"
#define kJsonScorePlayerScore @"scores"
#define kJsonScorePlayerScoreResult @"result"
#define kJsonScorePlayerScoreDetail @"total"


@implementation OpMatchTableViewCell
@synthesize cellSize;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        Player1 = [[UILabel alloc] init];
        Player1.frame =CGRectZero;
        Player1.font = [UIFont fontWithName:systemFont size:systemFontMiddleSize2];
		
        
        Player11 = [[UILabel alloc] init];
        Player11.frame = CGRectZero;
        Player11.font = [UIFont fontWithName:systemFont size:systemFontMiddleSize2];
		
        
        Player2 = [[UILabel alloc] init];
        Player2.frame =CGRectZero;
        Player2.font = [UIFont fontWithName:systemFont size:systemFontMiddleSize2];
		
        
        Player22 = [[UILabel alloc] init];
        Player22.frame = CGRectZero;
        Player22.font = [UIFont fontWithName:systemFont size:systemFontMiddleSize2];
		
        
        for (NSInteger i = 0; i < MaxScoreNum; i++) {
            Player1Score[i] = [[UILabel alloc] init];
            Player1Score[i].frame = CGRectZero;
            Player1Score[i].textAlignment = UITextAlignmentCenter;
            Player1Score[i].font = [UIFont fontWithName:systemFont size:systemFontMiddleSize2];
            
            Player2Score[i] = [[UILabel alloc] init];
            Player2Score[i].frame = CGRectZero;
            Player2Score[i].textAlignment = UITextAlignmentCenter;
            Player2Score[i].font = [UIFont fontWithName:systemFont size:systemFontMiddleSize2];
            
            [self.contentView addSubview:Player1Score[i]];
            [self.contentView addSubview:Player2Score[i]];
        }
        
        [Player1Score[1] setBackgroundColor:[UIColor grayColor]];
        [Player2Score[1] setBackgroundColor:[UIColor grayColor]];
        Player1Score[0].font = [UIFont fontWithName:systemFont size:10];
        Player2Score[0].font = [UIFont fontWithName:systemFont size:10];
		
        cellHeight = SingleHeight;
		
        dividLine = [[UIImageView alloc] initWithFrame:CGRectZero];
        [dividLine setImage:[UIImage imageNamed:@"div_line_s.png"]];
		
        
        [self.contentView addSubview:Player1];
        [self.contentView addSubview:Player11];
        [self.contentView addSubview:Player2];
        [self.contentView addSubview:Player22];
        [self.contentView addSubview:dividLine];
        
    }
    return self;
}

- (CGFloat)cellHeight
{
    return cellHeight;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect nameFrame;
    CGRect scoreFrame1,scoreFrame2;
    CGFloat scoreAddHeight = 0.0f;
    //CGFloat scoreY = 0.0f;
    if (Player1.text == NULL) {
		// Player1.text = [NSString stringWithString:@"加载中,请稍候..."];
        //Player1.frame = CGRectMake(0, 10, 290, 20);
        cellHeight = 30;
        return;
    }
    
    Player1.font = [UIFont fontWithName:systemFont size:systemFontMiddleSize2];
    Player1.textColor = [UIColor blackColor];
	
    Player2.font = [UIFont fontWithName:systemFont size:systemFontMiddleSize2];
    
    //DLog(@"type is %@", segType);
    
    if (segType == Type_Singel) {
        nameFrame = CGRectMake(0.0f, Boarder, NameWidth, NameHeight);
        Player1.frame = nameFrame;
        nameFrame.origin.y += (NameHeight+Boarder);
        Player2.frame = nameFrame;
        
        scoreAddHeight = nameFrame.origin.y - Boarder/2;
		
        //dividLine.frame =  CGRectMake(0.0f, 20.0f, 310.0f, 1.0f);
    }
    else {
        nameFrame = CGRectMake(0.0f, Boarder, NameWidth, NameHeight);
        Player1.frame = nameFrame;
        nameFrame.origin.y += (NameHeight+Boarder);
        Player11.frame = nameFrame;
        
        dividLine.frame =  CGRectMake(0.0f, nameFrame.origin.y+ nameFrame.size.height+Boarder, 130.0f, 1.0f);
		
        nameFrame.origin.y += (NameHeight+2*Boarder);;
        Player2.frame = nameFrame;
        nameFrame.origin.y += (NameHeight+Boarder);;
        Player22.frame = nameFrame;
        
        scoreAddHeight = dividLine.frame.origin.y;
        //scoreY = 16;
    }
    
    //NSLog(@"type is, %@", cellType);
    
    if (cellType == Type_SectionCell) {
		
        CGSize titleSize = [Player1.text sizeWithFont: [UIFont fontWithName:systemFont size:systemFontMiddleSize]  constrainedToSize:CGSizeMake(MAXFLOAT, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
		
        nameFrame =CGRectMake(0.0f, 10.0f, titleSize.width, 18.0f);
        Player1.frame = nameFrame;
        Player1.font = [UIFont fontWithName:systemFont size:systemFontMiddleSize];
        Player1.textColor = [UIColor greenColor];
        
        nameFrame.origin.x +=titleSize.width;
        nameFrame.size.width = self.frame.size.width - nameFrame.origin.x;
        Player2.frame = nameFrame;
        Player2.font = [UIFont fontWithName:systemFont size:systemFontMiddleSize2];
    }
    else if (cellType == Type_Score5) {
        
        scoreFrame1 = CGRectMake(110.0f, 0, 18.0f, scoreAddHeight);
        scoreFrame2 = scoreFrame1;
        scoreFrame2.origin.y +=scoreAddHeight;
        
        for (NSInteger i = 0; i < 2; i++) {
            Player1Score[i].frame = scoreFrame1;
            Player2Score[i].frame = scoreFrame2;
            
            scoreFrame1.origin.x += 26.0f;
            scoreFrame2.origin.x += 26.0f;
        }
        scoreFrame1.size.width = 26;
        scoreFrame2.size.width = 26;
        for (NSInteger i = 2; i < MaxScoreNum; i++) {
            Player1Score[i].frame = scoreFrame1;
            Player2Score[i].frame = scoreFrame2;
            
            scoreFrame1.origin.x += 26.0f;
            scoreFrame2.origin.x += 26.0f;
        }
    }
    else if (cellType == Type_Score3 || cellType == Type_Score2) {
        
        scoreFrame1 = CGRectMake(110.0f, 0.0f, 18.0f, scoreAddHeight);
        scoreFrame2 = scoreFrame1;
        scoreFrame2.origin.y +=scoreAddHeight;
        
        for (NSInteger i = 0; i < 2; i++) {
            Player1Score[i].frame = scoreFrame1;
            Player2Score[i].frame = scoreFrame2;
            
            scoreFrame1.origin.x += 26.0f;
            scoreFrame2.origin.x += 26.0f;
        }
        scoreFrame1.size.width = 26;
        scoreFrame2.size.width = 26;
        for (NSInteger i = 2; i < 5; i++) {
            Player1Score[i].frame = scoreFrame1;
            Player2Score[i].frame = scoreFrame2;
            
            scoreFrame1.origin.x += 51.0f;
            scoreFrame2.origin.x += 51.0f;
        }
    }
    else if (cellType == Type_Score4) {
        scoreFrame1 = CGRectMake(110.0f, 0.0f, 18.0f, scoreAddHeight);
        scoreFrame2 = scoreFrame1;
        scoreFrame2.origin.y +=scoreAddHeight;
        
        for (NSInteger i = 0; i < 2; i++) {
            Player1Score[i].frame = scoreFrame1;
            Player2Score[i].frame = scoreFrame2;
            
            scoreFrame1.origin.x +=26.0f;
            scoreFrame2.origin.x +=26.0f;
        }
        scoreFrame1.size.width = 26;
        scoreFrame2.size.width = 26;
        for (NSInteger i = 2; i < 6; i++) {
            Player1Score[i].frame = scoreFrame1;
            Player2Score[i].frame = scoreFrame2;
            
            scoreFrame1.origin.x += 36.0f;
            scoreFrame2.origin.x += 36.0f;
        }
    }
}

- (void)reSizeCell
{
	[self layoutSubviews];
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
	[super willMoveToSuperview:newSuperview];
	
	if(!newSuperview) {
	}
}

- (void)setDefaultCell
{
	
	Player1.text =NULL;
	//date.text = ddate;
	//author.text = dtype;
}
-(void)confirgCell:(NSDictionary*)cellInfo;
{
	NSString *segtype = [cellInfo objectForKey:ksDataDicTypeKey];
	NSDictionary *segContentDic = [cellInfo objectForKey:ksDataDicContentKey];
	[self setCusData:segContentDic andType:segtype];
}

- (void)setCusData:(NSDictionary *)item andType:(NSString *)segtype
{
    if (item == nil) {
		[self setDefaultCell];
		return ;
	}
	
    if (segtype == nil) {
        NSArray *playersName = [[item objectForKey:kJsonScorePlayer1] objectForKey:kJsonScoreName];
        if (playersName.count >1) {
            segtype = Type_Double;
        }
        else {
            segtype = Type_Singel;
        }
    }
    
    segType = segtype;
    
    
    if (segType ==Type_Singel) {
        cellHeight = SingleHeight;
    }
    else {
        cellHeight = DoubleHeight;
    }
    
    //DLog(@"type is %@",segType);
	
    cellType = [item objectForKey:kJsonScoreCellType];
    if ([cellType isEqualToString:Type_SectionCell]) {
		
        Player1.text = [item objectForKey:kJsonTitle]==nil ? @"":[item objectForKey:kJsonScoreTitle];
        Player2.text = [item objectForKey:kJsonSubTitle]==nil ? @"":[item objectForKey:kJsonScoreInfo];
        
        cellHeight = SectionHeight;
    }
    else {
        NSDictionary *player1Info = [item objectForKey:kJsonScorePlayer1];
        NSDictionary *player2Info = [item objectForKey:kJsonScorePlayer2];
		
        NSArray *name1 = [player1Info objectForKey:kJsonScoreName];
        NSArray *name2 = [player2Info objectForKey:kJsonScoreName];
		
        if (name1.count > 0) {
			
            Player1.text = [name1 safeObjectAtIndex:0]==nil ? @"":[name1 safeObjectAtIndex:0];
            //DLog(@"play1 is %@", Player1.text);
        }
        if (name1.count >1) {
            Player11.text = [name1 safeObjectAtIndex:1]==nil ? @"":[name1 safeObjectAtIndex:1];
        }
        
        if (name2.count > 0) {
            Player2.text = [name2 safeObjectAtIndex:0]==nil ? @"":[name2 safeObjectAtIndex:0];
        }
        
        if (name2.count >1) {
            Player22.text = [name2 safeObjectAtIndex:1]==nil ? @"":[name2 safeObjectAtIndex:1];
        }
        
        NSDictionary *player1Score = [player1Info objectForKey:kJsonScorePlayerScore];
        NSArray *player1detailScore =  [player1Score objectForKey:kJsonScorePlayerScoreDetail];
        
        //NSLog(@"Score Count:%i", player1detailScore.count);
        
        /*
		 if (player1detailScore.count <= 5) {//根据分数数组的大小自动识别是几局制
		 cellType = Type_Score3;
		 }
		 else {
		 cellType = Type_Score5;
		 }*/
        if (player1detailScore.count == 3) {
            cellType = Type_Score2;
        }
        else if (player1detailScore.count == 4) {
            cellType = Type_Score3;
        }
        else if (player1detailScore.count ==5) {
            cellType = Type_Score4;
        }
        else if (player1detailScore.count == 6) {
            cellType = Type_Score5;
        }
        
        Player1Score[0].text = [player1Score objectForKey:kJsonScorePlayerScoreResult];
        
        for (NSInteger i = 1; i<MaxScoreNum && i<=player1detailScore.count; i++) {
            Player1Score[i].text = [player1detailScore safeObjectAtIndex:i-1];
        }
        
        NSDictionary *player2Score = [player2Info objectForKey:kJsonScorePlayerScore];
        NSArray *player2detailScore =  [player2Score objectForKey:kJsonScorePlayerScoreDetail];
		
        Player2Score[0].text = [player2Score objectForKey:kJsonScorePlayerScoreResult];
		
        for (NSInteger i = 1; i<MaxScoreNum && i<=player2detailScore.count; i++) {
            Player2Score[i].text = [player2detailScore safeObjectAtIndex:i-1];
        }
        
        //cellHeight = 100;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
	
    // Configure the view for the selected state
}

@end

