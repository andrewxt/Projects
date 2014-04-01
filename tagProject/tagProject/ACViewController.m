//
//  ACViewController.m
//  tagProject
//
//  Created by Andrew Christie on 3/24/14.
//  Copyright (c) 2014 Andrew Christie. All rights reserved.
//

#import "ACAppDelegate.h"
#import "Parse/Parse.h"
#import "ACViewController.h"

@interface ACViewController ()

@property (strong, nonatomic) NSArray *timeFrame;

@end

@implementation ACViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSArray *data = [[NSArray alloc] initWithObjects:@"Past 24 Hours", @"Past Week", @"Past Month", @"All Time", nil];
    
    self.timeFrame = data;
    
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *todayComponents = [NSDateComponents new];
    todayComponents.year = 2014;
    todayComponents.month = 2;
    todayComponents.day = 16;
    todayComponents.hour = 4;
    todayComponents.minute = 59;
    todayComponents.second = 50;
    
    NSDate *today = [calendar dateFromComponents:todayComponents];
    
    NSDateComponents *offset = [NSDateComponents new];
    offset.day = -1;
    NSDate *yesterday = [calendar dateByAddingComponents:offset toDate:today options:0];
    
    PFQuery *yesterdayUserCountQuery = [PFUser query];
    [yesterdayUserCountQuery whereKey:@"createdAt" greaterThanOrEqualTo:yesterday];
    [yesterdayUserCountQuery countObjectsInBackgroundWithBlock:^(int userCount, NSError *error) {
        if (!error) {
            // The count request succeeded. Log the count
        } else {
            // The request failed
        }
        NSString *yesterdayNumberOfUsers = [[NSString alloc]initWithFormat:@"%d", userCount ];
        self.numberOfUsers.text = yesterdayNumberOfUsers;
    }];
    
    PFQuery *yesterdaySentQuery = [PFQuery queryWithClassName:@"NewMarcoPolo"];
    [yesterdaySentQuery whereKey:@"createdAt" greaterThanOrEqualTo:yesterday];
    [yesterdaySentQuery countObjectsInBackgroundWithBlock:^(int tagCount, NSError *error) {
        if (!error) {
            // The count request succeeded. Log the count
        } else {
            // The request failed
        }
        NSString *yesterdayTagsSent = [[NSString alloc]initWithFormat:@"%i", tagCount];
        self.numberOfTagsSent.text = yesterdayTagsSent;
    }];
    
    PFQuery *yesterdayReceivingUserQuery = [PFQuery queryWithClassName:@"NewMarcoPolo"];
    [yesterdayReceivingUserQuery whereKey:@"createdAt" greaterThanOrEqualTo:yesterday];
    yesterdayReceivingUserQuery.limit = 1000;
    [yesterdayReceivingUserQuery findObjectsInBackgroundWithBlock:^(NSArray *receivingUsers, NSError *error) {
        NSNumber *receivingUsersAmount = [NSNumber numberWithInt:0];
        for (PFObject *obj in receivingUsers) {
            receivingUsersAmount = [NSNumber numberWithInt:[receivingUsersAmount intValue] + [(NSArray *)[obj objectForKey:@"receivingUsers"] count]];
        }
        NSString *yesterdayTagsReceived = [[NSString alloc]initWithFormat:@"%@", receivingUsersAmount];
        self.numberOfTagsRecieved.text = yesterdayTagsReceived;
        
    }];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showResultsFromYesterday:(id)sender {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *todayComponents = [NSDateComponents new];
    todayComponents.year = 2014;
    todayComponents.month = 2;
    todayComponents.day = 16;
    todayComponents.hour = 4;
    todayComponents.minute = 59;
    todayComponents.second = 50;
    
    NSDate *today = [calendar dateFromComponents:todayComponents];
    
    NSDateComponents *offset = [NSDateComponents new];
    offset.day = -1;
    NSDate *yesterday = [calendar dateByAddingComponents:offset toDate:today options:0];
    
    PFQuery *yesterdayUserCountQuery = [PFUser query];
    [yesterdayUserCountQuery whereKey:@"createdAt" greaterThanOrEqualTo:yesterday];
    [yesterdayUserCountQuery countObjectsInBackgroundWithBlock:^(int userCount, NSError *error) {
        if (!error) {
            // The count request succeeded. Log the count
        } else {
            // The request failed
        }
        NSString *yesterdayNumberOfUsers = [[NSString alloc]initWithFormat:@"%d", userCount ];
        self.numberOfUsers.text = yesterdayNumberOfUsers;
    }];
    
    PFQuery *yesterdaySentQuery = [PFQuery queryWithClassName:@"NewMarcoPolo"];
    [yesterdaySentQuery whereKey:@"createdAt" greaterThanOrEqualTo:yesterday];
    [yesterdaySentQuery countObjectsInBackgroundWithBlock:^(int tagCount, NSError *error) {
        if (!error) {
            // The count request succeeded. Log the count
        } else {
            // The request failed
        }
        NSString *yesterdayTagsSent = [[NSString alloc]initWithFormat:@"%i", tagCount];
        self.numberOfTagsSent.text = yesterdayTagsSent;
    }];
    
    PFQuery *yesterdayReceivingUserQuery = [PFQuery queryWithClassName:@"NewMarcoPolo"];
    [yesterdayReceivingUserQuery whereKey:@"createdAt" greaterThanOrEqualTo:yesterday];
    yesterdayReceivingUserQuery.limit = 1000;
    [yesterdayReceivingUserQuery findObjectsInBackgroundWithBlock:^(NSArray *receivingUsers, NSError *error) {
        NSNumber *receivingUsersAmount = [NSNumber numberWithInt:0];
        for (PFObject *obj in receivingUsers) {
            receivingUsersAmount = [NSNumber numberWithInt:[receivingUsersAmount intValue] + [(NSArray *)[obj objectForKey:@"receivingUsers"] count]];
        }
        NSString *yesterdayTagsReceived = [[NSString alloc]initWithFormat:@"%@", receivingUsersAmount];
        self.numberOfTagsRecieved.text = yesterdayTagsReceived;
        
    }];

}

