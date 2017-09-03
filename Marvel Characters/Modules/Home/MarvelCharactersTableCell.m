//
//  MarvelCharactersTableCell.m
//  Marvel Characters
//
//  Created by Ruslan Kuchukbaev on 27/08/2017.
//  Copyright © 2017 Zimad. All rights reserved.
//

#import "MarvelCharactersTableCell.h"

@interface MarvelCharactersTableCell ()

@property (retain, nonatomic) IBOutlet UIImageView *characterImage;
@property (retain, nonatomic) IBOutlet UILabel *characterName;
@property (retain, nonatomic) IBOutlet UILabel *characterDescription;

@end

@implementation MarvelCharactersTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setCharacterName: (NSString *)name description: (NSString *)description andImage: (UIImage*)image {
    [self.characterName setText:name];
    [self.characterDescription setText:description];
    [self.characterImage setImage:image];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_characterImage release];
    [_characterName release];
    [_characterDescription release];
    [super dealloc];
}
@end
