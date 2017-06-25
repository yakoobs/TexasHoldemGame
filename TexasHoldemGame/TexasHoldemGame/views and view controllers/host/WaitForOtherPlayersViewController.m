//
//  WaitForOtherPlayersViewController.m
//  TexasHoldemGame
//
//  Created by Jakub Sokolowski on 14/11/2013.
//  Copyright (c) 2013 WUT. All rights reserved.
//

#import "WaitForOtherPlayersViewController.h"
#import "LoadingGameSettingsViewController.h"

@interface WaitForOtherPlayersViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *playersListTableView;
@end

@implementation WaitForOtherPlayersViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureTheGame];
    [self configurePlayersListTableView];
}

-(void)configureTheGame
{
    [self.hostNetworkModel hostGame];
}

-(void)configurePlayersListTableView
{
    self.playersListTableView.delegate = self;
    self.playersListTableView.dataSource = self;
}
-(void)setHostNetworkModelPlayerName:(NSString*)paramPlayerName
                   andTournamentName:(NSString*)paramTournamentName
{
        self.hostNetworkModel.playerName = paramPlayerName;
        self.hostNetworkModel.tournamentName = paramTournamentName;
}

-(HostNetworkModel*)hostNetworkModel
{
    if (!_hostNetworkModel)
    {
        _hostNetworkModel = [[HostNetworkModel alloc]init];
        _hostNetworkModel.delegate = self;
    }
    return _hostNetworkModel;
}

#pragma mark - Push LoadingGameSettingsViewController with segue
-(void)prepareForSegue:(UIStoryboardSegue *)segue
                sender:(id)sender
{
    static NSString* const kPushHostLoadingGameSettingsVC = @"PushHostLoadingGameSettingsVC";
    if ([segue.identifier isEqualToString:kPushHostLoadingGameSettingsVC])
    {
        LoadingGameSettingsViewController* loadingGameSettingsVC = (LoadingGameSettingsViewController*)segue.destinationViewController;
        loadingGameSettingsVC.networkModel = self.hostNetworkModel;
    }
}

#pragma mark - HostNetworkModelProtocol methods
-(void)updateListOfPlayers
{
    [self.playersListTableView reloadData];
}

#pragma mark - UITableViewDataSource methods
-(UITableViewCell*)tableView:(UITableView *)tableView
       cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* const CellIdentifier = @"CellId";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = (self.hostNetworkModel.playersNames)[indexPath.row];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.hostNetworkModel.numberOfPlayers;
}
@end
