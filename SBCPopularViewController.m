//
//  SBCPopularViewController.m
//  brotips
//
//  Created by Sanket Chauhan on 12/10/13.
//  Copyright (c) 2013 Sanket Chauhan. All rights reserved.
//

#import "SBCPopularViewController.h"

#import "SBCDetailViewController.h"
#import "SBCPopularParser.h"
#import "SBCCell.h"
#import "SWRevealViewController.h"
#import "SBCBrotip.h"

@interface SBCPopularViewController ()

@end

@implementation SBCPopularViewController

SBCPopularParser *xmlParser;
UIImage	 *brotipLogo;
CGRect dateFrame;
UILabel *dateLabel;
NSString *cellContent;

CGRect contentFrame;
UILabel *contentLabel;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    xmlParser = [[SBCPopularParser alloc] loadXMLByURL:@"http://www.brotips.com/popular.atom"];
    brotipLogo = [UIImage imageNamed:@"brotip.png"];
    
    self.title = @"Popular";
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return [[xmlParser popularEntries] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}

//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    // FYI: On IOS7 just use textContainerInset.top
//    
//    //SBCCell* customCells = [[SBCCell alloc] init];
//    static NSString *CellIdentifier = @"customCell";
//    SBCBrotip *currentTip = [[xmlParser popularEntries] objectAtIndex:indexPath.row];
//    //NSString* cellContent1 = [currentTip content];
//    SBCCell* customCells = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    
//    // if (customCells == nil){
//    //customCells = [[SBCCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//    
//    //UIImageView *tipImageView = (UIImageView *)[cell viewWithTag:100];
//    //tipImageView.image = [UIImage imageNamed:@"brotip.png"];
//    //self.tipLogo = [UIImage imageNamed:@"brotip.png"];
//    //customCells.tipContent.
//    customCells.tipNum1.text = [currentTip tipNumber];
//    customCells.tipContent.text = [currentTip content];
//    CGSize maximumLabelSize = CGSizeMake(236,9999);
//    customCells.tipImage.image = [UIImage imageNamed:@"brotip.png"];
//    CGSize expectedLabelSize = [customCells.tipContent.text sizeWithFont:[UIFont systemFontOfSize:15]
//                                                       constrainedToSize:maximumLabelSize lineBreakMode:UILineBreakModeCharacterWrap];
//    CGRect contentFrame = CGRectMake(7, 20, 265, expectedLabelSize.height);
//    UILabel *contentLabel = [[UILabel alloc] initWithFrame:contentFrame];
//    contentLabel.numberOfLines = 5;
//    contentLabel.font = [UIFont boldSystemFontOfSize:14];
//    contentLabel.backgroundColor = [UIColor clearColor];
//    
//    //UILabel *contentLabel = (UILabel *)[cell.contentView viewWithTag:0011];
//    contentLabel.text = [currentTip content];
//    //[customCells.contentView addSubview:contentLabel];
//    
//    //NSLog(@"%f",expectedLabelSize.height);
//    
//    //customCells.backgroundColor = indexPath.row % 2 ? [UIColor colorWithRed: 0.0 green: 0.0 blue: 1.0 alpha: 1.0]: [UIColor whiteColor];
//    //customCells.backgroundColor = [UIColor redColor];
//    
//    //[customCells setBackgroundColor:[UIColor colorWithRed:.8 green:.8 blue:1 alpha:1]];
//    
//    //UILabel *tipNumber = (UILabel *)[cell viewWithTag:101];
//    //tipNumber.text = [currentTip tipNumber];
//    
//    //UILabel *tipText = (UILabel *)[cell viewWithTag:102];
//    //tipText.text = [currentTip content];
//    //}
//    //
//    //
//    //
//    return customCells;
//    
//    //    static NSString *CellIdentifier = @"Cell";
//    //	SBCBrotip *currentTip = [[xmlParser entries] objectAtIndex:indexPath.row];
//    //
//    //    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    //    if (cell == nil)
//    //    {
//    //        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
//    //
//    //        UIImage	 *brotipLogo = [UIImage imageNamed:@"brotip.png"];
//    //
//    //        CGRect imageFrame = CGRectMake(2, 1, 62, 20);
//    //        self.customImage = [[UIImageView alloc] initWithFrame:imageFrame];
//    //        self.customImage.image = brotipLogo;
//    //        [cell.contentView addSubview:self.customImage];
//    //
//    //        //CGRect contentFrame = CGRectMake(45, 2, 265, 30);
//    //        //float x,float y, width, heigh
//    //        CGRect contentFrame = CGRectMake(5, 20, 310,50);
//    //        UILabel *contentLabel = [[UILabel alloc] initWithFrame:contentFrame];
//    //        contentLabel.tag = 0011;
//    //        contentLabel.numberOfLines = 5;
//    //        contentLabel.font = [UIFont boldSystemFontOfSize:14];
//    //        [cell.contentView addSubview:contentLabel];
//    //
//    //        CGRect tipNumberFrame = CGRectMake(65, 1, 265, 20);
//    //        UILabel *tipNumberLabel = [[UILabel alloc] initWithFrame:tipNumberFrame];
//    //        tipNumberLabel.tag = 0012;
//    //        tipNumberLabel.font = [UIFont systemFontOfSize:22];
//    //        [cell.contentView addSubview:tipNumberLabel];
//    //    }
//    //
//    //	UILabel *contentLabel = (UILabel *)[cell.contentView viewWithTag:0011];
//    //    contentLabel.text = [currentTip content];
//    //
//    //	UILabel *dateLabel = (UILabel *)[cell.contentView viewWithTag:0012];
//    //    dateLabel.text = [currentTip tipNumber];
//    //	
//    //    return cell;
//    //
//}

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
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
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

@end