- (IBAction)showResultsFromLastWeek:(id)sender {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *todayComponents = [NSDateComponents new];
    todayComponents.year = 2014;
    todayComponents.month = 2;
    todayComponents.day = 16;
    todayComponents.hour = 4;
    todayComponents.minute = 59;
    todayComponents.second = 50;
    
    NSDate *today = [calendar dateFromComponents:todayComponents];
    
    NSDateComponents *offset = [NSDateComponents new];
    offset.day = -7;
    NSDate *lastWeek = [calendar dateByAddingComponents:offset toDate:today options:0];
    
    PFQuery *lastWeekUserCountQuery = [PFUser query];
    [lastWeekUserCountQuery whereKey:@"createdAt" greaterThanOrEqualTo:lastWeek];
    [lastWeekUserCountQuery countObjectsInBackgroundWithBlock:^(int userCount, NSError *error) {
        if (!error) {
            // The count request succeeded. Log the count
        } else {
            // The request failed
        }
        NSString *lastWeekNumberOfUsers = [[NSString alloc]initWithFormat:@"%d", userCount ];
        self.numberOfUsers.text = lastWeekNumberOfUsers;
    }];
    
    PFQuery *lastWeekSentQuery = [PFQuery queryWithClassName:@"NewMarcoPolo"];
    [lastWeekSentQuery whereKey:@"createdAt" greaterThanOrEqualTo:lastWeek];
    [lastWeekSentQuery countObjectsInBackgroundWithBlock:^(int tagCount, NSError *error) {
        if (!error) {
            // The count request succeeded. Log the count
        } else {
            // The request failed
        }
        NSString *lastWeekTagsSent = [[NSString alloc]initWithFormat:@"%i", tagCount];
        self.numberOfTagsSent.text = lastWeekTagsSent;
    }];
    
    PFQuery *lastWeekReceivingUserQuery = [PFQuery queryWithClassName:@"NewMarcoPolo"];
    [lastWeekReceivingUserQuery whereKey:@"createdAt" greaterThanOrEqualTo:lastWeek];
    lastWeekReceivingUserQuery.limit = 1000;
    [lastWeekReceivingUserQuery findObjectsInBackgroundWithBlock:^(NSArray *receivingUsers, NSError *error) {
        NSNumber *receivingUsersAmount = [NSNumber numberWithInt:0];
        for (PFObject *obj in receivingUsers) {
            receivingUsersAmount = [NSNumber numberWithInt:[receivingUsersAmount intValue] + [(NSArray *)[obj objectForKey:@"receivingUsers"] count]];
        }
        NSString *lastWeekTagsReceived = [[NSString alloc]initWithFormat:@"%@", receivingUsersAmount];
        self.numberOfTagsRecieved.text = lastWeekTagsReceived;
        
    }];
    
    
}

