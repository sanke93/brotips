//
//  SBCTestPopularViewController.m
//  brotips
//
//  Created by Sanket Chauhan on 12/12/13.
//  Copyright (c) 2013 Sanket Chauhan. All rights reserved.
//

#import "SBCTestPopularViewController.h"
#import "SWRevealViewController.h"
#import "SBCPopularParser.h"
#import "SBCCell.h"
#import "SBCBrotip.h"

@interface SBCTestPopularViewController ()

@end

@implementation SBCTestPopularViewController

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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
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
    
   // self.navigationItem.leftBarButtonItem.title = @"Back";
   
    //    _sidebarButton.target = self.revealViewController;
    //    _sidebarButton.action = @selector(revealToggle:);
    //    _sidebarButton.tintColor = [UIColor colorWithWhite:0.96f alpha:0.2f];
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload
{
    [self setTableView:nil];
    [super viewDidUnload];
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SBCBrotip *currentTip = [[xmlParser popularEntries] objectAtIndex:indexPath.row];
    cellContent = [currentTip content];
    CGSize maximumLabelSize = CGSizeMake(236,9999);
    CGSize expectedLabelSize = [cellContent sizeWithFont:[UIFont systemFontOfSize:15]constrainedToSize:maximumLabelSize lineBreakMode:UILineBreakModeCharacterWrap];
    // NSLog(@"%@",cellContent);
    //NSLog(@"%f",expectedLabelSize.height + 30);
	return MAX(75,expectedLabelSize.height + 30);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"customCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
   
    // Configure the cell...
    
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
