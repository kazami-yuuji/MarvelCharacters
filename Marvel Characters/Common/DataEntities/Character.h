//
//  Character.h
//  Marvel Characters
//
//  Created by Ruslan Kuchukbaev on 27/08/2017.
//  Copyright © 2017 Zimad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Character : NSObject

@property NSInteger characterId;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *characterDescription;
@property (nonatomic, retain) NSData *smallImage;
@property (nonatomic, retain) NSData *largeImage;

-(instancetype)init;
-(void)dealloc;

@end
