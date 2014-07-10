//
//  BNRChangeDateViewController.h
//  Homepwner
//
//  Created by IE Mixes on 5/12/14.
//  Copyright (c) 2014 Big Nerd Ranch. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BNRItem;


@interface BNRChangeDateViewController : UIViewController

@property (nonatomic, strong) BNRItem *item;
@property (strong, nonatomic) UIDatePicker *datePicker;


@end
