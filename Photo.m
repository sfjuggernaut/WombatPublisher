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
    NSURL *url = [NSURL URLWithString:@"http://localhost:3000"];
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:url];
    
    NSData *data = UIImageJPEGRepresentation(picture, 0.2);
    
    NSMutableURLRequest *request = [client multipartFormRequestWithMethod:@"POST" path:@"/wombats.json" parameters:nil constructingBodyWithBlock: ^(id <AFMultipartFormData>formData) {
        [formData appendPartWithFileData:data name:@"image" fileName:@"test.jpg" mimeType:@"image/jpeg"];
    }];
    
    AFHTTPRequestOperation *operation = [[[AFHTTPRequestOperation alloc] initWithRequest:request] autorelease];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *op, id responseObj) {
        NSLog(@"success: %@", operation.responseString);
        [self showMessage:@"Wombat successfully entered into the world!"];
    } failure:^(AFHTTPRequestOperation *op, NSError *error) {
        NSString *msg = [NSString stringWithFormat:@"[Error]: (%@ %@) %@", [operation.request HTTPMethod], [[operation.request URL] relativePath], operation.error];
        NSLog(msg);
        [self showMessage:msg];
    }];
    
    NSOperationQueue *queue = [[[NSOperationQueue alloc] init] autorelease];
    [queue addOperation:operation];
}

- (void)showMessage:(NSString *)msg {
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:nil
                                                      message:msg
                                                     delegate:nil
                                            cancelButtonTitle:@"OK"
                                            otherButtonTitles:nil];
    
    [message show];
}

@end
