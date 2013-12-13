//
//  SBCPopularParser.m
//  brotips
//
//  Created by Sanket Chauhan on 12/12/13.
//  Copyright (c) 2013 Sanket Chauhan. All rights reserved.
//

#import "SBCPopularParser.h"
#import "SBCBrotip.h"

@implementation SBCPopularParser

NSMutableString	*currentNodeContent;
NSXMLParser		*parser;
SBCBrotip		*currentTip;

-(id) loadXMLByURL:(NSString *)urlString
{
	self.popularEntries			= [[NSMutableArray alloc] init];
	NSURL *url		= [NSURL URLWithString:urlString];
	NSData	*data   = [[NSData alloc] initWithContentsOfURL:url];
    //NSString *aStr = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    //NSLog(@"aStr:%@",aStr);
	parser			= [[NSXMLParser alloc] initWithData:data];
	parser.delegate = self;
	[parser parse];
	return self;
}

- (void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
	currentNodeContent = (NSMutableString *) [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementname namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{   //NSString *hi = [[NSString alloc] initWithData:elementname encoding:NSASCIIStringEncoding];
    //NSLog(@"%@",hi);
	if ([elementname isEqualToString:@"entry"])
	{
		currentTip = [[SBCBrotip alloc] init];
	}
    
}

- (void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementname namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    
    //    if ([elementname isEqualToString:@"link"])
    //    {
    //        currentTip.linkTag = currentNodeContent;
    //        NSLog(@"%@", currentNodeContent);
    //    }
    
    if ([elementname isEqualToString:@"title"])
    {
        NSString *tempTip = currentNodeContent;
        tempTip= [tempTip stringByReplacingOccurrencesOfString:@"#" withString:@""];
        currentTip.tipNumber = tempTip;
        currentTip.linkTag = [[NSMutableString alloc] initWithString:@"http://www.brotips.com/"];
        [currentTip.linkTag appendString:[NSString stringWithFormat:@"%@", tempTip]];
        //shareURL = [[NSURL alloc]initFileURLWithPath:tipURL];
        //NSLog(@"%@",currentTip.linkTag);
    }
    
    if ([elementname isEqualToString:@"content"]){
        currentTip.content = currentNodeContent;
        NSLog(@"%@",currentTip.content);
    }
    
	if ([elementname isEqualToString:@"entry"])
	{
		[self.popularEntries addObject:currentTip];
		currentTip = nil;
		currentNodeContent = nil;
	}
}


@end
