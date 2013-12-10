//
//  SBCDetailViewController.m
//  brotips
//
//  Created by Sanket Chauhan on 12/8/13.
//  Copyright (c) 2013 Sanket Chauhan. All rights reserved.
//

#import "SBCDetailViewController.h"
#import "SBCBrotip.h"

@interface SBCDetailViewController ()
- (void)configureView;
@property (weak, nonatomic) IBOutlet UILabel *tipNumber;
@end

@implementation SBCDetailViewController

NSURL *shareURL;
#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.
    SBCBrotip *currentTip = self.detailItem;
    if (self.detailItem) {
        self.detailDescriptionLabel.text = [currentTip content];
        self.tipNumber.text = [currentTip tipNumber];
        shareURL = [[NSURL alloc]initFileURLWithPath:currentTip.linkTag];
        //NSLog(@"%@",shareURL);
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@" "
                                   style:UIBarButtonItemStyleBordered
                                   target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backButton];
    
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sendText:(id)sender {
    if ([MFMessageComposeViewController canSendText]) {
        MFMessageComposeViewController *textSheet = [[MFMessageComposeViewController alloc ]init];
        textSheet.messageComposeDelegate = self;
        [textSheet setBody:self.detailDescriptionLabel.text];
        [self presentViewController:textSheet animated:YES completion:nil];
        
    }
    else{
        NSString *message = @"Texting isn't supported";
        UIAlertView *alertSMS = [[UIAlertView alloc] initWithTitle:@"Error" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alertSMS show];
    }
}

-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{
    NSString *output = nil;
    
    switch (result) {
        case MessageComposeResultSent:
            output = @"Message Sent Successfully!";
            
            break;
            
        case MessageComposeResultCancelled:
            output = @"Message wasn't sent";
            break;
            
        case MessageComposeResultFailed:
            output = @"Error Sending Message";
            break;
            
        default:
            break;
    }
    
    UIAlertView *status = [[UIAlertView alloc] initWithTitle:@"Result" message:output delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [status show];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

@end
