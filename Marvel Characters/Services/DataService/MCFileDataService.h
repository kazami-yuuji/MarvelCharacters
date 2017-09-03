//
//  MCFileDataService.h
//  Marvel Characters
//
//  Created by Ruslan Kuchukbaev on 27/08/2017.
//  Copyright © 2017 Zimad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCDataService.h"

@interface MCFileDataService : NSObject<MCDataService>

@property (nonatomic, assign) id<MCDataServiceDelegate> delegate;

@end
