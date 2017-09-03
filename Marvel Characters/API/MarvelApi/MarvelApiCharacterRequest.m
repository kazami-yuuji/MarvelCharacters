//
//  MarvelApiRequest.m
//  Marvel Characters
//
//  Created by Ruslan Kuchukbaev on 28/08/2017.
//  Copyright © 2017 Zimad. All rights reserved.
//

#import "MarvelApiCharacterRequest.h"
#import "HttpRequest.h"
#import "NSString+MD5.h"

static NSString* const MarvelBaseUrl = @"https://gateway.marvel.com/v1/public";
static NSString* const CharactersListRelativeUrlFormat = @"/characters?limit=%d&offset=%d&apikey=%@&ts=%@&hash=%@";

@interface MarvelApiCharacterRequest ()

@property (nonatomic, retain) HttpRequest *httpRequest;

@end

@implementation MarvelApiCharacterRequest

-(instancetype)init {
    if (self = [super init]) {
        HttpRequest *httpRequest = [[HttpRequest alloc] initWithBaseUrl:MarvelBaseUrl];
        if (httpRequest) {
            [self setHttpRequest:httpRequest];
            [httpRequest release];
            return self;
        }
    }
    [self release];
    return nil;
}

-(void)executeWithLimit:(int)limit offset:(int)offset andCompleteHandler: (void(^) (NSData *, NSError *))completeHandler {
    NSString *apiKey = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"MarvelApiKey"];
    NSString *apiPrivateKey = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"MarvelApiPrivateKey"];
    NSString *timeStamp = [NSString stringWithFormat:@"%.0f", [[NSDate date] timeIntervalSince1970]];
    NSString *hash = [[[timeStamp stringByAppendingString:apiPrivateKey] stringByAppendingString:apiKey] MD5];
    NSString *formattedRelativeUrl = [[NSString alloc] initWithFormat:CharactersListRelativeUrlFormat, limit, offset, apiKey, timeStamp, hash];
    [self.httpRequest executeWithRelativeUrl:formattedRelativeUrl andCompleteHandler:completeHandler];
    [formattedRelativeUrl release];
}

-(void)dealloc {
    [self.httpRequest release];
    [super dealloc];
}

@end
