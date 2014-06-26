//
//  PlayerViewController.m
//  WorldCupScores
//
//  Created by Benjamin Hendricks on 6/25/14.
//  Copyright (c) 2014 Benjamin Hendricks. All rights reserved.
//

#import "PlayerViewController.h"

@implementation PlayerViewController

- (void)setPlayer:(id)newPlayer
{
    if (_player != newPlayer) {
        _player = newPlayer;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    self.view.backgroundColor = [UIColor colorWithRed:190.0f/255.0f green:201.0f/255.0f blue:187.0f/255.0f alpha:1.0];
    NSLog(@"in player view controller");
    NSLog(@"%@", _player);
    self.playerAge.text = [NSString stringWithFormat:@"%@", [_player objectForKey:@"age"]];
    self.playerBirthCountry.text = [_player objectForKey:@"birthCountry"];
    NSString *tmpHeight = [NSString stringWithFormat:@"%@", [_player objectForKey:@"heightCm"]];
    if(![tmpHeight isEqualToString:@"<null>"]) {
        self.playerHeight.text = tmpHeight;
    } else {
        self.playerHeight.text = @"unknown";
    }
    
    NSString *tmpWeight = [NSString stringWithFormat:@"%@", [_player objectForKey:@"weightKg"]];
    if(![tmpWeight isEqualToString: @"<null>"]) {
        self.playerWeight.text = [NSString stringWithFormat:@"%@",tmpWeight];
    } else {
        self.playerWeight.text = @"unknown";
    }
    
    self.playerGoals.text = [NSString stringWithFormat:@"%@",[_player objectForKey:@"goals"]];
    self.playerAssists.text = [NSString stringWithFormat:@"%@", [_player objectForKey:@"assists"]];
    self.playerPosition.text = [_player objectForKey:@"position"];
    self.playerImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[_player objectForKey:@"image"]]]];
    
    NSString *tmpFoot = [NSString stringWithFormat:@"%@", [_player objectForKey:@"foot"]];
    if(![tmpFoot isEqualToString: @"<null>"]) {
        self.playerFoot.text = tmpFoot;
    } else {
        self.playerFoot.text = @"unknown";
    }
    
    self.playerFirstName.text = [_player objectForKey:@"firstName"];
    self.playerLastName.text = [_player objectForKey:@"lastName"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
