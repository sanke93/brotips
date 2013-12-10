//
//  SBCBrotips.h
//  brotips
//
//  Created by Sanket Chauhan on 12/8/13.
//  Copyright (c) 2013 Sanket Chauhan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SBCBrotip : NSObject

@property (strong, nonatomic)NSString *entry;
@property  (strong,nonatomic)NSString *content;
@property (strong,nonatomic)NSString *tipNumber;
@property (strong,nonatomic)NSMutableString *linkTag;
@property (strong,nonatomic)NSURL *link;

@end
