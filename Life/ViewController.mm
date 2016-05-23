//
//  ViewController.m
//  Life
//
//  Created by Kevin Katz on 5/14/16.
//  Copyright © 2016 Kevin Katz. All rights reserved.
//

#import "ViewController.h"
#import "Board.hpp"
#import <tgmath.h>

/* http://stackoverflow.com/a/5172449 */
#define ARC4RANDOM_MAX      0x100000000


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

- (void)viewDidLoad {
    [super viewDidLoad];
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveViewWithGestureRecognizer:)];
    [self.view addGestureRecognizer:panGestureRecognizer];
}

-(void)moveViewWithGestureRecognizer:(UIPanGestureRecognizer *)panGestureRecognizer {
    /* Thanks to this article: http://www.appcoda.com/ios-gesture-recognizers/ */
    CGPoint touchLocation = [panGestureRecognizer locationInView:self.view];
    
    /* hitTest is slower than arithmetic in determining touched cell */
    int cell_i = (int) ((touchLocation.y - self.h_margin) / self.edge);
    int cell_j = (int) ((touchLocation.x - self.w_margin) / self.edge);
    
    //  ***
    // *****
    // *****
    // *****
    //  ***
    for (int dy = -2; dy <= 2; dy++) {
        for (int dx = -2; dx <= 2; dx++) {
            int x = cell_j + dx;
            int y = cell_i + dy;
            if (0 <= y && y < self.h_views && 0 <= x && x < self.w_views) {
                self.board->setElement(y, x, Board::makeCell(1));
            }
        }
    }
    
}

- (void) initializeBoard {
//    int (^gcd) (int, int) = ^(int a, int b) {
//        // Euclid's method for GCD O(n)
//        int t;
//        
//        while (b != 0) {
//            t = b;
//            b = a % b;
//            a = t;
//        }
//        return a;
//        
//    };
//    self.edge = gcd(self.view.frame.size.width, self.view.frame.size.height);
//    NSLog(@"GCD of %f and %f is %f", self.view.frame.size.width, self.view.frame.size.height, self.edge, nil);
//    if (self.edge < 8) {
//        /* If GCD is too small, increase it and fall back to margins */
//        self.edge = 8.0;
//    } else if (self.edge >= 40 && (int) self.edge % 2 == 0) {
//        /* GCD is too big, and it's even.  Cut it in half */
//        self.edge = self.edge / 2.0;
//    }
    self.edge = 12.0;
    
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
            
            double r = ((double)arc4random() / ARC4RANDOM_MAX);
            view.backgroundColor = [UIColor colorWithHue:r saturation:1.0 brightness:1.0 alpha: 0.0];
            
            //NSInteger viewTag = (NSInteger) (i * self.w_views + j);
            //view.tag = viewTag;
            
            [self.view addSubview:view];
            [self.boardCells insertObject:view atIndex: (NSUInteger) (i * (int) self.w_views + j)];
            
        }
        
    }
        
    self.board = new Board::Board(self.h_views, self.w_views);
    self.board->randomize(0.1);
    
}

- (void) render: (Board *) board {
    // Set view colors according to board board (w,h) == Board (w_views, h_views)
    
    // UIColor * noColor = [UIColor blackColor];

    for (int i = 0; i < (int) self.h_views; i++) {
        for (int j = 0; j < (int) self.w_views; j++) {
            
            UIView * view = [self.boardCells objectAtIndex: (NSInteger) (i * (int) self.w_views + j)];
            
            CGFloat hue;
            CGFloat saturation;
            CGFloat brightness;
            CGFloat alpha;
            [view.backgroundColor getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha];
            
            if (self.board->getElement(i, j).state) {
                // Advance color and set alpha to 1

                [UIView animateWithDuration:0.2 animations:^{
                    CGFloat new_hue = fmod(hue + 0.007, 1.0);
                    view.backgroundColor = [UIColor colorWithHue:new_hue saturation:saturation brightness:brightness alpha:1.0];
                    
                } completion:NULL];
            } else {
                // Hold color and set alpha to 0
                [UIView animateWithDuration:0.2 animations:^{
                    view.backgroundColor = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:0.0];
                } completion:NULL];
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

}

- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    // This will trigger cleanup
    self.halt = YES;
    
    
}

- (void) cleanUp {
    delete self.board;
    self.board = nil;
    
}

- (void) update {
    /* Execute board updates on global queue */
    self.queue = dispatch_queue_create("boardQueue", NULL);
    
    if (self.queue) {
        dispatch_async(self.queue, ^{
            Board::Board * oldBoard = self.board;
            self.board = new Board::Board(*self.board);
            delete oldBoard;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self render:self.board];
                if (!self.halt) {
                    [self update];
                } else {
                    [self cleanUp];
                }
            });
        });
    }
    
}

- (void) awakeFromNib {
    [super awakeFromNib];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
