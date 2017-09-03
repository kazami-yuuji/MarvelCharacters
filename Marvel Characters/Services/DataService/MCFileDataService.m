//
//  MCFileDataService.m
//  Marvel Characters
//
//  Created by Ruslan Kuchukbaev on 27/08/2017.
//  Copyright © 2017 Zimad. All rights reserved.
//

#import "MCFileDataService.h"
#import "Character.h"

static NSString* const DbFilename = @"MarvelCharactersDb.txt";

@implementation MCFileDataService

-(NSString *)pathToDocumentsFolder {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject].path;
}

-(NSData *)loadDataFromFileWithFilename: (NSString *)filename {
    NSString *path = [[self pathToDocumentsFolder] stringByAppendingPathComponent:filename];
    return [NSData dataWithContentsOfFile:path];
}

-(void)saveDataWithFilename: (NSString *)filename andData: (NSData *)data {
    NSString *path = [[self pathToDocumentsFolder] stringByAppendingPathComponent:filename];
    [data writeToFile:path atomically:YES];
}

-(void)saveImagesForCharacter: (Character *) character {
    NSString *smallImageFilename = [NSString stringWithFormat:@"%ld%@", (long)character.characterId, @"small"];
    NSString *largeImageFilename = [NSString stringWithFormat:@"%ld%@", (long)character.characterId, @"large"];
    [self saveDataWithFilename:smallImageFilename andData:character.smallImage];
    [self saveDataWithFilename:largeImageFilename andData:character.largeImage];
}

-(void)saveCharacters:(NSArray<Character *> *)characters {
    NSMutableString *str = [[NSMutableString alloc] init];
    for (int i = 0; i < [characters count]; i++) {
        [str appendFormat:@"%ld\n", (long)characters[i].characterId];
        [str appendFormat:@"%@\n", characters[i].name];
        [str appendFormat:@"%@\n", characters[i].characterDescription];
        [self saveImagesForCharacter:characters[i]];
    }
    
    [self saveDataWithFilename:DbFilename andData:[str dataUsingEncoding:NSUTF8StringEncoding]];
    [str release];
}

-(void)loadImagesForCharacter: (Character *)character {
    NSString *smallImageFilename = [NSString stringWithFormat:@"%ld%@", (long)character.characterId, @"small"];
    NSString *largeImageFilename = [NSString stringWithFormat:@"%ld%@", (long)character.characterId, @"large"];
    [character setSmallImage:[self loadDataFromFileWithFilename:smallImageFilename]];
    [character setLargeImage:[self loadDataFromFileWithFilename:largeImageFilename]];
}

-(void)loadCharacters {
    NSData *data = [self loadDataFromFileWithFilename:DbFilename];
    NSString *stringData = [[NSString alloc] initWithBytes:[data bytes] length:[data length] encoding:NSUTF8StringEncoding];
    
    NSArray<NSString *> *splittedData = [stringData componentsSeparatedByString:@"\n"];
    NSMutableArray<Character *> *characters = [[NSMutableArray<Character *> alloc] init];
    for (int i = 0; i < [splittedData count] - 2; i += 3) {
        Character *character = [[Character alloc] init];
        [character setCharacterId:[splittedData[i] integerValue]];
        [character setName:splittedData[i + 1]];
        [character setCharacterDescription:splittedData[i + 2]];
        [self loadImagesForCharacter:character];
        [characters addObject:character];
        [character release];
    }
    
    [self.delegate dataServiceDidFinishLoadingCharacters:characters];
    [characters release];
}

@end
