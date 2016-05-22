//
//  ViewController.m
//  Life
//
//  Created by Kevin Katz on 5/14/16.
//  Copyright © 2016 Kevin Katz. All rights reserved.
//

#import "ViewController.h"
#import "Board.hpp"

@interface ViewController ()

@property Board::Board *board;
@property NSMutableArray * boardCells;

@property (nonatomic) float h_views;
@property (nonatomic) float w_views;
@property (nonatomic) float h_margin;
@property (nonatomic) float w_margin;
@property (nonatomic) float edge;

@property (atomic) Boolean halt;
@property dispatch_queue_t queue;

@end

@implementation ViewController

@synthesize board;
@synthesize boardCells;

@synthesize h_views;
@synthesize w_views;
@synthesize h_margin;
@synthesize w_margin;
@synthesize edge;

@synthesize halt;
@synthesize queue;


-(BOOL)prefersStatusBarHidden{
    return YES;
}

//+ (int) gcd:(int)a and:(int)b {
    //}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void) initializeBoard {
    int (^gcd) (int, int) = ^(int a, int b) {
        // Euclid's method for GCD O(n)
        int t;
        
        while (b != 0) {
            t = b;
            b = a % b;
            a = t;
        }
        return a;
        
    };
    self.edge = gcd(self.view.frame.size.width, self.view.frame.size.height);
    NSLog(@"GCD of %f and %f is %f", self.view.frame.size.width, self.view.frame.size.height, self.edge, nil);
    if (self.edge < 8) {
        /* If GCD is too small, increase it and fall back to margins */
        self.edge = 8.0;
    } else if (self.edge >= 40 && (int) self.edge % 2 == 0) {
        /* GCD is too big, and it's even.  Cut it in half */
        self.edge = self.edge / 2.0;
    }
    self.edge = 4.0;
    
    float w = self.view.frame.size.width;
    float h = self.view.frame.size.height;
    
    self.w_views = w / self.edge;
    self.h_views = h / self.edge;
    
    self.w_margin = (float) ((int) w % (int) self.edge) / 2;
    self.h_margin = (float) ((int) h % (int) self.edge) / 2;
    
    self.boardCells = [NSMutableArray arrayWithCapacity: (NSUInteger) ((int) self.w_views * (int) self.h_views)];
    
    /* Initialize and store views */
    for (int i = 0; i < (int) self.h_views; i++) {
        // Top to Bottom
        
        for (int j = 0; j < (int) self.w_views; j++) {
            // Left to Right
            
            // Set view frame
            CGRect rect = CGRectMake(self.w_margin + j * self.edge, self.h_margin + i * self.edge, self.edge, self.edge);
            UIView * view = [[UIView alloc] initWithFrame:rect];
            
            //NSInteger viewTag = (NSInteger) (i * self.w_views + j);
            //view.tag = viewTag;
            
            [self.view addSubview:view];
            [self.boardCells insertObject:view atIndex: (NSUInteger) (i * (int) self.w_views + j)];
            
        }
        
    }
        
    self.board = new Board::Board(self.h_views, self.w_views);
    self.board->randomize(0.3);
        
    
//
//    Board::Board * board1 = new Board::Board(4,4);
//    Board::Board * board2 = new Board::Board(4,4);
//    board1->setElement(1,1,Board::makeCell(1));
//    board1->setElement(1,3,Board::makeCell(1));
//    board2->setElement(1,1,Board::makeCell(1));
//    board2->setElement(1,3,Board::makeCell(1));
//    
//    Board::matrixAdd(*board1, *board2, 1, 0);
//    
//    for (int i = 0; i < 4; i++) {
//        NSLog(@"%d %d %d %d", board1->getElement(i, 0).state, board1->getElement(i, 1).state, board1->getElement(i, 2).state, board1->getElement(i, 3).state, nil);
//    }
//    
//    
//    self.board = new Board::Board((int) self.h_views, (int) self.w_views);

//    self.board->randomize(0.3);
//    for (int i = 0; i < (int) self.h_views; i++) {
//        for (int j = 0; j < (int) self.w_views; j++) {
//            NSLog(@"%d", self.board->getElement(i,j).state);
//        }
//    }
    
    
}

- (void) render: (Board *) board {
    // Set view colors according to board board (w,h) == Board (w_views, h_views)
    
    UIColor * yesColor = [UIColor blackColor];
    UIColor * noColor = [UIColor whiteColor];

    for (int i = 0; i < (int) self.h_views; i++) {
        for (int j = 0; j < (int) self.w_views; j++) {
            UIView * view = [self.boardCells objectAtIndex: (NSInteger) (i * (int) self.w_views + j)];
            if (self.board->getElement(i, j).state) {
                [view setBackgroundColor:yesColor];
            } else {
                [view setBackgroundColor:noColor];
            }
        }
    }

}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self initializeBoard];
    [self render: self.board];
    
    self.halt = NO;
    [self update];

    
    
    /*
    for (int i = 0; i < (int) self.h_views; i++) {
       
        for (int j = 0; j < (int) self.w_views; j++) {
            UIView * view = [self.view viewWithTag: (i * self.w_views + j)];

                UIColor * color = [UIColor colorWithRed:1.0 green:0.0 blue: 0.0 alpha:1.0];
                [view setBackgroundColor: color];
            }
        }
       
    }
    */

}

- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self stopEventLoop];
    
}

- (void) update {
    NSLog(@"Update called.");
    /* Execute board updates on global queue */
    self.queue = dispatch_queue_create("boardQueue", NULL);
    
    if (self.queue) {
        dispatch_async(self.queue, ^{
            NSLog(@"[Async] Evolve called...");
            Board::Board * oldBoard = self.board;
            self.board = new Board::Board(*self.board);
            delete oldBoard;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"[Async] Main loop fxn called, rendering.");
                [self render:self.board];
                if (!self.halt) {
                    NSLog(@"Self.halt false, calling update\n");
                    [self update];
                }
            });
        });
    }
    
}

- (void) stopEventLoop {
    NSLog(@"stopEventLoop called!");
}

- (void) awakeFromNib {
    [super awakeFromNib];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
