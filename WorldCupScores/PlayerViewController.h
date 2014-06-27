//
//  PlayerViewController.h
//  WorldCupScores
//
//  Created by Benjamin Hendricks on 6/25/14.
//  Copyright (c) 2014 Benjamin Hendricks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayerViewController : UIViewController

@property (strong, nonatomic) id player;
@property (weak, nonatomic) IBOutlet UILabel *playerAge;
@property (weak, nonatomic) IBOutlet UIImageView *playerImage;
@property (weak, nonatomic) IBOutlet UILabel *playerBirthCountry;
@property (weak, nonatomic) IBOutlet UILabel *playerHeight;
@property (weak, nonatomic) IBOutlet UILabel *playerWeight;
@property (weak, nonatomic) IBOutlet UILabel *playerGoals;
@property (weak, nonatomic) IBOutlet UILabel *playerAssists;
@property (weak, nonatomic) IBOutlet UILabel *playerPosition;

@property (weak, nonatomic) IBOutlet UILabel *playerFoot;
@property (weak, nonatomic) IBOutlet UILabel *playerFirstName;
@property (weak, nonatomic) IBOutlet UILabel *playerLastName;
@property (weak, nonatomic) IBOutlet UIImageView *clubLogo;
@property (weak, nonatomic) IBOutlet UILabel *playerClub;


@end
