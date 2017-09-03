//
//  MarvelApiRequest.h
//  Marvel Characters
//
//  Created by Ruslan Kuchukbaev on 28/08/2017.
//  Copyright © 2017 Zimad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MarvelApiCharacterRequest : NSObject

-(instancetype)init;
-(void) executeWithLimit: (int)limit offset: (int)offset andCompleteHandler: (void(^) (NSData *, NSError *))completeHandler;
-(void)dealloc;

@end
