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

@property (weak, nonatomic) IBOutlet UIBoard *board;
@property (strong, nonatomic) NSMutableArray *boardStore;


@end

@implementation ViewController

@synthesize boardStore;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    
    
    /*
    NSLog(@"%@\n", [b description]);
    for (int i = 0; i < 8; i++) {
        b = [Board golStep:b];
        NSLog(@"%@\n", [b description]);
    }
     */
    
    //NSLog([[Board matrixAdd:x With:x AndXSkew:@0 AndYSkew:@0] description]);
    //NSLog([[Board matrixAdd:x With:x AndXSkew:@0 AndYSkew:@1] description]);
    
}

- (void) viewWillAppear:(BOOL)animated {
    
    [super viewDidLayoutSubviews];
    NSLog(@"w: %f", self.view.frame.size.width);
    NSLog(@"h: %f", self.view.frame.size.height);
    
    float edge = 32.0;
    float w = self.view.frame.size.width;
    float h = self.view.frame.size.height;
    
    float w_views = w / edge;
    float h_views = h / edge;
    
    NSLog(@"w_views: %f", w_views);
    NSLog(@"h_views: %f", h_views);
    
    float w_margin = (float) ((int) w % (int) edge) / 2;
    float h_margin = (float) ((int) h % (int) edge) / 2;
    
    NSLog(@"w_margin: %f", w_margin);
    NSLog(@"h_margin: %f", h_margin);
    
    /* Create 2 dimensional array to store block views */
    boardStore = [[NSMutableArray alloc] initWithCapacity:(int) h_views];
    for (int i = 0; i < (int) h_views; i++) {
        NSMutableArray * row = [[NSMutableArray alloc] initWithCapacity:(int) w_views];
        for (int j = 0; j < (int) w_views; j++) {
            [row insertObject:@0 atIndex:j];
        }
        [boardStore insertObject:row atIndex:i];
    }
    
    //[self.view setBackgroundColor:[UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:1.0]];

    /* Initialize and store views */
    for (int i = 0; i < (int) h_views; i++) {
        // Top to Bottom
        for (int j = 0; j < (int) w_views; j++) {
            // Left to Right
            CGRect rect = CGRectMake(w_margin + j * edge, h_margin + i * edge, edge, edge);
            UIView * view = [[UIView alloc] initWithFrame:rect];
            // NSLog(@"Initializing view with frame: %f %f %f %f", rect.origin.x, rect.origin.y, rect.size.width, rect.size.height, nil);
            
            UIColor * color = [UIColor colorWithRed:(i / h_views) green:(j / w_views) blue:0.0 alpha:1.0];
            [view setBackgroundColor:color];
            
            NSMutableArray * row = [boardStore objectAtIndex:(NSUInteger) i];
            [row insertObject:view atIndex:(NSUInteger) j];
            
            NSInteger viewIndex = (NSInteger) (i * w_views + j);
            [self.view addSubview:view]; // atIndex:viewIndex];
            // NSLog(@"Inserting view at index %ld", viewIndex);
            
        }
    }
    
    /*dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0); */
    
    /*dispatch_apply(500, queue, ^(size_t i) {
        NSLog(@"%d\n",i);
    }); */
    
    
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
