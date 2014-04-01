//
//  ACViewController.m
//  tagAssignment
//
//  Created by Andrew Christie on 3/27/14.
//  Copyright (c) 2014 Andrew Christie. All rights reserved.
//

#import <Parse/Parse.h>
#import "ACViewController.h"

@interface ACViewController ()

@end

@implementation ACViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //Number of Users
    PFQuery *userCountQuery = [PFUser query];
    [userCountQuery countObjectsInBackgroundWithBlock:^(int userCount, NSError *error) {
        if (!error) {
            // The count request succeeded. Log the count
            //     NSLog(@"There are %d users", userCount);
        } else {
            // The request failed
        }
        NSString *actualNumberOfUsers = [[NSString alloc]initWithFormat:@"%d", userCount ];
        self.numberOfUsers.text = actualNumberOfUsers;
    }];
    
    //Number of Tags Sent
    PFQuery *tagsSentQuery = [PFQuery queryWithClassName:@"NewMarcoPolo"];
    
    
    [tagsSentQuery countObjectsInBackgroundWithBlock:^(int tagCount, NSError *error) {
        if (!error) {
            // The count request succeeded. Log the count
            //   NSLog(@"There have been %d tags sent", tagCount);
        } else {
            // The request failed
        }
        NSString *tagsSent = [[NSString alloc]initWithFormat:@"%i", tagCount];
        self.numberOfTagsSent.text = tagsSent;
    }];
    
    //Number of Tags Received
    PFQuery *receivingUserQuery = [PFQuery queryWithClassName:@"NewMarcoPolo"];
    //[receivingUserQuery whereKey:@"receivingUsers" greaterThan:@0];
    receivingUserQuery.limit = 1000;
    [receivingUserQuery findObjectsInBackgroundWithBlock:^(NSArray *receivingUsers, NSError *error) {
        NSNumber *receivingUsersAmount = [NSNumber numberWithInt:0];
        for (PFObject *obj in receivingUsers) {
            receivingUsersAmount = [NSNumber numberWithInt:[receivingUsersAmount intValue] + [(NSArray *)[obj objectForKey:@"receivingUsers"] count]];
        }
        NSString *tagsReceived = [[NSString alloc]initWithFormat:@"%@", receivingUsersAmount];
        self.numberOfTagsReceived.text = tagsReceived;
        NSLog(@"There has been %@ tag recipients", receivingUsersAmount);
        
    }];
    
    PFQuery *topTenQuery = [PFQuery queryWithClassName:@"NewMarcoPolo"];
    [topTenQuery orderByAscending:@"sendingUser"];
    topTenQuery.limit = 10;
    [topTenQuery countObjectsInBackgroundWithBlock:^(int tagCount,
                                                     NSError *error) {
        if (!error) {
            // The count request succeeded. Log the count
            NSLog(@"Top 10 %d tags sent", tagCount);
        } else {
                    // The request failed
                }
            }];
        
    NSLog(@"%@", topTenQuery);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
