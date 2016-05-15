//
//  Block.m
//  Life
//
//  Created by Kevin Katz on 5/14/16.
//  Copyright © 2016 Kevin Katz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Block.h"

@interface Block ()


@end

@implementation Block

@synthesize state;

- (instancetype)init {
    return [self initWithWidth: 32];
}

- (instancetype)initWithWidth: (int) width
{
    self = [super init];
    if (self) {
        [self setState:false];
        CGRect frm = self.frame;
        frm.size.width = width;
        frm.size.height = width;
        [self setFrame: frm];
        [self setBackgroundColor: [UIColor greenColor]];
    }
    return self;
}

@end


