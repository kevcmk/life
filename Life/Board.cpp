//
//  Board.cpp
//  Life
//
//  Created by Kevin Katz on 5/22/16.
//  Copyright © 2016 Kevin Katz. All rights reserved.
//

#include "Board.hpp"
#include <time.h>       /* time */
#include <stdlib.h>     /* srand, rand */

Board::Board(int h, int w) {
    height = h;
    width = w;
    board = std::vector<cell>(h * w);
}

Board::~Board() {
    
}

Board::cell Board::getElement(int i, int j) {
    return board[i * width + j];
}

void Board::setElement(int i, int j, cell c) {
    board[i * width + j] = c;
}

void Board::randomize(double density) {
    srand (time(NULL));
    
    std::vector<cell>::iterator it;
    for(it=board.begin(); it < board.end(); it++) {
        Board:cell c;
        if (rand() / RAND_MAX < density) {
            c = { true };
        } else {
            c = { false };
        }
        *it = c;
    }
}


    
    /*if ([density doubleValue] <= 0.0 || [density floatValue] > 1.0) {
        density = @0.3;
    }
    double density_f = [density floatValue];
    for (int i = 0; i < [self.height intValue]; i++) {
        for (int j = 0; j < [self.width intValue]; j++) {
            
            double r = ((double)arc4random() / ARC4RANDOM_MAX);
            
            if (r <= density_f) {
                [self setRow:[NSNumber numberWithInt: i] andColumn: [NSNumber numberWithInt: j] toValue:@1];
            } else {
                [self setRow:[NSNumber numberWithInt: i] andColumn: [NSNumber numberWithInt: j] toValue:@0];
            }
        }
    }
}*/

/*
    // Randomize values with approximate density [0,1]
    void randomize(double density);
    
    
    static Board * boardEvolve(Board & board);
    static Board * matrixAdd(Board & a, Board & b, int xSkew, int ySkew);
    
private:
    int width;
    int height;
    std::vector<std::vector<cell>> board;
}; */