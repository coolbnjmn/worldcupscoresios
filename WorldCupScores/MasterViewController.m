//
//  MasterViewController.m
//  WorldCupScores
//
//  Created by Benjamin Hendricks on 6/20/14.
//  Copyright (c) 2014 Benjamin Hendricks. All rights reserved.
//

#import "MasterViewController.h"

#import "DetailViewController.h"

@interface MasterViewController () {
    NSMutableArray *_objects;
    UIRefreshControl *_refreshControl;
    int pregameMatchesCount;
    int finalMatchesCount;
    int inprogressMatchesCount;
    
}
@end

@implementation MasterViewController


- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://worldcupscores.herokuapp.com"]];
    
    // ASYNC CODE IF I WANT TO CHANGE TO ASYNC SOMETIME
//    __block NSDictionary *json;
//    [NSURLConnection sendAsynchronousRequest:request
//                                       queue:[NSOperationQueue mainQueue]
//                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
//                               json = [NSJSONSerialization JSONObjectWithData:data
//                                                                      options:0
//                                                                        error:nil];
//                               NSLog(@"Async JSON: %@", json);
//                               _data = json;
//                               
//                               _matches = [_data objectForKey:@"body"];
//                               NSLog(@"matches: %@", _matches);
//
//                           }];
    NSData *theData = [NSURLConnection sendSynchronousRequest:request
                                            returningResponse:nil
                                                        error:nil];
    
    NSArray *newJSON = [NSJSONSerialization JSONObjectWithData:theData
                                                            options:0
                                                              error:nil];
//    NSLog(@"newJSON is : %@", newJSON);
    
//    NSLog(@"matches: %@", _matches);
    NSLog(@"match count: %d", _matches.count);
    
    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"startTime"  ascending:YES];
    newJSON=[newJSON sortedArrayUsingDescriptors:[NSArray arrayWithObjects:descriptor,nil]];
    
    _matches = newJSON;
    _finalMatches = [[NSMutableArray alloc] init];
    _pregameMatches = [[NSMutableArray alloc] init];
    _inprogressMatches = [[NSMutableArray alloc] init];
    
    for(int i = 0; i < _matches.count; i++) {
        if ([[[_matches objectAtIndex:i] objectForKey:@"status"] isEqualToString:@"Final"]) {
            [_finalMatches insertObject:[_matches objectAtIndex:i] atIndex:finalMatchesCount];
            finalMatchesCount++;
        } else if([[[_matches objectAtIndex:i] objectForKey:@"status"] isEqualToString:@"Pre-game"]) {
            [_pregameMatches insertObject:[_matches objectAtIndex:i] atIndex:pregameMatchesCount];
            pregameMatchesCount++;
        } else {
            [_inprogressMatches insertObject:[_matches objectAtIndex:i] atIndex:inprogressMatchesCount];
            inprogressMatchesCount++;
        }
    }
    _refreshControl = [[UIRefreshControl alloc]init];
    [self.tableView addSubview:_refreshControl];
    [_refreshControl addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];


}
- (void)loadData {
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://worldcupscores.herokuapp.com"]];
    
    // ASYNC CODE IF I WANT TO CHANGE TO ASYNC SOMETIME
    //    __block NSDictionary *json;
    //    [NSURLConnection sendAsynchronousRequest:request
    //                                       queue:[NSOperationQueue mainQueue]
    //                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
    //                               json = [NSJSONSerialization JSONObjectWithData:data
    //                                                                      options:0
    //                                                                        error:nil];
    //                               NSLog(@"Async JSON: %@", json);
    //                               _data = json;
    //
    //                               _matches = [_data objectForKey:@"body"];
    //                               NSLog(@"matches: %@", _matches);
    //
    //                           }];
    NSData *theData = [NSURLConnection sendSynchronousRequest:request
                                            returningResponse:nil
                                                        error:nil];
    
    NSArray *newJSON = [NSJSONSerialization JSONObjectWithData:theData
                                                       options:0
                                                         error:nil];
    //    NSLog(@"newJSON is : %@", newJSON);
    
    //    NSLog(@"matches: %@", _matches);
    NSLog(@"match count: %d", _matches.count);
    
    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"startTime"  ascending:YES];
    newJSON=[newJSON sortedArrayUsingDescriptors:[NSArray arrayWithObjects:descriptor,nil]];
    
    _matches = newJSON;
    [_finalMatches removeAllObjects];
    [_pregameMatches removeAllObjects];
    [_inprogressMatches removeAllObjects];
    finalMatchesCount = 0;
    pregameMatchesCount = 0;
    inprogressMatchesCount = 0;
