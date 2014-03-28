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

@end

@implementation ACViewController

#pragma mark - UIPickerView DataSource
// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [_dateArray count];
}

#pragma mark - UIPickerView Delegate
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 30.0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [_dateArray objectAtIndex:row];
}

//If the user chooses from the pickerview, it calls this function;
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    //Let's print in the console what the user had chosen;
//    if (_dateArray objectAtIndex:0) {
//        PFQuery *userCountQuery = [PFUser query];
//        [userCountQuery countObjectsInBackgroundWithBlock:^(int userCount, NSError *error) {
//            if (!error) {
//                // The count request succeeded. Log the count
//                //     NSLog(@"There are %d users", userCount);
//            } else {
//                // The request failed
//            }
//            NSString *actualNumberOfUsers = [[NSString alloc]initWithFormat:@"%i", userCount ];
//            self.numberOfUsers.text = actualNumberOfUsers;
//        }];
//
//    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.datePicker.delegate = self;
    self.datePicker.dataSource = self;
    
    _dateArray = [[NSArray alloc]initWithObjects:@"Past 24 Hours", @"Past Week", @"Past Month", nil];
    
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
    
    //Number of Tags sent
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
    
    //Number of Tag Recipients
    PFQuery *receivingUserQuery = [PFQuery queryWithClassName:@"NewMarcoPolo"];
    [receivingUserQuery whereKey:@"receivingUsers" greaterThan:@0];
    [receivingUserQuery findObjectsInBackgroundWithBlock:^(NSArray *receivingUsers, NSError *error) {
        NSNumber *receivingUsersAmount = [NSNumber numberWithInt:0];
        for (PFObject *obj in receivingUsers) {
            receivingUsersAmount = [NSNumber numberWithInt:[receivingUsersAmount intValue] + [(NSArray *)[obj objectForKey:@"receivingUsers"] count]];
        }
        NSString *tagsReceived = [[NSString alloc]initWithFormat:@"%@", receivingUsersAmount];
        self.numberOfTagsRecieved.text = tagsReceived;
      //  NSLog(@"There has been %@ tag recipients", receivingUsersAmount);
        //NSLog(@"receivingusers %i", receivingUserQuery);

    }];
    
//    //Top 10 users with most tags
//    PFQuery *topTenQuery = [PFQuery queryWithClassName:@"NewMarcoPolo"];
//    //[topTenQuery whereKey:@"wins" greaterThan:@150];
//    [topTenQuery orderByAscending:@"receivingUsers"];
//    [topTenQuery countObjectsInBackgroundWithBlock:^(int tagCount, NSError *error) {
//        if (!error) {
//            // The count request succeeded. Log the count
//            NSLog(@"Top 10 %d tags sent", tagCount);
//        } else {
//            // The request failed
//        }
//    }];
    
    //Number of Tag Recipients
    
//    [PFCloud callFunctionInBackground:@"NewMarcoPolo"
//                       withParameters:@{@"array": @"receivingUsers"}
//                                block:^(NSNumber *ratings, NSError *error) {
//                                    if (!error) {
//                                        // ratings is 4.5
//                                    }
//                                }];
    
    PFQuery *topTenQuery = [PFQuery queryWithClassName:@"NewMarcoPolo"];
    [topTenQuery includeKey:@"receivingUsers"]; // Force parse to include the user objects of receivers
    [topTenQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
           // NSLog(@"Successfully retrieved %lu scores.", (unsigned long)objects.count);
            // Do something with the found objects
            for (PFObject *object in objects) {
                // Write to log the email of every receiver
                for (PFUser *receiver in object[@"receivingUsers"]) {
                    [receiver fetchIfNeeded]; // fetches the object if it is still just a pointer (just a safety; it should be already included by the includeKey call earlier in the code
                   // NSLog(@"Receiver: %@", receiver[@"email"]);
                }
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
    //Date
    
    NSTimeInterval secondsPerDay = 24 * 60 * 60;
    
    NSDate *tomorrow = [[NSDate alloc]
                        initWithTimeIntervalSinceNow:secondsPerDay];
    NSDate *yesterday = [[NSDate date] dateByAddingTimeInterval:-60*60*24];
    NSDate *lastWeek = [[NSDate alloc]initWithTimeIntervalSinceNow:-secondsPerDay * 7];
    
    NSDate *lastMonth = [[NSDate alloc]initWithTimeIntervalSinceNow:-secondsPerDay * 30];



    PFQuery *dateQuery = [PFQuery queryWithClassName:@"NewMarcoPolo"];
    [dateQuery whereKey:@"updatedAt" greaterThan:yesterday];
    [dateQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
          // NSLog(@"Successfully retrieved %d scores.", objects.count);
            // Do something with the found objects
            for (PFObject *object in objects) {
                NSLog(@"%@", object.createdAt);
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
        
        NSLog(@"%@", dateQuery);
    }];

    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//#pragma mark - UIPickerView DataSource
//// returns the number of 'columns' to display.
//- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
//{
//    return 1;
//}
//
//// returns the # of rows in each component..
//- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
//{
//    return [_dateArray count];
//}
//
//#pragma mark - UIPickerView Delegate
//- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
//{
//    return 30.0;
//}
//
//- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
//{
//    return [_dateArray objectAtIndex:row];
//}
//
////If the user chooses from the pickerview, it calls this function;
//- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
//{
//    //Let's print in the console what the user had chosen;
//    
//    }
//    
//    NSLog(@"Chosen item: %@", [_dateArray objectAtIndex:row]);
//}
@end
