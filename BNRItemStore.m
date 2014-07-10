//
//  BNRItemStore.m
//  Homepwner
//
//  Created by Elex Price on 3/17/14.
//  Copyright (c) 2014 Big Nerd Ranch. All rights reserved.
//

#import "BNRItemStore.h"
#import "BNRItem.h"
#import "BNRImageStore.h"

@interface BNRItemStore ()

@property (nonatomic) NSMutableArray *privateItems;

@end

@implementation BNRItemStore


+(instancetype)sharedStore
{
    static BNRItemStore *sharedStore = nil;
    
    // Do I need to create a sharedStore?
    if (!sharedStore) {
        sharedStore = [[self alloc] initPrivate];
    }
    
    return sharedStore;
}

// If a programmer calls [[BNRItemStore allc] init], let them
// know the error of his ways
-(instancetype)init
{
    @throw [NSException exceptionWithName:@"Singleton"
                                   reason:@"Use +[BNRItemStore shareStore]"
                                 userInfo:nil];
    return nil;
}

// Here is the real (secret) initializer
-(instancetype)initPrivate
{
    self = [super init];
    
    if (self) {
        _privateItems = [[NSMutableArray alloc]init];
    }
    
    return self;
}

-(NSArray *)allItems
{
    return self.privateItems;
}

-(BNRItem *)createItem
{
    BNRItem *item = [BNRItem randomItem];
    
    [self.privateItems addObject:item];
    
    return item;
}

-(void)removeItem:(BNRItem *)item
{
    NSString *key = item.itemKey;
    
    [[BNRImageStore sharedStore] deleteImageForKey:key];
    
    [self.privateItems removeObject:item];
}

-(void)moveItemAtIndex:(NSUInteger)fromIndex toThisIndex:(NSUInteger)toIndex
{
    if (fromIndex == toIndex) {
        return;
    }
    
    // Get pointer to object being moved so you can reinsert it
    BNRItem *item = self.privateItems[fromIndex];
    
    // Remove item from array
    [self.privateItems removeObjectAtIndex:fromIndex];
    
    // Insert item in arrat at new location
    [self.privateItems  insertObject:item atIndex:toIndex];
}

@end
