//
//  ViewController.m
//  Life
//
//  Created by Kevin Katz on 5/14/16.
//  Copyright © 2016 Kevin Katz. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UICollectionView *board;

@end

@implementation ViewController

@synthesize board;



+ (void) printBoard: (NSArray *) board {
    NSMutableString * acc = [NSMutableString string];
    
    [acc appendString:@"\n"];
    for (int i = 0; i < [board count]; i++) {
        for (int j = 0; j < [[board objectAtIndex:i] count]; j++) {
            [acc appendFormat: @"%@", [[board objectAtIndex: i] objectAtIndex: j], nil];
        }
        [acc appendString:@"\n"];
    }
    NSLog([acc description]);
    
}

+ (NSArray *) golStep: (NSArray *) currentState {
    
    int y_count = 24;
    int x_count = 24;
    NSMutableArray * board;
    
    
    NSLog(@"golStep called with board: ");
    [ViewController printBoard:board];
    
    
    if (currentState == nil) {
        NSLog(@"Board is nil, initializing");
        
        board = [[NSMutableArray alloc] initWithCapacity:24];
        
        for (int i = 0; i < y_count; i++) {
            NSMutableArray * row = [[NSMutableArray alloc] initWithCapacity:24];
            for (int j = 0; j < x_count; j++) {
                [row insertObject:[NSNumber numberWithInteger:0] atIndex:j];
            }
            [board insertObject:row atIndex:i];
        }

        
    } else {
        
        board = [[NSMutableArray alloc] initWithCapacity:y_count];
        
        for (int i = 0; i < y_count; i++) {
            NSMutableArray * row = [[NSMutableArray alloc] initWithCapacity:x_count];
            for (int j = 0; j < x_count; j++) {
                [row insertObject:[NSNumber numberWithInteger:0] atIndex:j];
            }
            [board insertObject:row atIndex:i];
        }
        
    }
    
    
    
    [ViewController printBoard:board];
    
    
    return board;
    
}

+ (NSArray *) matrixAddA: (NSArray *) a B: (NSArray *) b XSkew: (int) xSkew ySkew: (int) ySkew {
    
    int y_count = (int) [a count];
    int x_count = (int) [[a objectAtIndex:0] count];
    
    NSMutableArray * result = [[NSMutableArray alloc] initWithCapacity:y_count];
    
    for (int i = 0; i < y_count; i++) {
        NSMutableArray * row = [[NSMutableArray alloc] initWithCapacity:x_count];
        for (int j = 0; j < x_count; j++) {
            
            [row insertObject:[NSNumber numberWithInteger:0] atIndex:j];
            
            int other_i = i + ySkew;
            int other_j = j + xSkew;
            
            if (other_i < 0 || other_i >= y_count || other_j < 0 || other_j >= x_count) {
                continue;
            } else {
                
                NSNumber * a_val = [[a objectAtIndex:i] objectAtIndex:j];
                NSNumber * b_val = [[a objectAtIndex:other_i] objectAtIndex:other_j];
                NSNumber * sum = [NSNumber numberWithInt:([a_val intValue] + [b_val intValue])];
                
                [[result objectAtIndex:i] setObject:sum atIndex:j];
            }
            
            
        }
        [result insertObject:row atIndex:i];
    }
    return result;
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // int x = board.frame.size.width;
    // int y = board.frame.size.height;
    
    // int x_count = x / 32;
    // int y_count = y / 32;
    
    //NSMutableArray * board = [[NSMutableArray alloc] initWithCapacity:y_count];
    
    NSMutableArray * board = nil;
    
    for (int i = 0; i < 3; i++) {
        board = [ViewController golStep:board];
    }
    
    
    
}

- (void) awakeFromNib {
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
