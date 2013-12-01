//
//  Board.h
//  TexasHoldemGame
//
//  Created by Jakub Sokolowski on 01/12/2013.
//  Copyright (c) 2013 WUT. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Card;

@interface Board : NSObject

@property NSInteger pot;
@property (strong, nonatomic) NSArray* flop;
@property (strong, nonatomic) Card* turn;
@property (strong, nonatomic) Card* river;

@end
