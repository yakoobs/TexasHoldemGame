//
//  MainBoardViewController.h
//  TexasHoldemGame
//
//  Created by Jakub Sokolowski on 14/11/2013.
//  Copyright (c) 2013 WUT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameLogicModel.h"
#import "GameNetworkModel.h"

@interface MainBoardViewController : UIViewController
@property (nonatomic, strong) GameLogicModel* logicModel;
@property (nonatomic, strong) GameNetworkModel* networkModel;
@end
