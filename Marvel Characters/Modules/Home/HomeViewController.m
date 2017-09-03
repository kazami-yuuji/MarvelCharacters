//
//  HomeViewController.m
//  Marvel Characters
//
//  Created by Ruslan Kuchukbaev on 27/08/2017.
//  Copyright © 2017 Zimad. All rights reserved.
//

#import "HomeViewController.h"
#import "MarvelCharactersTableCell.h"
#import "MCCharactersService.h"
#import "MCFileDataService.h"
#import "DetailsViewController.h"

@interface HomeViewController ()

@property (nonatomic, retain) MCCharactersService *charactersService;
@property (atomic, retain) NSArray<Character *> *characters;
@property (retain, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    MCFileDataService *fileDataService = [[MCFileDataService alloc] init];
    MCCharactersService *charactersService = [[MCCharactersService alloc] initWithDataService:fileDataService];
    [fileDataService release];
    [self setCharactersService:charactersService];
    [charactersService release];
    [self.charactersService setDelegate:self];
    
    [self.charactersService requestCharacters];
    
    //[self.tableView setRowHeight:UITableViewAutomaticDimension];
    [self.tableView setEstimatedRowHeight:90];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)charactersServiceDidFinishRequestingCharacters:(NSArray<Character *> *)characters {
    [self setCharacters:characters];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MarvelCharactersTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MarvelCharacterTableCell"];
    Character *character = self.characters[[indexPath item]];
    [cell setCharacterName:character.name description:character.characterDescription andImage:[[UIImage alloc] initWithData:character.smallImage]];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.characters.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"ShowDetailsSegue" sender:self.characters[indexPath.item]];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ShowDetailsSegue"]) {
        Character *character = (Character *)sender;
        DetailsViewController *detailsVC = (DetailsViewController *)segue.destinationViewController;
        [detailsVC setCharacter:character];
    }
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
    [_tableView release];
    [self.charactersService release];
    [self.characters release];
    [super dealloc];
}
@end
