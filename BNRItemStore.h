//
//  BNRItemStore.h
//  Homepwner
//
//  Created by Elex Price on 3/17/14.
//  Copyright (c) 2014 Big Nerd Ranch. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BNRItem;

@interface BNRItemStore : NSObject

@property (nonatomic, readonly) NSArray *allItems;

// class method
+(instancetype)sharedStore;

-(BNRItem *)createItem;
-(void)removeItem:(BNRItem *)item;
-(void)moveItemAtIndex:(NSUInteger)fromIndex toThisIndex: (NSUInteger) toIndex;


@end
