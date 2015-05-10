# KABBlushNode
Cocos2D v3.4 version of my HSV color transition aka "blush" node.

## Usage:
To use this node external to this project simply add the KABBlushNode class .h & .m and 
the CCColor Category CCColor+HSVManagement .h & .m files to your project. The draw 
function of the blush node has been overridden to support hue sat and val interpolation
toward the supplied ActiveColor... 

Sample code:
```
    CGSize testSize = [[CCDirector sharedDirector] viewSize];
    
    testSize.height /= 2.0f;
    testSize.width /= 2.0f;
    
    KABBlushNode* _test = [KABBlushNode ActiveBackground];
    
    //set the nodes size and position
    _test.contentSize = testSize;
    _test.position = ccp(testSize.width/1.0f,testSize.height/1.0f);
    
    //You can control the gradient of the node based on offsets at the corners
    _test.useOffSet = YES;
    _test.upLeftOffSet = (COL_HSV){.hue = 0.0f,.sat = 0.25f,.val = 0.25f};
    _test.upRightOffSet = (COL_HSV){.hue = 0.0f,.sat = 0.25f,.val = 0.25f};
    _test.downLeftOffSet = (COL_HSV){.hue = 0.0f,.sat = 0.0f,.val = 0.0f};
    _test.downRightOffSet = (COL_HSV){.hue = 0.0f,.sat = 0.0f,.val = 0.0f};
    
    //set the nodes initial color
    _test.activeColor = [CCColor colorWithCcColor4f:(ccColor4F){0.0f,1.0f,0.0f,1.0f}];
    
    //add the node to your scene
    [self addChild:_test z:0];
    
    //any subsequent changes of the active color will transition over a period of time    
```

## History:
This node supports color transition in the background of my 2012 Cocos2d-iphone 
based game PuzzleSwipe:Direction.  I cleaned it up in 2015 and upgraded it to 
work with Cocos2d Obj-C 3.4 just recently.      

```

```
