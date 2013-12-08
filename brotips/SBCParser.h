//
//  SBCParser.h
//  brotips
//
//  Created by Sanket Chauhan on 12/8/13.
//  Copyright (c) 2013 Sanket Chauhan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SBCBrotip.h"

@interface SBCParser  : NSObject <NSXMLParserDelegate>

@property (strong, nonatomic) NSMutableArray *entries;

-(id) loadXMLByURL:(NSString *) urlString;

@end
