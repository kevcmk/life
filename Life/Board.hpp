//
//  Board.hpp
//  Life
//
//  Created by Kevin Katz on 5/22/16.
//  Copyright © 2016 Kevin Katz. All rights reserved.
//

#ifndef Board_hpp
#define Board_hpp

#include <stdio.h>
#include <vector>

class Board {
    public:
        struct cell {
            int state;
        };
        
        Board(int height, int width);
        Board(Board::Board &b); // Evolve board constructor
        ~Board();
    
        cell getElement(int i, int j);
        void setElement(int i, int j, cell c);
    
        void randomize(double density); // Randomize values with approximate density [0,1]
    
        static void matrixAdd(Board &base, Board &add, int xSkew, int ySkew);
        static cell makeCell(int state);
    
    private:
        int width;
        int height;
        std::vector<cell> board; /* On stack! */
};


#endif /* Board_hpp */