- (IBAction)showResultsFromLastMonth:(id)sender {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *todayComponents = [NSDateComponents new];
    todayComponents.year = 2014;
    todayComponents.month = 2;
    todayComponents.day = 16;
    todayComponents.hour = 4;
    todayComponents.minute = 59;
    todayComponents.second = 50;
    
    NSDate *today = [calendar dateFromComponents:todayComponents];
    
    NSDateComponents *offset = [NSDateComponents new];
    offset.day = -30;
    NSDate *lastMonth = [calendar dateByAddingComponents:offset toDate:today options:0];
    
    PFQuery *lastMonthUserCountQuery = [PFUser query];
    [lastMonthUserCountQuery whereKey:@"createdAt" greaterThanOrEqualTo:lastMonth];
    [lastMonthUserCountQuery countObjectsInBackgroundWithBlock:^(int userCount, NSError *error) {
        if (!error) {
            // The count request succeeded. Log the count
        } else {
            // The request failed
        }
        NSString *lastMonthNumberOfUsers = [[NSString alloc]initWithFormat:@"%d", userCount ];
        self.numberOfUsers.text = lastMonthNumberOfUsers;
    }];
    
    PFQuery *lastMonthSentQuery = [PFQuery queryWithClassName:@"NewMarcoPolo"];
    [lastMonthSentQuery whereKey:@"createdAt" greaterThanOrEqualTo:lastMonth];
    [lastMonthSentQuery countObjectsInBackgroundWithBlock:^(int tagCount, NSError *error) {
        if (!error) {
            // The count request succeeded. Log the count
        } else {
            // The request failed
        }
        NSString *lastMonthTagsSent = [[NSString alloc]initWithFormat:@"%i", tagCount];
        self.numberOfTagsSent.text = lastMonthTagsSent;
    }];
    
    PFQuery *lastMonthReceivingUserQuery = [PFQuery queryWithClassName:@"NewMarcoPolo"];
    [lastMonthReceivingUserQuery whereKey:@"createdAt" greaterThanOrEqualTo:lastMonth];
    lastMonthReceivingUserQuery.limit = 1000;
    [lastMonthReceivingUserQuery findObjectsInBackgroundWithBlock:^(NSArray *receivingUsers, NSError *error) {
        NSNumber *receivingUsersAmount = [NSNumber numberWithInt:0];
        for (PFObject *obj in receivingUsers) {
            receivingUsersAmount = [NSNumber numberWithInt:[receivingUsersAmount intValue] + [(NSArray *)[obj objectForKey:@"receivingUsers"] count]];
        }
        NSString *lastMonthTagsReceived = [[NSString alloc]initWithFormat:@"%@", receivingUsersAmount];
        self.numberOfTagsRecieved.text = lastMonthTagsReceived;
        
    }];
    
    
    
}

- (IBAction)showResultsFromAllTime:(id)sender {
    
    PFQuery *userCountQuery = [PFUser query];
    [userCountQuery countObjectsInBackgroundWithBlock:^(int userCount, NSError *error) {
        if (!error) {
            // The count request succeeded. Log the count
        } else {
            // The request failed
        }
        NSString *actualNumberOfUsers = [[NSString alloc]initWithFormat:@"%d", userCount ];
        self.numberOfUsers.text = actualNumberOfUsers;
    }];
    
    //Number of Tags sent
    PFQuery *tagsSentQuery = [PFQuery queryWithClassName:@"NewMarcoPolo"];
    [tagsSentQuery countObjectsInBackgroundWithBlock:^(int tagCount, NSError *error) {
        if (!error) {
            // The count request succeeded. Log the count
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
        self.numberOfTagsRecieved.text = tagsReceived;
        
    }];
    
}



#pragma mark Picker Data Source Methods

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 1;
    
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return [_timeFrame count];
    
}

#pragma mark Picker Delegate Methods

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return _timeFrame[row];
    
}

-(void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    switch (row) {
        case 0:
            [self showResultsFromYesterday:self];
            break;
        case 1:
            [self showResultsFromLastWeek:self];
            break;
        case 2:
            [self showResultsFromLastMonth:self];
            break;
        case 3:
            [self showResultsFromAllTime:self];
        default:
            break;
    }
}
@end
