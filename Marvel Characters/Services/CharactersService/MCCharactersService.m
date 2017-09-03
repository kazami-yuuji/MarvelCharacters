//
//  MCCharactersService.m
//  Marvel Characters
//
//  Created by Ruslan Kuchukbaev on 28/08/2017.
//  Copyright © 2017 Zimad. All rights reserved.
//

#import "MCCharactersService.h"
#import "MCNetworkService.h"

@interface MCCharactersService ()

@property (nonatomic, retain) id<MCDataService> dataService;
@property (nonatomic, retain) MCNetworkService *networkService;

@end

@implementation MCCharactersService

-(instancetype)initWithDataService:(id<MCDataService>)dataService {
    if (self = [super init]) {
        [self setDataService:dataService];
        [self.dataService setDelegate:self];
        MCNetworkService *networkService = [[MCNetworkService alloc] init];
        [self setNetworkService:networkService];
        [self.networkService setDelegate:self];
        [networkService release];
        return self;
    }
    [self release];
    return nil;
}

-(void)requestCharacters {
    [self.networkService loadCharacters];
}

-(void)networkServiceDidFinishDownloadingCharacters:(NSArray<Character *> *)characters {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self.dataService saveCharacters:characters];
    });
    [self.delegate charactersServiceDidFinishRequestingCharacters:characters];
}

-(void)networkServiceDidFinishDownloadingCharactersWithError:(NSError *)error {
    NSLog(@"%@", error);
    [self.dataService loadCharacters];
}

-(void)dataServiceDidFinishLoadingCharacters:(NSArray<Character *> *)characters {
    [self.delegate charactersServiceDidFinishRequestingCharacters:characters];
}

-(void)dealloc {
    [self.dataService release];
    [self.networkService release];
    [super dealloc];
}

@end
