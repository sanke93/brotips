//
//  SBCMasterViewController.m
//  brotips
//
//  Created by Sanket Chauhan on 12/8/13.
//  Copyright (c) 2013 Sanket Chauhan. All rights reserved.
//

#import "SBCMasterViewController.h"

#import "SBCDetailViewController.h"
#import "SBCParser.h"
#import "SBCCell.h"

@interface SBCMasterViewController () {
    NSMutableArray *_objects;
}

@end

@implementation SBCMasterViewController

SBCParser *xmlParser;
UIImage	 *brotipLogo;
CGRect dateFrame;
UILabel *dateLabel;
CGRect contentFrame;
UILabel *contentLabel;

- (void)awakeFromNib
{
    [super awakeFromNib];
}





//- (void)insertNewObject:(id)sender
//{
//    if (!_objects) {
//        _objects = [[NSMutableArray alloc] init];
//    }
//    [_objects insertObject:[NSDate date] atIndex:0];
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
//    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
//}

#pragma mark - Table View

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
    //SBCCell* customCells = [[SBCCell alloc] init];
    static NSString *CellIdentifier = @"customCell";
    SBCCell* customCells = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    SBCBrotip *currentTip = [[xmlParser entries] objectAtIndex:indexPath.row];
   // if (customCells == nil){
        //customCells = [[SBCCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
        //UIImageView *tipImageView = (UIImageView *)[cell viewWithTag:100];
        //tipImageView.image = [UIImage imageNamed:@"brotip.png"];
        //self.tipLogo = [UIImage imageNamed:@"brotip.png"];
        customCells.tipNum1.text = [currentTip tipNumber];
    customCells.tipContent.text = [currentTip content];
    customCells.tipImage.image = [UIImage imageNamed:@"brotip.png"];
    
      //UILabel *tipNumber = (UILabel *)[cell viewWithTag:101];
        //tipNumber.text = [currentTip tipNumber];
    
        //UILabel *tipText = (UILabel *)[cell viewWithTag:102];
        //tipText.text = [currentTip content];
    //}
//    
//
//    
    return customCells;
    
//    static NSString *CellIdentifier = @"Cell";
//	SBCBrotip *currentTip = [[xmlParser entries] objectAtIndex:indexPath.row];
//    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (cell == nil)
//    {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
//        
//        UIImage	 *brotipLogo = [UIImage imageNamed:@"brotip.png"];
//        
//        CGRect imageFrame = CGRectMake(2, 1, 62, 20);
//        self.customImage = [[UIImageView alloc] initWithFrame:imageFrame];
//        self.customImage.image = brotipLogo;
//        [cell.contentView addSubview:self.customImage];
//        
//        //CGRect contentFrame = CGRectMake(45, 2, 265, 30);
//        //float x,float y, width, heigh
//        CGRect contentFrame = CGRectMake(5, 20, 310,50);
//        UILabel *contentLabel = [[UILabel alloc] initWithFrame:contentFrame];
//        contentLabel.tag = 0011;
//        contentLabel.numberOfLines = 5;
//        contentLabel.font = [UIFont boldSystemFontOfSize:14];
//        [cell.contentView addSubview:contentLabel];
//        
//        CGRect tipNumberFrame = CGRectMake(65, 1, 265, 20);
//        UILabel *tipNumberLabel = [[UILabel alloc] initWithFrame:tipNumberFrame];
//        tipNumberLabel.tag = 0012;
//        tipNumberLabel.font = [UIFont systemFontOfSize:22];
//        [cell.contentView addSubview:tipNumberLabel];
//    }
//	
//	UILabel *contentLabel = (UILabel *)[cell.contentView viewWithTag:0011];
//    contentLabel.text = [currentTip content];
//	
//	UILabel *dateLabel = (UILabel *)[cell.contentView viewWithTag:0012];
//    dateLabel.text = [currentTip tipNumber];
//	
//    return cell;
//
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        //NSDate *object = _objects[indexPath.row];
        //[[segue destinationViewController] setDetailItem:object];
    }
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    xmlParser = [[SBCParser alloc] loadXMLByURL:@"http://www.brotips.com/recent.atom"];
    brotipLogo = [UIImage imageNamed:@"brotip.png"];
    
    self.title = @"Recent";
//    self.navigationItem.leftBarButtonItem = self.editButtonItem;
//    
//    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
//    self.navigationItem.rightBarButtonItem = addButton;
}




- (void)viewDidUnload
{
    [self setTableView:nil];
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
