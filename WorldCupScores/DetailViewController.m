//
//  DetailViewController.m
//  WorldCupScores
//
//  Created by Benjamin Hendricks on 6/20/14.
//  Copyright (c) 2014 Benjamin Hendricks. All rights reserved.
//

#import "DetailViewController.h"
#import "PlayerViewController.h"

@interface DetailViewController ()
- (void)configureView;
@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        
        NSDictionary *home = [self.detailItem objectForKey:@"homeTeamId"];
        NSDictionary *away = [self.detailItem objectForKey:@"awayTeamId"];
        self.homeTeamName.text = [home objectForKey:@"name"];
        self.awayTeamName.text = [away objectForKey:@"name"];
        
        self.homeTeamLogo.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[home objectForKey:@"logo"]]]];
        self.awayTeamLogo.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[away objectForKey:@"logo"]]]];
        
        self.homeScore.text = [NSString stringWithFormat:@"%@",[self.detailItem objectForKey:@"homeScore"]];
        self.awayScore.text = [NSString stringWithFormat:@"%@", [self.detailItem objectForKey:@"awayScore"]];
        
        NSString *status = [self.detailItem objectForKey:@"status"];
        if([status isEqualToString:@"Final"]) {
            self.view.backgroundColor = [UIColor colorWithRed:190.0f/255.0f green:201.0f/255.0f blue:187.0f/255.0f alpha:1.0];
            self.time.text = @"FT";
        } else if([status isEqualToString:@"Pre-game"]) {
            self.view.backgroundColor = [UIColor colorWithRed:161.0f/255.0f green:207.0f/255.0f blue:236.0f/255.0f alpha:1.0];
            self.time.text = @"NT";
        } else {
            self.view.backgroundColor = [UIColor colorWithRed:249.0f/255.0f green:215.0f/255.0f blue:120.0f/255.0f alpha:1.0];
            self.time.text = [NSString stringWithFormat:@"%@ '", [self.detailItem objectForKey:@"currentGameMinute"]];
        }
        
        self.homeGoalsAgainst.text = [NSString stringWithFormat:@"%@", [home objectForKey:@"goalsAgainst"]];
        self.homeGoalsFor.text = [NSString stringWithFormat:@"%@", [home objectForKey:@"goalsFor"]];
        self.homeGroup.text = [NSString stringWithFormat:@"%@", [home objectForKey:@"group"]];
        self.homeGroupRank.text = [NSString stringWithFormat:@"%@", [home objectForKey:@"groupRank"]];
        self.homeMatchesPlayed.text = [NSString stringWithFormat:@"%@", [home objectForKey:@"matchesPlayed"]];
        
        self.awayGoalsAgainst.text = [NSString stringWithFormat:@"%@", [away objectForKey:@"goalsAgainst"]];
        self.awayGoalsFor.text = [NSString stringWithFormat:@"%@", [away objectForKey:@"goalsFor"]];
        self.awayGroup.text = [NSString stringWithFormat:@"%@", [away objectForKey:@"group"]];
        self.awayGroupRank.text = [NSString stringWithFormat:@"%@", [away objectForKey:@"groupRank"]];
        self.awayMatchesPlayed.text = [NSString stringWithFormat:@"%@", [away objectForKey:@"matchesPlayed"]];
        
        self.homePlayersTVC.data = [self.detailItem objectForKey:@"homeTeamPlayers"];
        self.awayPlayersTVC.data = [self.detailItem objectForKey:@"awayTeamPlayers"];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        NSLocale *enUSPOSIXLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
        [formatter setLocale:enUSPOSIXLocale];
        [formatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss'.'SSS'Z'"];
        [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
        NSString *startTimeFromObj = [self.detailItem objectForKey:@"startTime"];
        NSLog(@"%@", startTimeFromObj);
        
        NSDate *start = [formatter dateFromString:startTimeFromObj];
        NSLog(@"%@", start);
        
        NSString *dateString = [NSDateFormatter localizedStringFromDate:start
                                                              dateStyle:NSDateFormatterMediumStyle
                                                              timeStyle:NSDateFormatterShortStyle];
        NSLog(@"dateString: %@", dateString);
        self.startDate.text = dateString;
    }
    
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

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"segue being called");
    if ([[segue identifier] isEqualToString:@"showHomePlayer"]) {
        NSIndexPath *indexPath = [self.homeTableView indexPathForSelectedRow];
        NSDictionary *player = [self.homePlayersTVC.data objectAtIndex:indexPath.row];
        
        [[segue destinationViewController] setPlayer:player];
    } else if ([[segue identifier] isEqualToString:@"showAwayPlayer"]) {
        NSIndexPath *indexPath = [self.awayTableView indexPathForSelectedRow];
        NSDictionary *player = [self.awayPlayersTVC.data objectAtIndex:indexPath.row];
        
        [[segue destinationViewController] setPlayer:player];
    }
}

@end
