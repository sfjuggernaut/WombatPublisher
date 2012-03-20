//
//  Photo.m
//  WombatPublisher
//
//  Created by e k on 3/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Photo.h"
#import "AFJSONRequestOperation.h"
#import "SBJsonParser.h"
#import "AFHTTPClient.h"

@implementation Photo

// POST image via JSON
- (void)Post:(UIImage *)picture
{
    NSURL *url = [NSURL URLWithString:@"http://localhost:3000/"];
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:url];
    
    NSData *data = UIImageJPEGRepresentation(picture, 0.2);
    
    NSMutableURLRequest *request = [client multipartFormRequestWithMethod:@"POST" path:@"/wombats.json" parameters:nil constructingBodyWithBlock: ^(id <AFMultipartFormData>formData) {
        [formData appendPartWithFileData:data name:@"image" fileName:@"test.jpg" mimeType:@"image/jpeg"];
    }];
    
    AFHTTPRequestOperation *operation = [[[AFHTTPRequestOperation alloc] initWithRequest:request] autorelease];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *op, id responseObj) {
        NSLog(@"success: %@", operation.responseString);
    } failure:^(AFHTTPRequestOperation *op, NSError *error) {
        NSLog(@"[Error]: (%@ %@) %@", [operation.request HTTPMethod], [[operation.request URL] relativePath], operation.error);
    }];
    
    NSOperationQueue *queue = [[[NSOperationQueue alloc] init] autorelease];
    [queue addOperation:operation];
}

@end
