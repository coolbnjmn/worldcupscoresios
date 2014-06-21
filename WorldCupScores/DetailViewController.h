//
//  DetailViewController.h
//  WorldCupScores
//
//  Created by Benjamin Hendricks on 6/20/14.
//  Copyright (c) 2014 Benjamin Hendricks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *homeTeamName;
@property (weak, nonatomic) IBOutlet UILabel *awayTeamName;
@property (weak, nonatomic) IBOutlet UIImageView *homeTeamLogo;
@property (weak, nonatomic) IBOutlet UIImageView *awayTeamLogo;
@property (weak, nonatomic) IBOutlet UILabel *homeScore;
@property (weak, nonatomic) IBOutlet UILabel *awayScore;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *homeGoalsAgainst;
@property (weak, nonatomic) IBOutlet UILabel *homeGoalsFor;
@property (weak, nonatomic) IBOutlet UILabel *homeGroup;
@property (weak, nonatomic) IBOutlet UILabel *homeGroupRank;

@property (weak, nonatomic) IBOutlet UILabel *awayGoalsAgainst;
@property (weak, nonatomic) IBOutlet UILabel *awayGoalsFor;
@property (weak, nonatomic) IBOutlet UILabel *awayGroup;
@property (weak, nonatomic) IBOutlet UILabel *awayGroupRank;
@end
