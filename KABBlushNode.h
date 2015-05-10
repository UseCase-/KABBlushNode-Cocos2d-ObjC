//
//  KABBlushNode.m
//  KABBlush
//
//  Updated to Cocos2d-Objc 3.4 02/20/15
//  Created by Kenneth Barber on 1/23/12.
//  Copyright 2012 DoublePlus Touch Ltd. All rights reserved.
//  Shared by creator: Attribution-ShareAlike CC BY-SA

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "CCColor+HSVManagement.h"

@interface KABBlushNode : CCNode<CCShaderProtocol, CCTextureProtocol>  {
    
    CCVertex	squareVertices_[4];
    
    CCColor*    _baseColor;
    CCColor*    _activeColor;
    
}

+ (id) ActiveBackground;

- (void) step:(CCTime)dt;

@property COL_HSV upLeftOffSet;
@property COL_HSV upRightOffSet;
@property COL_HSV downLeftOffSet;
@property COL_HSV downRightOffSet;

@property CCColor* activeColor;
@property bool useOffSet;

@end
