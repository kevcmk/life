//
//  Board.m
//  Life
//
//  Created by Kevin Katz on 5/14/16.
//  Copyright © 2016 Kevin Katz. All rights reserved.
//

#import "Board.h"
#import <Foundation/Foundation.h>

@implementation Board

@synthesize elts;
@synthesize width;
@synthesize height;

- (instancetype) initWithHeight: (NSNumber *) h andWidth: (NSNumber *) w {
    
    self = [super init];
    height = h;
    width = w;
    if (self) {
        elts = [[NSMutableArray alloc] initWithCapacity:[height intValue]];
        
        for (int i = 0; i < [height intValue]; i++) {
            NSMutableArray * row = [[NSMutableArray alloc] initWithCapacity:[width intValue]];
            for (int j = 0; j < [width intValue]; j++) {
                [row insertObject:@0 atIndex:j];
            }
            [elts insertObject:row atIndex:i];
        }

    }
    return self;
}

- (void) setRow: (NSNumber *) row andColumn: (NSNumber *) column toValue: (NSNumber *) value {
    
    NSMutableArray * rowArray = [self.elts objectAtIndex:[row intValue]];
    [rowArray setObject:value atIndexedSubscript:[column intValue]];
    
}


+ (instancetype) golStep: (Board *) currentState {
    
    // Board * board = [[Board alloc] initWithHeight:[currentState height] andWidth: [currentState height]];
    
    return currentState;
    
}
/*
+ (instancetype) matrixAddA: (Board *) a B: (Board *) b XSkew: (int) xSkew ySkew: (int) ySkew {
    
    int y_count = (int) [a count];
    int x_count = (int) [[a objectAtIndex:0] count];
    
    
    
    NSMutableArray * result = [[NSMutableArray alloc] initWithCapacity:y_count];
    
    for (int i = 0; i < y_count; i++) {
        NSMutableArray * row = [[NSMutableArray alloc] initWithCapacity:x_count];
        for (int j = 0; j < x_count; j++) {
            
            [row insertObject:[NSNumber @0] atIndex:j];
            
            int other_i = i + ySkew;
            int other_j = j + xSkew;
            
            if (other_i < 0 || other_i >= y_count || other_j < 0 || other_j >= x_count) {
                continue;
            } else {
                
                NSNumber * a_val = [[a objectAtIndex:i] objectAtIndex:j];
                NSNumber * b_val = [[a objectAtIndex:other_i] objectAtIndex:other_j];
                NSNumber * sum = @([a_val intValue] + [b_val intValue]);
                
                [[result objectAtIndex:i] setObject:sum atIndex:j];
            }
            
            
        }
        [result insertObject:row atIndex:i];
    }
    return result;
    
}
*/


- (NSString *) description {
    NSMutableString * acc = [NSMutableString string];
    
    [acc appendString:@"\n"];
    for (int i = 0; i < [[self elts] count]; i++) {
        for (int j = 0; j < [[[self elts] objectAtIndex:i] count]; j++) {
            [acc appendFormat: @"%@", [[[self elts] objectAtIndex: i] objectAtIndex: j], nil];
        }
        [acc appendString:@"\n"];
    }
    return [acc description];
    
}






@end
