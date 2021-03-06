//
//  GameSettings.m
//  Matchismo
//
//  Created by Vasco Orey on 2/15/13.
//  Copyright (c) 2013 Delta Dog Studios. All rights reserved.
//

#import "AllGameSettings.h"

@interface AllGameSettings()
@property (nonatomic, strong) NSMutableDictionary *allGameSettings;
@end

@implementation AllGameSettings

-(NSMutableDictionary *)allGameSettings
{
    if(!_allGameSettings)
    {
        _allGameSettings = [[NSMutableDictionary alloc] init];
    }
    return _allGameSettings;
}

+(AllGameSettings *)sharedSettings
{
    static AllGameSettings *sharedSettings = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedSettings = [[AllGameSettings alloc] init];
    });
    return sharedSettings;
}

+(void)setSettings:(GameSettings *)settings forGame:(NSString *)game
{
    [self sharedSettings].allGameSettings[game] = settings;
}

+(GameSettings *)settingsForGame:(NSString *)game
{
    GameSettings *settings = nil;
    if([[[self sharedSettings].allGameSettings allKeys] containsObject:game])
    {
        settings = [self sharedSettings].allGameSettings[game];
    }
    return settings;
}

@end
