//
//  MCCharactersServiceDelegate.h
//  Marvel Characters
//
//  Created by Ruslan Kuchukbaev on 28/08/2017.
//  Copyright © 2017 Zimad. All rights reserved.
//

#import "Character.h"

@protocol MCCharactersServiceDelegate <NSObject>

-(void) charactersServiceDidFinishRequestingCharacters: (NSArray<Character *> *) characters;

@end
