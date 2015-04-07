//
//  TPGameScene.m
//  Tappy Plane
//
//  Created by Rob Norback on 2/22/15.
//  Copyright (c) 2015 Sidecar Games. All rights reserved.
//

#import "TPGameScene.h"
#import "TPPlane.h"
#import "TPScrollingLayer.h"

@interface TPGameScene()

@property (nonatomic) TPPlane *player;
@property (nonatomic) SKNode *world;
@property (nonatomic) TPScrollingLayer *background;
@property (nonatomic) TPScrollingLayer *foreground;

@end

static const CGFloat kMinFPS = 10.0 / 60.0; //We don't want to drop below 10 fps

@implementation TPGameScene

-(id)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size]) {
        
        // Get atlas file
        SKTextureAtlas *graphics = [SKTextureAtlas atlasNamed:@"Graphics"];
        
        // Setup gravity
        self.physicsWorld.gravity = CGVectorMake(0, -4.9);
        
        // Setup world
        _world = [SKNode node];
        [self addChild:_world];
        
        // Setup background
        NSMutableArray *backgroundTiles = [[NSMutableArray alloc]init];
        for (int i = 0; i < 4; i++) {
            [backgroundTiles addObject:[SKSpriteNode spriteNodeWithTexture:[graphics textureNamed:@"background"]]];
        }
        
        _background = [[TPScrollingLayer alloc] initWithTiles:backgroundTiles];
        _background.position = CGPointZero;
        _background.yScale = 1.4;
        _background.horizontalScrollSpeed = -60;
        _background.scrolling = YES;
        [_world addChild:_background];
        
        // Setup foreground
        NSMutableArray *foregroundTiles = [[NSMutableArray alloc]init];
        for (int i = 0; i < 4; i++) {
            [foregroundTiles addObject:[self generateGroundTile]];
        }
        
        _foreground = [[TPScrollingLayer alloc] initWithTiles:foregroundTiles];
        _foreground.position = CGPointZero;
        _foreground.horizontalScrollSpeed = -80;
        _foreground.scrolling = YES;
        [_world addChild:_foreground];
        
        
        // Setup player
        _player = [[TPPlane alloc] init];
        _player.position = CGPointMake(self.size.width/2,self.size.height/2);
        _player.physicsBody.affectedByGravity = NO;
        [_world addChild:_player];
        _player.engineRunning = YES;
        
    }
    return self;
}

-(SKSpriteNode*)generateGroundTile
{
    SKTextureAtlas *graphics = [SKTextureAtlas atlasNamed:@"Graphics"];
    SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithTexture:[graphics textureNamed:@"groundGrass"]];
    sprite.anchorPoint = CGPointZero;
    
    CGFloat offsetX = sprite.frame.size.width * sprite.anchorPoint.x;
    CGFloat offsetY = sprite.frame.size.height * sprite.anchorPoint.y;
    
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGPathMoveToPoint(path, NULL, 403 - offsetX, 15 - offsetY);
    CGPathAddLineToPoint(path, NULL, 367 - offsetX, 35 - offsetY);
    CGPathAddLineToPoint(path, NULL, 329 - offsetX, 34 - offsetY);
    CGPathAddLineToPoint(path, NULL, 287 - offsetX, 7 - offsetY);
    CGPathAddLineToPoint(path, NULL, 235 - offsetX, 11 - offsetY);
    CGPathAddLineToPoint(path, NULL, 205 - offsetX, 28 - offsetY);
    CGPathAddLineToPoint(path, NULL, 168 - offsetX, 20 - offsetY);
    CGPathAddLineToPoint(path, NULL, 122 - offsetX, 33 - offsetY);
    CGPathAddLineToPoint(path, NULL, 76 - offsetX, 31 - offsetY);
    CGPathAddLineToPoint(path, NULL, 46 - offsetX, 11 - offsetY);
    CGPathAddLineToPoint(path, NULL, 0 - offsetX, 16 - offsetY);
    
    sprite.physicsBody = [SKPhysicsBody bodyWithEdgeChainFromPath:path]; // Edge locks it in place
    
    // This shows the path as a red line
//    SKShapeNode *bodyShape = [SKShapeNode node];
//    bodyShape.path = path;
//    bodyShape.strokeColor = [SKColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:0.5];
//    bodyShape.lineWidth = 10.0;
//    [sprite addChild:bodyShape];
    
    return sprite;
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
    static NSTimeInterval lastCallTime;
    NSTimeInterval timeElapsed = currentTime - lastCallTime;
    lastCallTime = currentTime;
    
    if (timeElapsed > kMinFPS) {
        timeElapsed = kMinFPS;
    }
    
    _player.update;
    [self.background updateWithTimeElapsed:timeElapsed];
    [self.foreground updateWithTimeElapsed:timeElapsed];
}

@end
