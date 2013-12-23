//
//  Deck.h
//  TexasHoldemGame
//
//  Created by Jakub Sokolowski on 23/11/2013.
//  Copyright (c) 2013 WUT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

/**
 * Returns Card object from deck. If deck is empty returns nil.
 */
- (Card *)drawRandomCardAndRemoveItFromDeck;


/**
 * Reset deck to full 52 cards, required before start of new hand
 */
- (void) resetDeck;

@end
