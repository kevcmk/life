//
//  Board.h
//  Life
//
//  Created by Kevin Katz on 5/14/16.
//  Copyright © 2016 Kevin Katz. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef Board_h
#define Board_h

@interface Board : NSObject

@property (strong, atomic) NSMutableArray * elts;
@property (strong, readonly, nonatomic) NSNumber * width;
@property (strong, readonly, nonatomic) NSNumber * height;


// Take a board and return an update according to Conway's game of life.
+ (instancetype) golStep: (Board *) currentState;

+ (instancetype) matrixAdd: (Board *) a With: (Board *) b AndXSkew: (NSNumber *) xSkew AndYSkew: (NSNumber *) ySkew;


// Initialize
- (instancetype) initWithHeight: (NSNumber *) height andWidth: (NSNumber *) width;

// Get/Set by index
- (void) setRow: (NSNumber *) row andColumn: (NSNumber *) column toValue: (NSNumber *) value;
- (NSNumber *) getRow: (NSNumber *) row andColumn: (NSNumber *) column;

// Randomize values with approximate density [0,1]
- (void) randomize: (NSNumber *) density;



@end


#endif /* Board_h */
