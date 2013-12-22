//
//  Board.h
//  TexasHoldemGame
//
//  Created by Jakub Sokolowski on 01/12/2013.
//  Copyright (c) 2013 WUT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@class Card;

@interface Board : NSObject

@property (nonatomic,strong) Deck* deck;
@property NSInteger pot;
@property (strong, nonatomic) NSArray* cardsOnBoard;
@property (strong, nonatomic) NSArray* players;

@end
