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


+ (instancetype) golStep: (Board *) currentState;
// + (instancetype) matrixAddA: (Board *) a B: (Board *) b XSkew: (int) xSkew ySkew: (int) ySkew;

- (instancetype) initWithHeight: (NSNumber *) height andWidth: (NSNumber *) width;
- (void) setRow: (NSNumber *) row andColumn: (NSNumber *) column toValue: (NSNumber *) value;


@end


#endif /* Board_h */
