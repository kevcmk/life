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


/* https://www.sitepoint.com/using-c-and-c-in-an-ios-app-with-objective-c/ */



Board::Board(int h, int w) {
    /* Blank constructor */
    height = h;
    width = w;
    board = std::vector<cell>(height * width);
}

Board::Board(Board::Board &previousState) {
    /* Evolve constructor */
    height = previousState.height;
    width = previousState.width;
    board = std::vector<cell>(height * width);
    
    Board::Board * sums = new Board::Board(previousState.height, previousState.width);
    
    Board::matrixAdd(*sums, previousState, -1, -1);
    Board::matrixAdd(*sums, previousState, -1, 0);
    Board::matrixAdd(*sums, previousState, -1, 1);
    
    Board::matrixAdd(*sums, previousState, 0, -1);
    Board::matrixAdd(*sums, previousState, 0, 1);
    
    Board::matrixAdd(*sums, previousState, 1, -1);
    Board::matrixAdd(*sums, previousState, 1, 0);
    Board::matrixAdd(*sums, previousState, 1, 1);
    
    for (int i = 0; i < previousState.height; i++) {
        for (int j = 0; j < previousState.width; j++) {
            if (previousState.getElement(i, j).state == 0) {
                // Current State is inactive, grow if there are precisely 3 neighbors
                if (sums->getElement(i,j).state == 3) {
                    setElement(i,j, makeCell(1));
                }
            } else {
                // Current State is active, grow if there are 2 or 3 neighbors
                if (sums->getElement(i,j).state == 2 || sums->getElement(i,j).state == 3) {
                    setElement(i,j, makeCell(1));
                }
            }
        }
    }
    delete sums;
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
        float r = rand() / (float) RAND_MAX;
        *it = makeCell(r < density ? 1 : 0);
    }
}

// Static Methods
void Board::matrixAdd(Board &base, Board &add, int xSkew, int ySkew) {
    /* Add board b to board a, in place. */
    // TODO Ensure release!
    int y_count = base.height;
    int x_count = base.width;
    for (int i = 0; i < y_count; i++) {
        for (int j = 0; j < x_count; j++) {
            int other_i = i + ySkew;
            int other_j = j + xSkew;
            bool invalid = other_i < 0 || other_i >= y_count || other_j < 0 || other_j >= x_count;
            if (!invalid) {
                
                int base_val = base.getElement(i, j).state;
                int add_val = add.getElement(other_i, other_j).state;
                if (base_val || add_val) {
                    ;
                }
                base.setElement(i, j, makeCell(base_val + add_val));
            }
        }
    }
    
}

Board::cell Board::makeCell(int state) {
    Board::cell c = { state };
    return c;
}



