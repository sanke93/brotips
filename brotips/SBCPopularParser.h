//
//  SBCPopularParser.h
//  brotips
//
//  Created by Sanket Chauhan on 12/12/13.
//  Copyright (c) 2013 Sanket Chauhan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SBCPopularParser : NSObject <NSXMLParserDelegate>

@property (strong, nonatomic) NSMutableArray *popularEntries;

-(id) loadXMLByURL:(NSString *) urlStringP;


@end


NSMutableString	*currentNodeContent;

