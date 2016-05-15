//
//  ViewController.m
//  Life
//
//  Created by Kevin Katz on 5/14/16.
//  Copyright © 2016 Kevin Katz. All rights reserved.
//

#import "Board.h"
#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UICollectionView *board;

@end

@implementation ViewController

@synthesize board;



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // int x = board.frame.size.width;
    // int y = board.frame.size.height;
    
    // int x_count = x / 32;
    // int y_count = y / 32;
    
    //NSMutableArray * board = [[NSMutableArray alloc] initWithCapacity:y_count];
    
    Board * x = [[Board alloc] initWithHeight:@6 andWidth:@6];
    [x setRow:@5 andColumn:@3 toValue:@1];
    
    for (int i = 0; i < 3; i++) {
        x = [Board golStep:x];
        NSLog([x description]);
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
