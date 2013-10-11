//
//  PlayingCard.m
//  Matchismo
//
//  Created by Andrei-Lucian Șerb on 8/22/13.
//  Copyright (c) 2013 Andrei-Lucian Șerb. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

- (NSInteger)match:(NSArray *)otherCards
{
    NSInteger score = 0;
    
    if ([otherCards count] == 1) {
        PlayingCard *otherCard = [otherCards lastObject];
        
        if ([otherCard.suit isEqualToString:self.suit]) {
            score = 1;
        } else if (otherCard.rank == self.rank) {
            score = 4;
        }
    }
    
    return score;
}

- (NSString *) contents
{
    return [[PlayingCard rankStrings][self.rank] stringByAppendingString:self.suit];
}

+ (NSArray *)validSuites
{
    static NSArray *validSuites;
    
    if (!validSuites) {
        validSuites = @[@"♥", @"♦", @"♠", @"♣"];
    }
    
    return validSuites;
}

+ (NSArray *)rankStrings
{
    static NSArray *rankStrings;
    
    if (!rankStrings) {
        rankStrings = @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
    }
    
    return rankStrings;
}

+ (NSUInteger)maxRank
{
    return [self rankStrings].count - 1;
}

@synthesize suit = _suit;

- (NSString *)suit
{
    return _suit ? _suit : @"?";
}

- (void)setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuites] containsObject:suit]) {
        _suit = suit;
    }
}

- (void)setRank:(NSUInteger)rank
{
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}

@end
