//
//  MasterViewController.h
//  WorldCupScores
//
//  Created by Benjamin Hendricks on 6/20/14.
//  Copyright (c) 2014 Benjamin Hendricks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MasterViewController : UITableViewController

@property NSDictionary *data;
@property NSArray *matches;
@property NSMutableArray *pregameMatches;
@property NSMutableArray *finalMatches;
@property NSMutableArray *inprogressMatches;


@end
