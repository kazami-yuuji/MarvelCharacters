//
//  MCNetworkService.h
//  Marvel Characters
//
//  Created by Ruslan Kuchukbaev on 27/08/2017.
//  Copyright © 2017 Zimad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MCNetworkServiceDelegate.h"

@interface MCNetworkService : NSObject

@property (nonatomic, assign) id<MCNetworkServiceDelegate> delegate;

-(void)loadCharacters;

@end
