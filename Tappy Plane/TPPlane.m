//
//  TPPlane.m
//  Tappy Plane
//
//  Created by Rob Norback on 3/2/15.
//  Copyright (c) 2015 Sidecar Games. All rights reserved.
//

#import "TPPlane.h"

@interface TPPlane()

@property (nonatomic) NSMutableArray *planeAnimations; //Holds animation actions
@property (nonatomic) SKEmitterNode *puffTrailEmitter;
@property (nonatomic) CGFloat puffTrailBirthRate;

@end

@implementation TPPlane

static NSString* const kKeyPlaneAnimation = @"PlaneAnimation";

- (instancetype)init
{
    self = [super initWithImageNamed:@"PlaneBlue1@2x"];
    if (self) {
        
        // Setup physics body
        self.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:self.size.width/2];
        self.physicsBody.mass = 0.08;
        
        // Init array to hold animation actions
        _planeAnimations = [[NSMutableArray alloc]init];
        
        // Load animations plist file
        NSString *path = [[NSBundle mainBundle] pathForResource:@"PlaneAnimations" ofType:@"plist"];
        NSDictionary *animations = [NSDictionary dictionaryWithContentsOfFile:path];
        for (NSString *key in animations) {
            [_planeAnimations addObject:[self animationFromArray:[animations objectForKey:key] withDuration:0.4]];
        }
        
        // Load puff trail emitter node
        NSString *particleFile = [[NSBundle mainBundle] pathForResource:@"PlanePuffTrail" ofType:@"sks"];
        _puffTrailEmitter = [NSKeyedUnarchiver unarchiveObjectWithFile:particleFile];
        _puffTrailEmitter.position = CGPointMake(-self.size.width/2, -self.size.height/4);
        [self addChild:_puffTrailEmitter];
        self.puffTrailBirthRate = self.puffTrailEmitter.particleBirthRate;
        //self.puffTrailEmitter.particleBirthRate = 0;
        
        [self setRandomColor];
    }
    return self;
}

-(void)setEngineRunning:(BOOL)engineRunning
{
    _engineRunning = engineRunning;
    if (engineRunning) {
        self.puffTrailEmitter.targetNode = self.parent; //When engine is set to running we know we have a parent
        [self actionForKey:kKeyPlaneAnimation].speed = 1;
        self.puffTrailEmitter.particleBirthRate = self.puffTrailBirthRate;
    }
    else {
        [self actionForKey:kKeyPlaneAnimation].speed = 0;
        self.puffTrailEmitter.particleBirthRate = 0;
    }
}

-(void)setRandomColor
{
    [self removeActionForKey:kKeyPlaneAnimation];
    SKAction *runPlane = [_planeAnimations objectAtIndex:arc4random_uniform(_planeAnimations.count)];
    [self runAction:runPlane withKey:kKeyPlaneAnimation];
    if (!self.engineRunning) {
        [self actionForKey:kKeyPlaneAnimation].speed = 0;
    }
    
}

-(SKAction *)animationFromArray:(NSArray*)textureNames withDuration:(CGFloat)duration
{
    // Create an array to hold textures
    NSMutableArray *frames = [[NSMutableArray alloc]init];
    
    // Get planes atlas
    SKTextureAtlas *planesAtlas = [SKTextureAtlas atlasNamed:@"Graphics"];
    
    // Loop through textureNames array and add textures
    for (NSString *textureName in textureNames) {
        [frames addObject:[planesAtlas textureNamed:textureName]];
    }
    
    // Calculate the time per frame
    CGFloat frameTime = duration / (CGFloat)frames.count;
    
    // Create and return animation action
    return [SKAction repeatActionForever:[SKAction animateWithTextures:frames timePerFrame:frameTime]];
    
}

-(void)update
{
    if (self.accelerating) {
        [self.physicsBody applyForce:CGVectorMake(0, 100)];
    }
}


@end
