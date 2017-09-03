//
//  HttpRequest.h
//  Marvel Characters
//
//  Created by Ruslan Kuchukbaev on 27/08/2017.
//  Copyright © 2017 Zimad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpRequest : NSObject <NSURLSessionDownloadDelegate>

-(instancetype)init __attribute__((unavailable));
-(instancetype)initWithBaseUrl: (NSString*)baseUrl;
-(void)executeWithRelativeUrl:(NSString *)relativeUrl andCompleteHandler: (void(^) (NSData *, NSError *))completeHandler;

-(void)dealloc;

@end
