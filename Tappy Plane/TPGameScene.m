//
//  TPGameScene.m
//  Tappy Plane
//
//  Created by Rob Norback on 2/22/15.
//  Copyright (c) 2015 Sidecar Games. All rights reserved.
//

#import "TPGameScene.h"

@implementation TPGameScene

-(id)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size]) {
        NSLog(@"Size %f,%f",size.width,size.height);
    }
    return self;
}

@end
