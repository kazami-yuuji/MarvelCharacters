//
//  DetailsViewController.m
//  Marvel Characters
//
//  Created by Ruslan Kuchukbaev on 29/08/2017.
//  Copyright © 2017 Zimad. All rights reserved.
//

#import "DetailsViewController.h"

@interface DetailsViewController ()

@property (nonatomic, retain) Character *characterToShow;

@property (retain, nonatomic) IBOutlet UIImageView *characterImage;
@property (retain, nonatomic) IBOutlet UILabel *characterName;
@property (retain, nonatomic) IBOutlet UITextView *characterDescription;
@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.characterName setText:self.characterToShow.name];
    [self.characterDescription setText:self.characterToShow.characterDescription];
    [self.characterImage setImage:[[UIImage alloc] initWithData:self.characterToShow.largeImage]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setCharacter:(Character *)character {
    [self setCharacterToShow:character];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)dealloc {
    [_characterImage release];
    [_characterName release];
    [_characterDescription release];
    [self.characterToShow release];
    [super dealloc];
}
@end