//    _finalMatches = [[NSMutableArray alloc] init];
//    _pregameMatches = [[NSMutableArray alloc] init];
//    _inprogressMatches = [[NSMutableArray alloc] init];
    
    for(int i = 0; i < _matches.count; i++) {
        if ([[[_matches objectAtIndex:i] objectForKey:@"status"] isEqualToString:@"Final"]) {
            [_finalMatches insertObject:[_matches objectAtIndex:i] atIndex:finalMatchesCount];
            finalMatchesCount++;
        } else if([[[_matches objectAtIndex:i] objectForKey:@"status"] isEqualToString:@"Pre-game"]) {
            [_pregameMatches insertObject:[_matches objectAtIndex:i] atIndex:pregameMatchesCount];
            pregameMatchesCount++;
        } else {
            [_inprogressMatches insertObject:[_matches objectAtIndex:i] atIndex:inprogressMatchesCount];
            inprogressMatchesCount++;
        }
    }

}
- (void)refreshTable {
    //TODO: refresh your data
    [self loadData];
    
    [_refreshControl endRefreshing];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender
{
    if (!_objects) {
        _objects = [[NSMutableArray alloc] init];
    }
    [_objects insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0) {
        return inprogressMatchesCount;
    } else if(section == 1) {
        return finalMatchesCount;
    } else {
        return pregameMatchesCount;
    }
    //    return [_matches count];
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionName;
    switch (section)
    {
        case 0:
            sectionName = @"Current Game(s)";
            break;
        case 1:
            sectionName = @"Final Score(s)";
            break;
            // ...
        default:
            sectionName = @"Yet to Start";
            break;
    }
    return sectionName;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *tempHeaderView=[[UIView alloc]initWithFrame:CGRectMake(0,0,320,22)];
    
    
    // This changed:
//    tempHeaderView.backgroundColor = [UIColor colorWithRed:0.25 green:0.51 blue:0.00 alpha:1.0];
    // [UIColor colorWithRed:0.29 green:0.60 blue:0.05 alpha:1.0]
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = tempHeaderView.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithRed:0.25 green:0.51 blue:0.00 alpha:1.0]CGColor], (id)[[UIColor colorWithRed:0.29 green:0.60 blue:0.05 alpha:1.0]CGColor], nil];
    [tempHeaderView.layer insertSublayer:gradient atIndex:0];
    
    //Add label to view
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 22)];
    NSString *sectionName;
    switch (section)
    {
        case 0:
            sectionName = @"Current Game(s)";
            break;
        case 1:
            sectionName = @"Final Score(s)";
            break;
            // ...
        default:
            sectionName = @"Yet to Start";
            break;
    }
    titleLabel.text = sectionName;
    titleLabel.textColor = [UIColor colorWithRed:0.93 green:0.86 blue:0.61 alpha:1.0];
    titleLabel.backgroundColor = [UIColor clearColor];
    [tempHeaderView addSubview:titleLabel];
    return tempHeaderView;
    // Use 'return [tempHeaderView autorelease];' in a non-ARC environment
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
//    cell.backgroundColor = [UIColor colorWithRed:0.94 green:0.84 blue:0.49 alpha:1.0];
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = cell.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithRed:0.94 green:0.84 blue:0.49 alpha:1.0]CGColor], (id)[[UIColor colorWithRed:0.93 green:0.86 blue:0.61 alpha:1.0]CGColor], nil];
    [cell.layer insertSublayer:gradient atIndex:0];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor colorWithRed:0.25 green:0.51 blue:0.00 alpha:1.0];

//    NSDictionary *match = [_matches objectAtIndex:indexPath.row];
    NSDictionary *match;
    if(indexPath.section == 0) {
        match = [_inprogressMatches objectAtIndex:indexPath.row];
    } else if(indexPath.section == 1) {
        match = [_finalMatches objectAtIndex:indexPath.row];
    } else {
        match = [_pregameMatches objectAtIndex:indexPath.row];
    }
    
    NSDictionary *homeTeam = [match objectForKey:@"homeTeamId"];
    NSDictionary *awayTeam = [match objectForKey:@"awayTeamId"];
//    NSString *homeTeamName, *awayTeamName;
//    @try {
//        homeTeamName = [homeTeam objectForKey:@"name"];
//        awayTeamName = [awayTeam objectForKey:@"name"];
//    } @catch (NSException *exception) {
//        homeTeamName = @"";
//        awayTeamName = @"";
//    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@ : %@ %@",[awayTeam objectForKey:@"name"] , [match objectForKey:@"awayScore"], [match objectForKey:@"homeScore"], [homeTeam objectForKey:@"name"]];

    return cell;
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDictionary *match;
        if(indexPath.section == 0) {
            match = [_inprogressMatches objectAtIndex:indexPath.row];
        } else if(indexPath.section == 1) {
            match = [_finalMatches objectAtIndex:indexPath.row];
        } else {
            match = [_pregameMatches objectAtIndex:indexPath.row];
        }
        [[segue destinationViewController] setDetailItem:match];
    }
}

@end
