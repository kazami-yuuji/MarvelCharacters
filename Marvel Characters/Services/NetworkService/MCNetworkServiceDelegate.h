//
//  MCNetworkServiceDelegate.h
//  Marvel Characters
//
//  Created by Ruslan Kuchukbaev on 27/08/2017.
//  Copyright © 2017 Zimad. All rights reserved.
//

#import "Character.h"

@protocol MCNetworkServiceDelegate <NSObject>

-(void) networkServiceDidFinishDownloadingCharacters: (NSArray<Character *>*) characters;
-(void) networkServiceDidFinishDownloadingCharactersWithError: (NSError *) error;

@end
