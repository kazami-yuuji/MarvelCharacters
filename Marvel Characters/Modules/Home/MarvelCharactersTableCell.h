//
//  MarvelCharactersTableCell.h
//  Marvel Characters
//
//  Created by Ruslan Kuchukbaev on 27/08/2017.
//  Copyright © 2017 Zimad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MarvelCharactersTableCell : UITableViewCell

- (void)setCharacterName: (NSString *)name description: (NSString *)description andImage: (UIImage*)image;

@end
