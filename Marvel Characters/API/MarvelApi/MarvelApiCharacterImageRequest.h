//
//  MarvelApiCharacterImageRequest.h
//  Marvel Characters
//
//  Created by Ruslan Kuchukbaev on 03/09/2017.
//  Copyright © 2017 Zimad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MarvelApiCharacterImageRequest : NSObject

-(instancetype)initWithBaseUrl: (NSString *)baseUrl size: (NSString *)size andExtension: (NSString *)extension;
-(void)executeWithCompleteHandler: (void(^) (NSData *, NSError *))completeHandler;
-(void)dealloc;

@end
