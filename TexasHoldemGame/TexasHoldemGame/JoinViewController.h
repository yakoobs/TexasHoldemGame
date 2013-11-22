//
//  JoinViewController.h
//  TexasHoldemGame
//
//  Created by Jakub Sokolowski on 14/11/2013.
//  Copyright (c) 2013 WUT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JoiningNetworkModel.h"

@interface JoinViewController : UIViewController<JoiningNetworkModelProtocol,UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) JoiningNetworkModel* joiningNetworkModel;
@property (weak, nonatomic) IBOutlet UITableView *availableHostsTableView;
@property (weak, nonatomic) IBOutlet UITextField *playerNicknameLabel;

@end
