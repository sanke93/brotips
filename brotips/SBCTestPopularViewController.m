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
#import "SBCDetailViewController.h"
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

//to alternate the background
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail1"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        SBCBrotip *currentTip = [[xmlParser popularEntries] objectAtIndex:indexPath.row];
        //NSDate *object = _objects[indexPath.row];
        [[segue destinationViewController] setDetailItem:currentTip];
    }
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

//sets the cell view height according to the label size. 
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
    SBCBrotip *currentTip = [[xmlParser popularEntries] objectAtIndex:indexPath.row];
    //NSString* cellContent1 = [currentTip content];
    SBCCell* customCells = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    customCells.tipNum1.text = [currentTip tipNumber];
    customCells.tipContent.text = [currentTip content];
    CGSize maximumLabelSize = CGSizeMake(236,9999);
    customCells.tipImage.image = [UIImage imageNamed:@"brotip.png"];
    return customCells;

}



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
