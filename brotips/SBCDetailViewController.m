//
//  SBCDetailViewController.m
//  brotips
//
//  Created by Sanket Chauhan on 12/8/13.
//  Copyright (c) 2013 Sanket Chauhan. All rights reserved.
//

#import "SBCDetailViewController.h"
#import "SBCBrotip.h"
#import "FacebookSDK/FacebookSDK.h"
#import "Social/SLComposeViewController.h"
#import "Social/SLServiceTypes.h"
#import <Social/Social.h>

@interface SBCDetailViewController ()
- (void)configureView;
@property (weak, nonatomic) IBOutlet UILabel *tipNumber;
@end

@implementation SBCDetailViewController

NSURL *shareURL;
NSString *linkURL;
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

    SBCBrotip *currentTip = self.detailItem;
    if (self.detailItem) {
        self.detailDescriptionLabel.text = [currentTip content];
        self.tipNumber.text = [currentTip tipNumber];
        linkURL = [currentTip linkTag];
        //shareURL = [[NSURL alloc]initFileURLWithPath:currentTip.linkTag];
        //NSLog(@"%@",currentTip.linkTag);
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

- (NSDictionary*)parseURLParams:(NSString *)query {
    NSArray *pairs = [query componentsSeparatedByString:@"&"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    for (NSString *pair in pairs) {
        NSArray *kv = [pair componentsSeparatedByString:@"="];
        NSString *val =
        [kv[1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        params[kv[0]] = val;
    }
    return params;
}

//taken from the facebook site

- (IBAction)fbShare:(id)sender {
    

    BOOL displayedNativeDialog = [FBNativeDialogs
                                  presentShareDialogModallyFrom:self
                                  initialText:self.detailDescriptionLabel.text
                                  image:nil
                                  url:[NSURL URLWithString:linkURL]
                                  handler:^(FBNativeDialogResult result, NSError *error) {
                                      
                                      NSString *alertText = @"";
                                      if ([[error userInfo][FBErrorDialogReasonKey] isEqualToString:FBErrorDialogNotSupported]) {
                                          alertText = @"iOS Share Sheet not supported.";
                                      } else if (error) {
                                          alertText = [NSString stringWithFormat:@"error: domain = %@, code = %d", error.domain, error.code];
                                      } else if (result == FBNativeDialogResultSucceeded) {
                                          alertText = @"Posted successfully.";
                                      }
                                      
                                      if (![alertText isEqualToString:@""]) {
                                          // Show the result in an alert
                                          [[[UIAlertView alloc] initWithTitle:@"Result"
                                                                      message:alertText
                                                                     delegate:self
                                                            cancelButtonTitle:@"OK!"
                                                         otherButtonTitles:nil]
                                           show];
                                      }
                                  }];
    if (!displayedNativeDialog) {
        /*
         Fallback to web-based Feed dialog:
         https://developers.facebook.com/docs/howtos/feed-dialog-using-ios-sdk/
         */
        
        NSMutableDictionary *params =
        [NSMutableDictionary dictionaryWithObjectsAndKeys:
         @"Brotips App", @"name",
         @"Brotip", @"caption",
         self.detailDescriptionLabel.text, @"description",
         linkURL, @"link",
         
         nil];
        
        // Invoke the dialog
        [FBWebDialogs presentFeedDialogModallyWithSession:nil
                                               parameters:params
                                                  handler:
         ^(FBWebDialogResult result, NSURL *resultURL, NSError *error) {
             if (error) {
                 // Error launching the dialog or publishing a story.
                 NSLog(@"Error publishing story.");
             } else {
                 if (result == FBWebDialogResultDialogNotCompleted) {
                     // User clicked the "x" icon
                     NSLog(@"User canceled story publishing.");
                 } else {
                     // Handle the publish feed callback
                     NSDictionary *urlParams = [self parseURLParams:[resultURL query]];
                     if (![urlParams valueForKey:@"post_id"]) {
                         // User clicked the Cancel button
                         NSLog(@"User canceled story publishing.");
                     } else {
                         // User clicked the Share button
                         NSString *msg = [NSString stringWithFormat:
                                          @"Posted story, id: %@",
                                          [urlParams valueForKey:@"post_id"]];
                         NSLog(@"%@", msg);
                         // Show the result in an alert
                         [[[UIAlertView alloc] initWithTitle:@"Result"
                                                     message:msg
                                                    delegate:nil
                                           cancelButtonTitle:@"OK!"
                                           otherButtonTitles:nil]
                          show];
                     }
                 }
             }
         }];
    }
}

//twitter sharing code inspired by http://tutorials.veasoftware.com/2013/07/19/how-to-use-ios-facebook-and-twitter-integration/

- (IBAction)tweetShare:(id)sender {

    
    NSMutableString *initialText = [[NSMutableString alloc] initWithString:self.detailDescriptionLabel.text];
    
    [initialText appendString:[NSString stringWithFormat:@" #brotip"]];
     
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *tweetSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        [tweetSheet setInitialText:initialText];
        [self presentViewController:tweetSheet animated:YES completion:nil];
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Sorry"
                                  message:@"You can't send a tweet right now, make sure your device has an internet connection and you have at least one Twitter account setup"
                                  delegate:self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        [alertView show];
    }
    
}

//texting code
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
