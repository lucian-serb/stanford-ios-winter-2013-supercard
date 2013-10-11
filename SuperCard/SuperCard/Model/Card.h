//
//  Card.h
//  Matchismo
//
//  Created by Andrei-Lucian Șerb on 8/22/13.
//  Copyright (c) 2013 Andrei-Lucian Șerb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (nonatomic) NSString *contents;
@property (nonatomic, getter = isFaceUp) BOOL faceUp;
@property (nonatomic, getter = isUnplayable ) BOOL unplayable;

- (NSInteger)match:(NSArray *) otherCards;

@end
