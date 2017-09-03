//
//  HttpRequest.m
//  Marvel Characters
//
//  Created by Ruslan Kuchukbaev on 27/08/2017.
//  Copyright © 2017 Zimad. All rights reserved.
//

#import "HttpRequest.h"

@interface HttpRequest ()

@property (nonatomic, retain) NSString *baseUrl;
@property (nonatomic, copy) void(^completeHandler)(NSData *, NSError *);

@end

@implementation HttpRequest

-(instancetype)initWithBaseUrl:(NSString *)baseUrl {
    if (self = [super init]) {
        [self setBaseUrl:[baseUrl copy]];
        return self;
    }
    [self release];
    return nil;
}

-(void)executeWithRelativeUrl:(NSString *)relativeUrl andCompleteHandler: (void(^) (NSData *, NSError *))completeHandler {
    NSString *absoluteUrl = [self.baseUrl stringByAppendingString:relativeUrl];
    NSURL *url = [[NSURL alloc] initWithString:absoluteUrl];
    [self setCompleteHandler:completeHandler];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration delegate:self delegateQueue:nil];
    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithRequest:request];
    [downloadTask resume];
    
    [request release];
    [url release];
}

-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location {
    NSData *data = [NSData dataWithContentsOfURL:location];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        self.completeHandler(data, nil);
    });
}

-(void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    if (error != nil) {
        self.completeHandler(nil, error);
    }
}

-(void)dealloc {
    [self.baseUrl release];
    [super dealloc];
}

@end
