//
//  BNRChangeDateViewController.m
//  Homepwner
//
//  Created by IE Mixes on 5/12/14.
//  Copyright (c) 2014 Big Nerd Ranch. All rights reserved.
//

#import "BNRChangeDateViewController.h"
#import "BNRItem.h"
#import "BNRDetailViewController.h"

@interface BNRChangeDateViewController ()
@end

@implementation BNRChangeDateViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // allocate and initilize date picker and set frame
    _datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 50, 200, 100)];
    
    // sets the date picker's mode
    _datePicker.datePickerMode = UIDatePickerModeDate;
    
    // sets the date picker's date to the date of the item on previous view
    _datePicker.date = self.item.dateCreated;
    
    // configures action for date picker
    [_datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
    
    // add date picker to view
    [self.view addSubview:_datePicker];
    

    NSLog(@"View Loaded");
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self.datePicker endEditing:YES];
    
    BNRItem *item = self.item;
    [item changeDate: self.datePicker.date];
  
    NSLog(@"View Popped");
}


-(IBAction)dateChanged:(id)sender
{
    NSLog(@"Date Selected");
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
