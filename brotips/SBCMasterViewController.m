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
#import "SWRevealViewController.h"

@interface SBCMasterViewController () {
    NSMutableArray *_objects;
}



@end

@implementation SBCMasterViewController

SBCParser *xmlParser;
UIImage	 *brotipLogo;
CGRect dateFrame;
UILabel *dateLabel;
NSString *cellContent;

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
    return [[xmlParser recentEntries] count];
}

#pragma mark UITableViewDelegate
- (void)tableView: (UITableView*)tableView
  willDisplayCell: (UITableViewCell*)cell
forRowAtIndexPath: (NSIndexPath*)indexPath
{
    //cell.backgroundColor = indexPath.row % 2
    //? [UIColor colorWithRed: 0.0 green: 0.0 blue: 0.8 alpha: 0.3]
    //: [UIColor whiteColor];
    //cell.textLabel.backgroundColor = [UIColor clearColor];
    //cell.detailTextLabel.backgroundColor = [UIColor clearColor];
    if (indexPath.row % 3 ==0)
        cell.backgroundColor = [UIColor colorWithRed:0.0 green:0.8 blue:0.0 alpha:0.3];
    
    else if(indexPath.row % 2)
        cell.backgroundColor = [UIColor colorWithRed:0.8 green:0.0 blue:0.0 alpha:0.3];
    else
        cell.backgroundColor = [UIColor whiteColor];
    
    
}

- (UIImage *)cellBackgroundForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSInteger rowCount = [self tableView:[self tableView] numberOfRowsInSection:0];
    //NSInteger rowIndex = indexPath.row;
    UIImage *background = nil;
    
    background = [UIImage imageNamed:@""];
    
    return background;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SBCBrotip *currentTip = [[xmlParser recentEntries] objectAtIndex:indexPath.row];
    cellContent = [currentTip content];
    CGSize maximumLabelSize = CGSizeMake(236,9999);
    CGSize expectedLabelSize = [cellContent sizeWithFont:[UIFont systemFontOfSize:15]constrainedToSize:maximumLabelSize lineBreakMode:UILineBreakModeCharacterWrap];
   // NSLog(@"%@",cellContent);
    //NSLog(@"%f",expectedLabelSize.height + 30);
	return MAX(75,expectedLabelSize.height + 30);
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // FYI: On IOS7 just use textContainerInset.top
    
    //SBCCell* customCells = [[SBCCell alloc] init];
    static NSString *CellIdentifier = @"customCell";
    SBCBrotip *currentTip = [[xmlParser recentEntries] objectAtIndex:indexPath.row];
    //NSString* cellContent1 = [currentTip content];
    SBCCell* customCells = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

   // if (customCells == nil){
        //customCells = [[SBCCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
        //UIImageView *tipImageView = (UIImageView *)[cell viewWithTag:100];
        //tipImageView.image = [UIImage imageNamed:@"brotip.png"];
        //self.tipLogo = [UIImage imageNamed:@"brotip.png"];
        //customCells.tipContent.
        customCells.tipNum1.text = [currentTip tipNumber];
        customCells.tipContent.text = [currentTip content];
    CGSize maximumLabelSize = CGSizeMake(236,9999);
        customCells.tipImage.image = [UIImage imageNamed:@"brotip.png"];
    CGSize expectedLabelSize = [customCells.tipContent.text sizeWithFont:[UIFont systemFontOfSize:15]
                          constrainedToSize:maximumLabelSize lineBreakMode:UILineBreakModeCharacterWrap];
    CGRect contentFrame = CGRectMake(7, 20, 265, expectedLabelSize.height);
    UILabel *contentLabel = [[UILabel alloc] initWithFrame:contentFrame];
    contentLabel.numberOfLines = 5;
    contentLabel.font = [UIFont boldSystemFontOfSize:14];
    contentLabel.backgroundColor = [UIColor clearColor];
    
    //UILabel *contentLabel = (UILabel *)[cell.contentView viewWithTag:0011];
    contentLabel.text = [currentTip content];
    //[customCells.contentView addSubview:contentLabel];
    
    //NSLog(@"%f",expectedLabelSize.height);
    
    //customCells.backgroundColor = indexPath.row % 2 ? [UIColor colorWithRed: 0.0 green: 0.0 blue: 1.0 alpha: 1.0]: [UIColor whiteColor];
    //customCells.backgroundColor = [UIColor redColor];
    
    //[customCells setBackgroundColor:[UIColor colorWithRed:.8 green:.8 blue:1 alpha:1]];
    
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
        SBCBrotip *currentTip = [[xmlParser recentEntries] objectAtIndex:indexPath.row];
        //NSDate *object = _objects[indexPath.row];
        [[segue destinationViewController] setDetailItem:currentTip];
    }
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    xmlParser = [[SBCParser alloc] loadXMLByURL:@"http://www.brotips.com/recent.atom"];
    brotipLogo = [UIImage imageNamed:@"brotip.png"];
     
    self.title = @"Recent";
    self.navigationItem.backBarButtonItem.title = @" ";

    
    UIImage *menuButtonImage = [UIImage imageNamed:@"menu.png"];
    UIButton *menuButton = [UIButton buttonWithType:UIButtonTypeCustom];
    menuButton.frame = CGRectMake(8.0f, 0.0f, menuButtonImage.size.width, menuButtonImage.size.height);
    [menuButton setImage:menuButtonImage forState:UIControlStateNormal];
    [menuButton addTarget:self.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *settingsView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, menuButton.frame.size.width + 5.0f, menuButton.frame.size.height)];
    settingsView.backgroundColor = [UIColor clearColor];
    [settingsView addSubview:menuButton];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:settingsView];
    //self.navigationItem.leftBarButtonItem.target = self.revealViewController;
   // self.navigationItem.leftBarButtonItem.action = @selector(revealToggle:);
    
//    _sidebarButton.tintColor = [UIColor colorWithWhite:0.96f alpha:0.1f];
//    
//    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
//    _sidebarButton.target = self.revealViewController;
//    _sidebarButton.action = @selector(revealToggle:);
    // Set the gesture
    
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];

    //[self.navigationController.navigationBar setBackgroundColor:[UIColor brownColor]];
    //[self.navigationController.navigationBar setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"navbar_bg.png"]]];
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
