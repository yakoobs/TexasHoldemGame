//
//  Player.h
//  TexasHoldemGame
//
//  Created by Jakub Sokolowski on 01/12/2013.
//  Copyright (c) 2013 WUT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Player : NSObject

@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSArray* cardsInTheHand;
@property NSInteger stack;
@property NSInteger sittingPositionRegardingToDealer;

@end
