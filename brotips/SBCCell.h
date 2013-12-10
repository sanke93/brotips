//
//  SBCCell.h
//  brotips
//
//  Created by ITP Student on 12/9/13.
//  Copyright (c) 2013 Sanket Chauhan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SBCCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIImageView *tipImage;
@property (weak, nonatomic) IBOutlet UILabel *tipContent;
@property (weak, nonatomic) IBOutlet UILabel *tipNum1;

@end
