//
//  Card.h
//  TexasHoldemGame
//
//  Created by Jakub Sokolowski on 23/11/2013.
//  Copyright (c) 2013 WUT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject<NSCopying>
@property (copy, nonatomic) NSString* rank;
@property (copy, nonatomic) NSString* suit;
@property NSInteger value;

-(instancetype)initWithRank:(NSString*)paramRank suit:(NSString*)paramSuit andValue:(NSInteger)paramValue NS_DESIGNATED_INITIALIZER;

@end
