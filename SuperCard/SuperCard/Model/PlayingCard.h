//
//  PlayingCard.h
//  Matchismo
//
//  Created by Andrei-Lucian Șerb on 8/22/13.
//  Copyright (c) 2013 Andrei-Lucian Șerb. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validSuites;
+ (NSUInteger)maxRank;

@end
