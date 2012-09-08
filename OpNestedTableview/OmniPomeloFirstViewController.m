//
//  OmniPomeloFirstViewController.m
//  OpNestedTableview
//
//  Created by wuxjim on 12-9-8.
//  Copyright (c) 2012年 wuxjim. All rights reserved.
//

#import "OmniPomeloFirstViewController.h"
#import "JSONKit.h"

@interface OmniPomeloFirstViewController ()

@end

@implementation OmniPomeloFirstViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		self.title = NSLocalizedString(@"First", @"First");
		self.tabBarItem.image = [UIImage imageNamed:@"first"];
    }
    return self;
}

-(void)downloadData
{
	NSString *testurl = @"http://223.4.93.92:8080/api/v2/matches/32/game_types/35";
	OpDataEngine *engine = [[OpDataEngine alloc] initWithHostName:nil customHeaderFields:nil];
	[engine dataFromURL:testurl onCompletion:^(NSArray *reslutArr) {
		DLog(@"download data sucess");
		JustTestDemo.dataArr = [reslutArr copy];
		[JustTestDemo reloadData];
	} onError:^(NSError *error) {
		DLog(@"error in downloading data");
	}];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
	 JustTestDemo = [[OpNestedTableView alloc] initWithFrame:self.view.bounds];

	[self.view addSubview:JustTestDemo];
	
	[self downloadData];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}



@end
