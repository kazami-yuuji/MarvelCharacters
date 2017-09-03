//
//  MarvelApiCharacterImageRequest.m
//  Marvel Characters
//
//  Created by Ruslan Kuchukbaev on 03/09/2017.
//  Copyright © 2017 Zimad. All rights reserved.
//

#import "MarvelApiCharacterImageRequest.h"
#import "HttpRequest.h"

@interface MarvelApiCharacterImageRequest ()

@property (nonatomic, retain) HttpRequest *httpRequest;

@end

@implementation MarvelApiCharacterImageRequest

-(instancetype)initWithBaseUrl:(NSString *)baseUrl size:(NSString *)size andExtension:(NSString *)extension {
    if (self = [super init]) {
        NSString *url = [NSString stringWithFormat:@"%@/%@.%@", baseUrl, size, extension];
        [self setHttpRequest:[[HttpRequest alloc] initWithBaseUrl:url]];
        
        return self;
    }
    [self release];
    return nil;
}

-(void)executeWithCompleteHandler:(void (^)(NSData *, NSError *))completeHandler {
    [self.httpRequest executeWithRelativeUrl:@"" andCompleteHandler:completeHandler];
}

-(void)dealloc {
    [self.httpRequest release];
    [super dealloc];
}

@end
