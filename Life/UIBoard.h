//
//  UIBoard.h
//  Life
//
//  Created by Kevin Katz on 5/16/16.
//  Copyright © 2016 Kevin Katz. All rights reserved.
//

#ifndef UIBoard_h
#define UIBoard_h

#import "Board.h"
#import <UIKit/UIKit.h>

@interface UIBoard : UIView

@property (strong, atomic) NSNumber * cellWidth;
@property (strong, atomic) Board * board;
- (instancetype)initWithFrame:(CGRect)frame andCellWidth:(NSNumber *) cellWidth;

@end

#endif /* UIBoard_h */
