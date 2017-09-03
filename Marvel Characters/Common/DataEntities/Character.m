//
//  Character.m
//  Marvel Characters
//
//  Created by Ruslan Kuchukbaev on 27/08/2017.
//  Copyright © 2017 Zimad. All rights reserved.
//

#import "Character.h"

@implementation Character

-(instancetype)init {
    if (self = [super init]) {
        return self;
    }
    [self release];
    return nil;
}

-(void)dealloc {
    [self.name release];
    [self.characterDescription release];
    [self.smallImage release];
    [self.largeImage release];
    [super dealloc];
}

@end
