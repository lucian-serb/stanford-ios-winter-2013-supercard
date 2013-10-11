//
//  Deck.h
//  Matchismo
//
//  Created by Andrei-Lucian Șerb on 8/22/13.
//  Copyright (c) 2013 Andrei-Lucian Șerb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

- (void)addCard:(Card *)card atTop:(BOOL) atTop;
- (Card *)drawRandomCard;

@end
