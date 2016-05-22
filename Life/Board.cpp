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
        float r = rand() / (float) RAND_MAX;
        if (r < density) {
            c = { true };
        } else {
            c = { false };
        }
        
        *it = c;
    }
}


Board * Board::matrixAdd(Board &a, Board &b, int xSkew, int ySkew) {
    
    // TODO Ensure release!
    Board::Board * result = new Board(a.width, a.height);
    int y_count = a.height;
    int x_count = a.width;
    for (int i = 0; i < y_count; i++) {
        for (int j = 0; j < x_count; j++) {
            int other_i = i + ySkew;
            int other_j = j + xSkew;
            if (other_i < 0 || other_i >= y_count || other_j < 0 || other_j >= x_count) {
                int a_val = a.getElement(i, j).state;
                Board::cell c = { a_val };
                result->setElement(i, j, c);
            } else {
                int a_val = a.getElement(i, j).state;
                int b_val = b.getElement(other_i, other_j).state;
                int sum = a_val + b_val;
                Board::cell c = { sum };
                result->setElement(i, j, c);
            }
        }
    }
    return result;
    
}






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