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
        
        // Setup gravity
        self.physicsWorld.gravity = CGVectorMake(0, -4.9);
        
        // Setup world
        _world = [SKNode node];
        [self addChild:_world];
        
        // Setup player
        _player = [[TPPlane alloc] init];
        _player.position = CGPointMake(self.size.width/2,self.size.height/2);
        _player.physicsBody.affectedByGravity = NO;
        [_world addChild:_player];
        _player.engineRunning = YES;
        
        //Will this work?
        
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch *touch in touches) {
        _player.physicsBody.affectedByGravity = YES;
        self.player.accelerating = YES;
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch *touch in touches) {
        self.player.accelerating = NO;
    }
}

-(void)update:(NSTimeInterval)currentTime
{
    _player.update;
}

@end
