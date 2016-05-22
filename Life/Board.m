////
////  Board.m
////  Life
////
////  Created by Kevin Katz on 5/14/16.
////  Copyright © 2016 Kevin Katz. All rights reserved.
////
//
//#import "Board.h"
//#import <Foundation/Foundation.h>
//
///* Thanks for random fxn to: http://stackoverflow.com/a/5172449 */
//#define ARC4RANDOM_MAX      0x100000000
//
//@implementation Board
//
//@synthesize elts;
//@synthesize width;
//@synthesize height;
//
///* Model */
//
//- (instancetype) initWithHeight: (NSNumber *) h andWidth: (NSNumber *) w {
//    
//    self = [super init];
//    
//    height = h;
//    width = w;
//    if (self) {
//        elts = [[NSMutableArray alloc] initWithCapacity:[height intValue]];
//        
//        for (int i = 0; i < [height intValue]; i++) {
//            NSMutableArray * row = [[NSMutableArray alloc] initWithCapacity:[width intValue]];
//            for (int j = 0; j < [width intValue]; j++) {
//                [row insertObject:@0 atIndex:j];
//            }
//            [elts insertObject:row atIndex:i];
//        }
//
//    }
//    return self;
//}
//
//- (void) setRow: (NSNumber *) row andColumn: (NSNumber *) column toValue: (NSNumber *) value {
//    NSMutableArray * rowArray = [self.elts objectAtIndex:[row intValue]];
//    [rowArray setObject:value atIndexedSubscript:[column intValue]];
//}
//- (NSNumber *) getRow: (NSNumber *) row andColumn: (NSNumber *) column {
//    NSMutableArray * rowArray = [self.elts objectAtIndex:[row intValue]];
//    return [rowArray objectAtIndex:[column intValue]];
//}
//
//
//+ (instancetype) boardEvolveWithBoard: (Board *) currentState {
//    
//    Board * board = [[Board alloc] initWithHeight:currentState.height andWidth:currentState.width];
//    Board * sums = [[Board alloc] initWithHeight:currentState.height andWidth:currentState.width];
//    
//    sums = [Board matrixAdd:sums With:currentState AndXSkew:@-1 AndYSkew:@-1];
//    sums = [Board matrixAdd:sums With:currentState AndXSkew:@-1 AndYSkew:@0];
//    sums = [Board matrixAdd:sums With:currentState AndXSkew:@-1 AndYSkew:@1];
//    
//    sums = [Board matrixAdd:sums With:currentState AndXSkew:@0 AndYSkew:@-1];
//    sums = [Board matrixAdd:sums With:currentState AndXSkew:@0 AndYSkew:@1];
//    
//    sums = [Board matrixAdd:sums With:currentState AndXSkew:@1 AndYSkew:@-1];
//    sums = [Board matrixAdd:sums With:currentState AndXSkew:@1 AndYSkew:@0];
//    sums = [Board matrixAdd:sums With:currentState AndXSkew:@1 AndYSkew:@1];
//    
//    for (int i = 0; i < [currentState.height intValue]; i++) {
//        for (int j = 0; j < [currentState.width intValue]; j++) {
//            NSNumber * iNum = [NSNumber numberWithInt:i];
//            NSNumber * jNum = [NSNumber numberWithInt:j];
//            
//            
//            if ([[currentState getRow:iNum andColumn:jNum] isEqualToNumber:@0]) {
//                // Current State is inactive, grow if there are precisely 3 neighbors
//                
//                if ([[sums getRow:iNum andColumn:jNum] isEqualToNumber:@3]) {
//                    [board setRow:iNum andColumn:jNum toValue:@1];
//                }
//                
//            } else {
//                // Current State is active, grow if there are 2 or 3 neighbors
//                
//                if ([[sums getRow:iNum andColumn:jNum] isEqualToNumber:@2] ||
//                    [[sums getRow:iNum andColumn:jNum] isEqualToNumber:@3]) {
//                    [board setRow:iNum andColumn:jNum toValue:@1];
//                }
//                
//            }
//            
//        }
//    }
//    
//    
//    return board;
//    
//}
//
//+ (instancetype) matrixAdd: (Board *) a With: (Board *) b AndXSkew: (NSNumber *) xSkew AndYSkew: (NSNumber *) ySkew {
//    // Add Matrix A + B, skewing B's values right by XSkew, and up by YSkew.
//    
//    
//    //NSLog(@"Adding\n%@", [a description], nil);
//    // NSLog(@"And\n%@\n", [b description]);
//    
//    Board * result = [[Board alloc] initWithHeight:a.height andWidth:a.width];
//    int y_count = [a.height intValue];
//    int x_count = [a.width intValue];
//    
//    // +1 is necessary to get right query for right-most and bottom-most squares
//    for (int i = 0; i < y_count; i++) {
//        for (int j = 0; j < x_count; j++) {
//            
//            int other_i = i + [ySkew intValue];
//            int other_j = j + [xSkew intValue];
//            
//            if (other_i < 0 || other_i >= y_count || other_j < 0 || other_j >= x_count) {
//            
//                int a_val = [[a getRow:[NSNumber numberWithInt:i]
//                             andColumn:[NSNumber numberWithInt:j]] intValue];
//                [result setRow: [NSNumber numberWithInt:i] andColumn:[NSNumber numberWithInt:j] toValue:@(a_val)];
//            } else {
//                
//                int a_val = [[a getRow:[NSNumber numberWithInt:i]
//                            andColumn:[NSNumber numberWithInt:j]] intValue];
//                int b_val = [[b getRow:[NSNumber numberWithInt:other_i]
//                            andColumn:[NSNumber numberWithInt:other_j]] intValue];
//                NSNumber * sum = @(a_val + b_val);
//                [result setRow: [NSNumber numberWithInt:i] andColumn:[NSNumber numberWithInt:j] toValue:sum];
//            }
//        }
//    }
// 
//    return result;
//    
//}
//
//
//
//- (void) randomize: (NSNumber *) density {
//    if ([density doubleValue] <= 0.0 || [density floatValue] > 1.0) {
//        density = @0.3;
//    }
//    double density_f = [density floatValue];
//    for (int i = 0; i < [self.height intValue]; i++) {
//        for (int j = 0; j < [self.width intValue]; j++) {
//
//            double r = ((double)arc4random() / ARC4RANDOM_MAX);
//            
//            if (r <= density_f) {
//                [self setRow:[NSNumber numberWithInt: i] andColumn: [NSNumber numberWithInt: j] toValue:@1];
//            } else {
//                [self setRow:[NSNumber numberWithInt: i] andColumn: [NSNumber numberWithInt: j] toValue:@0];
//            }
//        }
//    }
//}
//
//
//- (NSString *) description {
//    NSMutableString * acc = [NSMutableString string];
//    
//    [acc appendString:@"\n"];
//    for (int i = 0; i < [[self elts] count]; i++) {
//        for (int j = 0; j < [[[self elts] objectAtIndex:i] count]; j++) {
//            [acc appendFormat: @"%@", [[[self elts] objectAtIndex: i] objectAtIndex: j], nil];
//        }
//        [acc appendString:@"\n"];
//    }
//    return [acc description];
//    
//}
//
//
//@end
