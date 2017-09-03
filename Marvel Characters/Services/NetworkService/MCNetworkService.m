//
//  MCNetworkService.m
//  Marvel Characters
//
//  Created by Ruslan Kuchukbaev on 27/08/2017.
//  Copyright © 2017 Zimad. All rights reserved.
//

#import "MCNetworkService.h"
#import "MarvelApiCharacterRequest.h"
#import "MarvelApiCharacterImageRequest.h"

static NSString * const SmallSizeImageName = @"standard_xlarge";
static NSString * const LargeSizeImageName = @"landscape_incredible";

@interface MCNetworkService()

@end

@implementation MCNetworkService

-(void)loadCharacters {
    MarvelApiCharacterRequest *request = [[MarvelApiCharacterRequest alloc] init];
    [request executeWithLimit:100 offset:0 andCompleteHandler:^(NSData *data, NSError *error) {
        [request release];
        
        if (error != nil) {
            [self.delegate networkServiceDidFinishDownloadingCharactersWithError:error];
            return;
        }
        
        NSError *jsonError = nil;
        NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonError];
        NSLog(@"%@", jsonResponse);
        if (jsonError == nil) {
            NSDictionary *dataField = [jsonResponse objectForKey:@"data"];
            if (dataField) {
                int count = [[dataField objectForKey:@"count"] intValue];
                NSArray<NSDictionary *> *results = [dataField objectForKey:@"results"];
                NSMutableArray<Character *> *characters = [[NSMutableArray alloc] init];
                
                dispatch_group_t dispatchGroup = dispatch_group_create();
                
                for (int i = 0; i < count; i++) {
                    Character *c = [[Character alloc] init];
                    [c setCharacterId:[[results[i] objectForKey:@"id"] integerValue]];
                    [c setName:[results[i] objectForKey:@"name"]];
                    NSString *charDescription = [results[i] objectForKey:@"description"];
                    if ([charDescription length] == 0) {
                        [c setCharacterDescription:@"<no description>"];
                    }
                    else {
                        [c setCharacterDescription:charDescription];
                    }
                    
                    NSDictionary *thumbnailField =[results[i] objectForKey:@"thumbnail"];
                    MarvelApiCharacterImageRequest *smallImageRequest = [[MarvelApiCharacterImageRequest alloc] initWithBaseUrl:[thumbnailField objectForKey:@"path"] size:SmallSizeImageName andExtension:[thumbnailField objectForKey:@"extension"]];
                    dispatch_group_enter(dispatchGroup);
                    [smallImageRequest executeWithCompleteHandler:^(NSData *data, NSError *error) {
                        if (error == nil) {
                            [c setSmallImage:[[NSData alloc] initWithData:data]];
                        }
                        else {
                            NSLog(@"%@", error);
                        }
                        
                        dispatch_group_leave(dispatchGroup);
                        [smallImageRequest release];
                    }];
                    MarvelApiCharacterImageRequest *largeImageRequest = [[MarvelApiCharacterImageRequest alloc] initWithBaseUrl:[thumbnailField objectForKey:@"path"] size:LargeSizeImageName andExtension:[thumbnailField objectForKey:@"extension"]];
                    dispatch_group_enter(dispatchGroup);
                    [largeImageRequest executeWithCompleteHandler:^(NSData *data, NSError *error) {
                        if (error == nil) {
                            [c setLargeImage:[[NSData alloc] initWithData:data]];
                        }
                        else {
                            NSLog(@"%@", error);
                        }
                        
                        dispatch_group_leave(dispatchGroup);
                        [largeImageRequest release];
                    }];
                    
                    [characters addObject:c];
                    [c release];
                }
                dispatch_group_notify(dispatchGroup, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    [self.delegate networkServiceDidFinishDownloadingCharacters:characters];
                    [characters release];
                });
            }
            else {
                NSLog(@"%@", jsonResponse);
            }
        }
        else {
            NSLog(@"%@", jsonError);
        }
    }];
}

@end
