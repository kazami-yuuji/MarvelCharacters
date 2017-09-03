//
//  MCCharactersService.h
//  Marvel Characters
//
//  Created by Ruslan Kuchukbaev on 28/08/2017.
//  Copyright © 2017 Zimad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MCCharactersServiceDelegate.h"
#import "MCDataServiceDelegate.h"
#import "MCNetworkServiceDelegate.h"
#import "MCDataService.h"

@interface MCCharactersService : NSObject<MCDataServiceDelegate, MCNetworkServiceDelegate>

@property (nonatomic, assign) id<MCCharactersServiceDelegate> delegate;

-(instancetype)init __attribute__((unavailable));
-(instancetype)initWithDataService: (id<MCDataService>)dataService;
-(void)requestCharacters;
-(void)dealloc;

@end
