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
- (NSNumber *) getRow: (NSNumber *) row andColumn: (NSNumber *) column {
    NSMutableArray * rowArray = [self.elts objectAtIndex:[row intValue]];
    return [rowArray objectAtIndex:[column intValue]];
}


+ (instancetype) golStep: (Board *) currentState {
    
    // Board * board = [[Board alloc] initWithHeight:[currentState height] andWidth: [currentState height]];
    
    return currentState;
    
}

+ (instancetype) matrixAdd: (Board *) a With: (Board *) b AndXSkew: (NSNumber *) xSkew AndYSkew: (NSNumber *) ySkew {
    // Add Matrix A + B, skewing B's values right by XSkew, and up by YSkew.
    
    Board * result = [[Board alloc] initWithHeight:a.height andWidth:a.width];
    int y_count = [a.height intValue];
    int x_count = [a.width intValue];
    
    for (int i = 0; i < y_count; i++) {
        for (int j = 0; j < x_count; j++) {
            
            int other_i = i + [ySkew intValue];
            int other_j = j + [xSkew intValue];
            
            if (other_i < 0 || other_i >= y_count || other_j < 0 || other_j >= x_count) {
                continue;
            } else {
                
                int a_val = [[a getRow:[NSNumber numberWithInt:i]
                            andColumn:[NSNumber numberWithInt:j]] intValue];
                int b_val = [[a getRow:[NSNumber numberWithInt:other_i]
                            andColumn:[NSNumber numberWithInt:other_j]] intValue];
                NSNumber * sum = @(a_val + b_val);
                NSLog([NSString stringWithFormat:@"Setting @% and @% to @%", i, j, sum, nil]);
                [result setRow: [NSNumber numberWithInt:i] andColumn:[NSNumber numberWithInt:j] toValue:sum];
            }
        }
    }
    return result;
    
}



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
