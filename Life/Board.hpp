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
            bool state;
        };
        
        Board(int height, int width);
        ~Board();
        
        cell getElement(int i, int j);
        void setElement(int i, int j, cell c);
        
        // Randomize values with approximate density [0,1]
        void randomize(double density);
        
        
        static Board * boardEvolve(Board & board);
        static Board * matrixAdd(Board & a, Board & b, int xSkew, int ySkew);
        
    private:
        int width;
        int height;
        std::vector<cell> board; /* On stack! */
};


#endif /* Board_hpp */
