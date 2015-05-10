//
//  KABBlushNode.m
//  KABBlush
//
//  Updated to Cocos2d-Objc 3.4 02/20/15
//  Created by Kenneth Barber on 1/23/12.
//  Copyright 2012 DoublePlus Touch Ltd. All rights reserved.
//  Shared by creator: Attribution-ShareAlike CC BY-SA

#import "KABBlushNode.h"
#import "CCColor+HSVManagement.h"
#define ARC4RANDOM_MAX      0x100000000


@implementation KABBlushNode

@synthesize activeColor = _activeColor;

@synthesize upLeftOffSet = _upLeftOffSet;
@synthesize upRightOffSet = _upRightOffSet;
@synthesize downLeftOffSet = _downLeftOffSet;
@synthesize downRightOffSet = _downRightOffSet;

+ (id) ActiveBackground{
    return [[self alloc] init];
}
- (id) init{
    
    self = [super init];
    
    _baseColor = [CCColor whiteColor];
    _useOffSet = NO;
    
    self.shader = [CCShader positionColorShader];
    _anchorPoint =  ccp(0.5f, 0.5f);
    return self;
    
}

-(void)onEnter{
    [super onEnter];
    [self schedule:@selector(step:) interval: 1/30.0f];
}

- (void) draw:(CCRenderer *)renderer transform:(const GLKMatrix4 *)transform{
    
    CGSize size = self.contentSize;
    
    GLKVector2 center = GLKVector2Make(size.width/2.0, size.height/2.0);
    GLKVector2 extents = GLKVector2Make(size.width/2.0, size.height/2.0);
    
    if(CCRenderCheckVisbility(transform, center, extents)){
        
        CCRenderBuffer buffer = [renderer enqueueTriangles:2 andVertexes:4 withState:self.renderState globalSortOrder:0];
        
        //squareVertices_[0]
        CCRenderBufferSetVertex(buffer, 0, CCVertexApplyTransform(squareVertices_[0], transform));
        //squareVertices_[1]
        CCRenderBufferSetVertex(buffer, 1, CCVertexApplyTransform(squareVertices_[1], transform));
        //squareVertices_[2]
        CCRenderBufferSetVertex(buffer, 2, CCVertexApplyTransform(squareVertices_[2], transform));
        //squareVertices_[3]
        CCRenderBufferSetVertex(buffer, 3, CCVertexApplyTransform(squareVertices_[3], transform));
        
        CCRenderBufferSetTriangle(buffer, 0, 0, 1, 2);
        CCRenderBufferSetTriangle(buffer, 1, 0, 2, 3);
        
    }
}

- (void) step:(CCTime)dt{
    
    if([_baseColor isEqualToColor:_activeColor]){
        return;
    }
    
    COL_HSV baseHSV = [CCColor GetHSVFromCCColor:_baseColor];
    COL_HSV activeHSV = [CCColor GetHSVFromCCColor:_activeColor];
    
    if((fabs(baseHSV.hue-activeHSV.hue)<0.1f)&&
       (fabs(baseHSV.sat-activeHSV.sat)<0.1f)&&
       (fabs(baseHSV.val-activeHSV.val)<0.1f)){
        return;
    }
    
    if(fabs(baseHSV.hue-activeHSV.hue)>0.1f){
        if(baseHSV.hue < activeHSV.hue){
            
            baseHSV.hue += 1.0f;
            if(baseHSV.hue>360.0f){baseHSV.hue = 0.0f;}
        }
        else{
            baseHSV.hue -= 1.0f;
            if(baseHSV.hue<0.0f){baseHSV.hue = 360.0f;}
            
        }
    }
    
    if(fabs(baseHSV.sat-activeHSV.sat)>0.1f){
        if(baseHSV.sat < activeHSV.sat){
            
            baseHSV.sat += 0.01f;
            if(baseHSV.sat>.99){baseHSV.sat = 1.0f;}
        }
        else{
            baseHSV.sat -= 0.01f;
            if(baseHSV.sat<0.0f){baseHSV.sat = 0.0f;}
            
        }
    }
    
    if(fabs(baseHSV.val-activeHSV.val)>0.1f){
        if(baseHSV.val < activeHSV.val){
            
            baseHSV.val += 0.01f;
            if(baseHSV.val>.99){baseHSV.val = 1.0f;}
        }
        else{
            baseHSV.val -= 0.01f;
            if(baseHSV.val<0.0f){baseHSV.val = 0.0f;}
            
        }
    }
    
    _baseColor = [CCColor ColorWithHue:baseHSV.hue Sat:baseHSV.sat Val:baseHSV.val Alpha:baseHSV.alpha];
    
    if(!_useOffSet){
        
        squareVertices_[0].color = GLKVector4Make(_baseColor.red, _baseColor.green, _baseColor.blue, _baseColor.alpha);
        squareVertices_[1].color = GLKVector4Make(_baseColor.red, _baseColor.green, _baseColor.blue, _baseColor.alpha);
        squareVertices_[2].color = GLKVector4Make(_baseColor.red, _baseColor.green, _baseColor.blue, _baseColor.alpha);
        squareVertices_[3].color = GLKVector4Make(_baseColor.red, _baseColor.green, _baseColor.blue, _baseColor.alpha);
        
    }
    else{
        
        CCColor* ulColor = [CCColor ColorWithHue:(baseHSV.hue+_upLeftOffSet.hue)
                                             Sat:(baseHSV.sat+_upLeftOffSet.sat)
                                             Val:(baseHSV.val+_upLeftOffSet.val)
                                           Alpha:baseHSV.alpha];
        
        CCColor* urColor = [CCColor ColorWithHue:(baseHSV.hue+_upRightOffSet.hue)
                                             Sat:(baseHSV.sat+_upRightOffSet.sat)
                                             Val:(baseHSV.val+_upRightOffSet.val)
                                           Alpha:baseHSV.alpha];
        
        CCColor* dlColor = [CCColor ColorWithHue:(baseHSV.hue+_downLeftOffSet.hue)
                                             Sat:(baseHSV.sat+_downLeftOffSet.sat)
                                             Val:(baseHSV.val+_downLeftOffSet.val)
                                           Alpha:baseHSV.alpha];
        
        CCColor* drColor = [CCColor ColorWithHue:(baseHSV.hue+_downRightOffSet.hue)
                                             Sat:(baseHSV.sat+_downRightOffSet.sat)
                                             Val:(baseHSV.val+_downRightOffSet.val)
                                           Alpha:baseHSV.alpha];
        
        squareVertices_[0].color = GLKVector4Make(dlColor.red, dlColor.green, dlColor.blue, dlColor.alpha);
        squareVertices_[1].color = GLKVector4Make(drColor.red, drColor.green, drColor.blue, drColor.alpha);
        squareVertices_[2].color = GLKVector4Make(ulColor.red, ulColor.green, ulColor.blue, ulColor.alpha);
        squareVertices_[3].color = GLKVector4Make(urColor.red, urColor.green, urColor.blue, urColor.alpha);
        
    }
    
}

// override contentSize
-(void) setContentSize: (CGSize) size
{
    squareVertices_[0].position = GLKVector4Make(0.0,0.0,0.0,1.0);
    squareVertices_[1].position = GLKVector4Make(size.width,0.0,0.0,1.0);
    squareVertices_[2].position = GLKVector4Make(size.width,size.height,0.0,1.0);
    squareVertices_[3].position = GLKVector4Make(0.0,size.height,0.0,1.0);
    
    [super setContentSize:size];
}

@end
