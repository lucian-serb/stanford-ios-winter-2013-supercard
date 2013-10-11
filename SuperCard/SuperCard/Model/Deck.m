//
//  Deck.m
//  Matchismo
//
//  Created by Andrei-Lucian Șerb on 8/22/13.
//  Copyright (c) 2013 Andrei-Lucian Șerb. All rights reserved.
//

#import "Deck.h"

@interface Deck ()

@property (nonatomic) NSMutableArray *cards;

@end

@implementation Deck

- (NSMutableArray *)cards
{
    if (!_cards) {
        _cards = [[NSMutableArray alloc] init];
    }
    
    return _cards;
}

- (void)addCard:(Card *)card atTop:(BOOL) atTop
{
    if (atTop) {
        [self.cards insertObject:card atIndex:0];
    } else {
        [self.cards addObject:card];
    }
}

- (Card *)drawRandomCard
{
    Card *randomCard;
    
    if (self.cards.count) {
        NSUInteger index = arc4random() % self.cards.count;
        randomCard = self.cards[index];
        [self.cards removeObjectAtIndex:index];
    }
    
    return randomCard;
}

@end
