//
//  OpNestedTableView.m
//  OpNestedTableview
//
//  Created by wuxjim on 12-9-8.
//  Copyright (c) 2012年 wuxjim. All rights reserved.
//

#import "OpNestedTableView.h"
#import "OpCustomTypes.h"

static NSString *CellIdentifier = @"OpCellIndentifier";

@implementation OpNestedTableView

@synthesize dataArr;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
		cell2Stack	= [[NSMutableArray alloc] init];
		self.delegate = self;
		self.dataSource = self;
		reloadAll = YES;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
	NSInteger sectionCount = [dataArr count]+1;//默认一个用于提示正在 加载的内容,同时多出一个来解决最后一个section在
	//折叠时可能发生重影的BUG
    /*if ([dataArr count] > 1)
	{
        sectionCount = [dataArr count];
    }*/
	//reload时重新加载缓存
	if (reloadAll) {
	DLog(@"reload all");
		[cell2Stack removeAllObjects];
		cell2Stack = nil;
		cell2Stack = [[NSMutableArray alloc] initWithCapacity:sectionCount];
		for (NSInteger row=0; row<sectionCount; row++) {
			[cell2Stack addObject:rePlacedFromNull];
		}
	}
	
    return sectionCount;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	if (section >= [dataArr count]) {
		return 0;//默认的最后一个section
	}
   NSDictionary* subSecDataDic = [dataArr safeObjectAtIndex:section];
	NSArray *subCellData = [subSecDataDic objectForKey:ksRowArrKey];
	if (subCellData.count > 0) {
		//构建stack data structure
		NSMutableDictionary *secStack =nil;

		if (!reloadAll) {
			NSMutableDictionary *secStack = [cell2Stack safeObjectAtIndex:section];
			OpTableViewHeaderCell *header = [secStack objectForKey:ksCellStackHeaderKey];
			if (header != nil) {
				if (header.foldedstatus == OpTableViewHeaderCellStatusFolded) {
					return 1;
				}
			}
			
		}
		secStack = [[NSMutableDictionary alloc] init];
		NSMutableArray *rowStack = [[NSMutableArray alloc] initWithCapacity:subCellData.count];
		//初始化。否则后面寻址会出错
		for (NSInteger row=0; row<subCellData.count; row++) {
			[rowStack addObject:rePlacedFromNull];
		}
		
		[secStack setObject:rowStack forKey:ksCellStackRowArrKey];
		[cell2Stack replaceObjectAtIndex:section withObject:secStack];
	}
	return subCellData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	CGFloat sectionHeight = kfSectionHeight;
	if (section>=dataArr.count && dataArr.count > 0) {
		sectionHeight = kfMaxRowHeight;
	}
	 return  sectionHeight;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	
	
	NSMutableDictionary *secStack = [cell2Stack safeObjectAtIndex:section];
	OpTableViewHeaderCell *header = [secStack objectForKey:ksCellStackHeaderKey];
	if (header == nil) {
	
		
		//config header
		
		NSDictionary* subSecDataDic = nil;

		if (section >= [dataArr count]) {
			if (dataArr.count > 0) {
				UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, kfSectionHeight)];
				whiteView.backgroundColor = [UIColor whiteColor];
				return whiteView;
			}
			//否则传入nil 得到 默认的样式
	
		}
		else
		{
			subSecDataDic = [dataArr safeObjectAtIndex:section];
		}
		
		header = [[OpTableViewHeaderCell alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width,kfSectionHeight)];
		header.delegate = self;
		header.sectionIndex = section;
		[header confirgSection:subSecDataDic];
		
		//add to stack
		if (secStack == nil) {
			NSLog(@"wrong in programe");
			secStack = [[NSMutableDictionary alloc] init];
		}
		
		
		[secStack setObject:header forKey:ksCellStackHeaderKey];
	}
	return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    	
	if (indexPath.section >= [dataArr count]) {
		return 0;//默认的最后一个section
	}
	NSMutableDictionary *secStack = [cell2Stack safeObjectAtIndex:indexPath.section];

	NSMutableArray *rowStack = [secStack objectForKey:ksCellStackRowArrKey];
	
	if (rowStack == nil) {
		NSLog(@"programe wrong wrong !1");
		return 0;
	}
	
	OpMatchTableViewCell *cell = [rowStack safeObjectAtIndex:indexPath.row];
	if (!reloadAll) {
		OpTableViewHeaderCell *header = [secStack objectForKey:ksCellStackHeaderKey];
		if (header != nil) {
			if (header.foldedstatus == OpTableViewHeaderCellStatusFolded) {
				return 0;
			}
		}
		
	}
    if (cell == nil  ) {
	
		//config cell
       cell = [[OpMatchTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
		
		//get data
		NSDictionary* subSecDataDic = [dataArr safeObjectAtIndex:indexPath.section];
		NSArray *subCellData = [subSecDataDic objectForKey:ksRowArrKey];
		//config
		NSDictionary *oriDic = [subCellData safeObjectAtIndex:indexPath.row];
		NSDictionary *finaldic = [NSDictionary dictionaryWithObjectsAndKeys:oriDic,ksDataDicContentKey,
																			@"single",ksDataDicTypeKey, nil];
        [cell confirgCell:finaldic];
		
		//add to stack
		[rowStack replaceObjectAtIndex:indexPath.row withObject:cell];
    }
    //DLog(@"cell height is %f", cell.cellHeight);
    return [cell cellHeight];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	
	NSMutableDictionary *secStack = [cell2Stack safeObjectAtIndex:indexPath.section];
	
	NSMutableArray *rowStack = [secStack objectForKey:ksCellStackRowArrKey];
	
	OpMatchTableViewCell *cell =nil;
	
	if (indexPath.section >= [dataArr count]) {
		//默认的最后一个section
		if (dataArr.count <= 0) {
			static NSString *LoadingCellIdentifier =@"加载中";
			cell = [[OpMatchTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:LoadingCellIdentifier];
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
			[cell confirgCell:nil];
			
		}
		else
		{
			cell = (OpMatchTableViewCell*)[[UITableViewCell alloc]  initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"defalut"];
			[cell setBackgroundColor:[UIColor whiteColor]];
		}
		//add to stack
		[rowStack replaceObjectAtIndex:indexPath.row withObject:cell];
		return cell;
	}
    
    
	
	cell = [rowStack safeObjectAtIndex:indexPath.row];
	
	//下面的代码理应不要的。。因为stack里已经 有了。。不过保险还是加上。。可以尝试删除
    if (cell == nil  ) {
		
		//config cell
		cell = [[OpMatchTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
		
		//get data
		NSDictionary* subSecDataDic = [dataArr safeObjectAtIndex:indexPath.section];
		NSArray *subCellData = [subSecDataDic objectForKey:ksRowArrKey];
		//config
        [cell confirgCell:[subCellData safeObjectAtIndex:indexPath.row]];
		
		//add to stack
		[rowStack replaceObjectAtIndex:indexPath.row withObject:cell];
    }

    return cell;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}
#pragma OptableviewcellHeaderDelegate
-(void)SectionHasPressed:(OpTableViewHeaderCell *)sender
{
	sender.foldedstatus = !sender.foldedstatus;
	NSLog(@"button pressed!");
	reloadAll = NO;
	
	NSIndexPath *oriIndex = [NSIndexPath indexPathForRow:0 inSection:0];
	[self reloadData];
	[self beginUpdates];
	[self scrollToRowAtIndexPath:oriIndex atScrollPosition:UITableViewScrollPositionTop animated:YES];
	[self endUpdates];
	reloadAll = YES;
}

@end
