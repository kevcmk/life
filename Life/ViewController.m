//
//  ViewController.m
//  Life
//
//  Created by Kevin Katz on 5/14/16.
//  Copyright © 2016 Kevin Katz. All rights reserved.
//

#import "Board.h"
#import "UIBoard.h"
#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) Board *board;
@property (nonatomic) float h_views;
@property (nonatomic) float w_views;
@property (nonatomic) float h_margin;
@property (nonatomic) float w_margin;
@property (nonatomic) float edge;

@end

@implementation ViewController

@synthesize board;
@synthesize h_views;
@synthesize w_views;
@synthesize h_margin;
@synthesize w_margin;
@synthesize edge;

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
    
    [super viewDidLayoutSubviews];
    
    self.edge = gcd(self.view.frame.size.width, self.view.frame.size.height);
    
    if (self.edge < 8) {
        /* If GCD is too small, increase it and fall back to margins */
        self.edge = 8.0;
    } else if (self.edge >= 40 && (int) self.edge % 2 == 0) {
        self.edge = self.edge / 2.0;
    }
    
    float w = self.view.frame.size.width;
    float h = self.view.frame.size.height;
    
    self.w_views = w / self.edge;
    self.h_views = h / self.edge;
    
    self.w_margin = (float) ((int) w % (int) self.edge) / 2;
    self.h_margin = (float) ((int) h % (int) self.edge) / 2;
    
    /* Initialize and store views */
    for (int i = 0; i < (int) self.h_views; i++) {
        // Top to Bottom
        
        for (int j = 0; j < (int) self.w_views; j++) {
            // Left to Right
            
            // Set view frame
            CGRect rect = CGRectMake(self.w_margin + j * self.edge, self.h_margin + i * self.edge, self.edge, self.edge);
            UIView * view = [[UIView alloc] initWithFrame:rect];
            
            NSInteger viewTag = (NSInteger) (i * self.w_views + j);
            view.tag = viewTag;
            
            [self.view addSubview:view];
            
        }
        
    }
    
}

- (void) render: (Board *) board {
    // Set view colors according to board board (w,h) == Board (w_views, h_views)
    
    // UIColor * color = [UIColor colorWithRed:(i / self.h_views) green:(j / self.w_views) blue:0.0 alpha:1.0];
    UIColor * yesColor = [UIColor blackColor];
    UIColor * noColor = [UIColor whiteColor];
    
    /* Initialize and store views */
    for (int i = 0; i < (int) self.h_views; i++) {
        // Top to Bottom
        
        for (int j = 0; j < (int) self.w_views; j++) {
    
            UIView * view = [self.view viewWithTag: (i * self.w_views + j)];
            if ([[self.board getRow: [NSNumber numberWithInt:i] andColumn:[NSNumber numberWithInt:j]] intValue] == 1) {
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

    self.board = [[Board alloc] initWithHeight: [NSNumber numberWithInt:(int) self.h_views] andWidth:[NSNumber numberWithInt: (int) self.w_views]];
    [self.board randomize:@0.3];
    [self render: self.board];

    /* Execute board updates on global queue */
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0.1 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        NSLog(@"Queue!");
    });
    dispatch_resume(timer);
    
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


    

    
    /*
    CGSize windowFrameSize = [[UIApplication sharedApplication] keyWindow].frame.size;
    CGPoint windowFrameOrigin = [[UIApplication sharedApplication] keyWindow].frame.origin;
    CGRect subFrame = CGRectMake(windowFrameOrigin.x + 20, windowFrameOrigin.y + 20, windowFrameSize.width - 40, windowFrameSize.height - 40);
    UIBoard * uiBoard = [[UIBoard alloc] initWithFrame:subFrame andCellWidth:@20];
    
    [self.view addSubview: uiBoard];
    
    Board * b = [[Board alloc] initWithHeight:@9 andWidth:@9];
    
    [b setRow:@3 andColumn:@3 toValue:@1];
    [b setRow:@3 andColumn:@4 toValue:@1];
    [b setRow:@3 andColumn:@5 toValue:@1];
    
    [b setRow:@4 andColumn:@3 toValue:@1];
    [b setRow:@4 andColumn:@5 toValue:@1];
    
    [b setRow:@5 andColumn:@3 toValue:@1];
    [b setRow:@5 andColumn:@4 toValue:@1];
    [b setRow:@5 andColumn:@5 toValue:@1];
    */

}

- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void) awakeFromNib {
    [super awakeFromNib];
    // NSLog(@"awakeFromNib: %@", board.frame.size);
    
    /*
    int x = board.frame.size.width;
    int y = board.frame.size.height;

    int x_count = x / 32;
    int y_count = y / 32;
    
    NSMutableArray * views = [[NSMutableArray alloc] initWithCapacity:y_count];
    for (int i = 0; i < y_count; i++) {
        NSMutableArray * row = [[NSMutableArray alloc] initWithCapacity:x_count];
        for (int j = 0; j < x_count; j++) {
            [row insertObject:subView atIndex:j];
        }
        [views insertObject:row atIndex:i];
    }
     */

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
