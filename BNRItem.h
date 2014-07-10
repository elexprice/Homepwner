//
//  BNRItem.h
//  RandomItems
//
//  Created by Elex Price on 3/5/14.
//  Copyright (c) 2014 Big Nerd Ranch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BNRItem : NSObject
{

}

@property (nonatomic, copy) NSString *itemName;
@property (nonatomic, copy) NSString *serialNumber;
@property (nonatomic) int valueInDollars;
@property (nonatomic, readonly, strong) NSDate *dateCreated;

@property (nonatomic, copy) NSString *itemKey;


+(instancetype)randomItem;

// Designated Initalizer for BNRItem
-(instancetype)initWithItemName: (NSString *)name
                 valueInDollars:(int) value
                   serialNumber: (NSString *) sNumber;

-(instancetype)initWithItemName:(NSString *)name;

-(void)changeDate:(NSDate *)dateCreated;

@end
