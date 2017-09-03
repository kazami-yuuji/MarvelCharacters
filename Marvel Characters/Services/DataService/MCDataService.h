//
//  MCDataService.h
//  Marvel Characters
//
//  Created by Ruslan Kuchukbaev on 27/08/2017.
//  Copyright © 2017 Zimad. All rights reserved.
//

#import "MCDataServiceDelegate.h"

@protocol MCDataService <NSObject>

@property (nonatomic, assign) id<MCDataServiceDelegate> delegate;

-(void) saveCharacters: (NSArray<Character *> *)characters;
-(void) loadCharacters;

@end
