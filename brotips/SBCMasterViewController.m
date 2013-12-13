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

//alternate background
#pragma mark UITableViewDelegate
- (void)tableView: (UITableView*)tableView
  willDisplayCell: (UITableViewCell*)cell
forRowAtIndexPath: (NSIndexPath*)indexPath
{
    if (indexPath.row % 2)
        cell.backgroundColor = [UIColor colorWithRed:0.0 green:0.4 blue:0.5 alpha:0.2];
    
    else
        cell.backgroundColor = [UIColor colorWithRed:0.8 green:0.0 blue:0.0 alpha:0.2];
    
    
    
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
    SBCCell* customCells = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    customCells.tipNum1.text = [currentTip tipNumber];
    customCells.tipContent.text = [currentTip content];
    
    customCells.tipImage.image = [UIImage imageNamed:@"brotip.png"];

    return customCells;
    

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

    
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];


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
