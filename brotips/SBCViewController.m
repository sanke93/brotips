//
//  SBCViewController.m
//  brotips
//
//  Created by Sanket Chauhan on 12/8/13.
//  Copyright (c) 2013 Sanket Chauhan. All rights reserved.
//

#import "SBCViewController.h"
#import "SBCParser.h"

@interface SBCViewController ()

@end

@implementation SBCViewController

SBCParser *xmlParser;
UIImage	 *brotipLogo;
CGRect dateFrame;
UILabel *dateLabel;
CGRect contentFrame;
UILabel *contentLabel;


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[xmlParser entries] count];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
	SBCBrotip *currentTip = [[xmlParser entries] objectAtIndex:indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
        UIImage	 *brotipLogo = [UIImage imageNamed:@"brotip.png"];
        
        CGRect imageFrame = CGRectMake(2, 1, 62, 20);
        self.customImage = [[UIImageView alloc] initWithFrame:imageFrame];
        self.customImage.image = brotipLogo;
        [cell.contentView addSubview:self.customImage];
        
        //CGRect contentFrame = CGRectMake(45, 2, 265, 30);
        //float x,float y, width, heigh
        CGRect contentFrame = CGRectMake(5, 20, 310,50);
        UILabel *contentLabel = [[UILabel alloc] initWithFrame:contentFrame];
        contentLabel.tag = 0011;
        contentLabel.numberOfLines = 5;
        contentLabel.font = [UIFont boldSystemFontOfSize:14];
        [cell.contentView addSubview:contentLabel];
        
        CGRect tipNumberFrame = CGRectMake(65, 1, 265, 20);
        UILabel *tipNumberLabel = [[UILabel alloc] initWithFrame:tipNumberFrame];
        tipNumberLabel.tag = 0012;
        tipNumberLabel.font = [UIFont systemFontOfSize:22];
        [cell.contentView addSubview:tipNumberLabel];
    }
	
	UILabel *contentLabel = (UILabel *)[cell.contentView viewWithTag:0011];
    contentLabel.text = [currentTip content];
	
	UILabel *dateLabel = (UILabel *)[cell.contentView viewWithTag:0012];
    dateLabel.text = [currentTip tipNumber];
	
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 90;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    xmlParser = [[SBCParser alloc] loadXMLByURL:@"http://www.brotips.com/recent.atom"];
    brotipLogo = [UIImage imageNamed:@"brotip.png"];
    
    self.title = @"Recent";
}


- (void)viewDidUnload
{
    [self setRecentTableView:nil];
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
