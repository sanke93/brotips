//
//  SBCSubmitViewController.m
//  brotips
//
//  Created by Sanket Chauhan on 12/12/13.
//  Copyright (c) 2013 Sanket Chauhan. All rights reserved.
//

#import "SBCSubmitViewController.h"
#import "SWRevealViewController.h"

@interface SBCSubmitViewController ()

- (void)configureView;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation SBCSubmitViewController

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
    
    self.navigationItem.leftBarButtonItem.title = @"Back";
    self.webView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
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
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    [self.activityIndicator startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [self.activityIndicator stopAnimating];
}

- (void)configureView
{
    // Update the user interface for the detail item.
    NSURL *url = [NSURL URLWithString:@"http://www.brotips.com/user-tips/new"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    //NSLog(@"%@",url);
    [self.webView loadRequest:request];
    self.navigationItem.title = @"Submit";
    
    
    
}

@end
