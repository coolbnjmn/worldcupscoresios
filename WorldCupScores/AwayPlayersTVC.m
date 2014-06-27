//
//  AwayPlayersTVC.m
//  WorldCupScores
//
//  Created by Benjamin Hendricks on 6/25/14.
//  Copyright (c) 2014 Benjamin Hendricks. All rights reserved.
//

#import "AwayPlayersTVC.h"

@interface AwayPlayersTVC ()

@end

@implementation AwayPlayersTVC

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSLog(@"printing awayplayers data count");
    NSLog(@"%d", [_data count]);
    return [_data count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"awayPlayer" forIndexPath:indexPath];
    cell.textLabel.text = [[_data objectAtIndex:indexPath.row] objectForKey:@"nickname"];
//    cell.backgroundColor = [UIColor colorWithRed:0.94 green:0.84 blue:0.49 alpha:1.0];
//    cell.textLabel.textColor = [UIColor colorWithRed:0.25 green:0.51 blue:0.00 alpha:1.0];
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = cell.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithRed:0.94 green:0.84 blue:0.49 alpha:1.0]CGColor], (id)[[UIColor colorWithRed:0.93 green:0.86 blue:0.61 alpha:1.0]CGColor], nil];
    [cell.layer insertSublayer:gradient atIndex:0];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor colorWithRed:0.25 green:0.51 blue:0.00 alpha:1.0];
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

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



@end
