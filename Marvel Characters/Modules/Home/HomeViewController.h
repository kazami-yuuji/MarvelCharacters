//
//  HomeViewController.h
//  Marvel Characters
//
//  Created by Ruslan Kuchukbaev on 27/08/2017.
//  Copyright © 2017 Zimad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCCharactersServiceDelegate.h"

@interface HomeViewController : UIViewController<MCCharactersServiceDelegate, UITableViewDelegate, UITableViewDataSource>

@end
