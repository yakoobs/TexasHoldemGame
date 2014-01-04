//
//  LoadingGameSettingsViewController.h
//  TexasHoldemGame
//
//  Created by Jakub Sokolowski on 15/11/2013.
//  Copyright (c) 2013 WUT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameNetworkModel.h"

@interface LoadingGameSettingsViewController : UIViewController
@property (nonatomic,strong) GameNetworkModel * networkModel;
@end
