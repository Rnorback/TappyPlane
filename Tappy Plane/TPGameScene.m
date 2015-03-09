//
//  TPGameScene.m
//  Tappy Plane
//
//  Created by Rob Norback on 2/22/15.
//  Copyright (c) 2015 Sidecar Games. All rights reserved.
//

#import "TPGameScene.h"
#import "TPPlane.h"

@implementation TPGameScene

-(id)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size]) {
        
        // Setup world
        _world = [SKNode node];
        [self addChild:_world];
        
        // Setup player
        _player = [[TPPlane alloc] init];
        _player.position = CGPointMake(self.size.width/2,self.size.height/2);
        [_world addChild:_player];
        
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch *touch in touches) {
        [_player setRandomColor];
    }
}
@end
