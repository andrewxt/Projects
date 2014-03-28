//
//  ACViewController.h
//  tagProject
//
//  Created by Andrew Christie on 3/24/14.
//  Copyright (c) 2014 Andrew Christie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ACViewController : UIViewController <UIPickerViewDataSource,UIPickerViewDelegate>

@property (strong, nonatomic) IBOutlet UILabel *numberOfUsers;
@property (strong, nonatomic) IBOutlet UILabel *numberOfTagsSent;
@property (strong, nonatomic) IBOutlet UILabel *numberOfTagsRecieved;
@property (strong, nonatomic) IBOutlet UIPickerView *datePicker;
@property (strong, nonatomic) IBOutlet NSArray *dateArray;

@end
