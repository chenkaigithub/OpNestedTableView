//
//  OpNestedTableView.h
//  OpNestedTableview
//
//  Created by wuxjim on 12-9-8.
//  Copyright (c) 2012年 wuxjim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OpTableViewHeaderCell.h"
#import "OpMatchTableViewCell.h"

#define ksSectionDicKey @"title" // change with you ownkey words
#define ksRowArrKey @"cell"


#define ksCellStackHeaderKey @"header"
#define ksCellStackRowArrKey @"rows"


#define kfSectionHeight 50.0f
#define kfMaxRowHeight 100.0f

@interface OpNestedTableView : UITableView <OpTableviewDelegte,UITableViewDataSource,UITableViewDelegate>
{
	NSMutableArray *cell2Stack;
	/*cellstack data structure
	 [
		 {
			 ksCellStackHeaderKey: sectionheader
			 ksCellStackRowArrKey: [
								 row1,
								 row2,
								 row3
								 ]
		 },
		 {
			......
		 },
		 .........
	 ]
	 */
	 
	 BOOL reloadAll;
}

@property(nonatomic,retain)NSArray *dataArr;
/*cellstack data structure
 [
	 {
		 ksSectionDicKey: {sec}
		 ksRowArrKey: [
							 {
								cellkey:XX
								cellkey2:XX
								
							 },
							......
						 ]
	 },
	 {
	 ......
	 },
	 .........
 ]
 */

@end
