#import "MainScene.h"
#import "KABBlushNode.h"

#define ARC4RANDOM_MAX      0x100000000

@implementation MainScene

-(instancetype)init
{
	if((self = [super init])){
		self.color = [CCColor whiteColor];
		
        [self testBlusher];
	}
	
	return self;
}

-(void)onEnter{
    [super onEnter];
    //Change the color randomly every little while
    [self schedule:@selector(randomColorStep:) interval: 4.0f];
}

-(void)testBlusher{
    
    CGSize testSize = [[CCDirector sharedDirector] viewSize];
    
    testSize.height /= 2.0f;
    testSize.width /= 2.0f;
    
    _test = [KABBlushNode ActiveBackground];
    _test.contentSize = testSize;
    _test.position = ccp(testSize.width/1.0f,testSize.height/1.0f);
    
    _test.useOffSet = YES;
    _test.upLeftOffSet = (COL_HSV){.hue = 0.0f,.sat = 0.25f,.val = 0.25f};
    _test.upRightOffSet = (COL_HSV){.hue = 0.0f,.sat = 0.25f,.val = 0.25f};
    _test.downLeftOffSet = (COL_HSV){.hue = 0.0f,.sat = 0.0f,.val = 0.0f};
    _test.downRightOffSet = (COL_HSV){.hue = 0.0f,.sat = 0.0f,.val = 0.0f};
    
    _test.activeColor = [CCColor colorWithCcColor4f:(ccColor4F){0.0f,1.0f,0.0f,1.0f}];
    
    [self addChild:_test z:0];
    
}

- (void) randomColorStep:(CCTime)dt{
    
    //demo 1 using a random CCColor
    float testHue = arc4random() % 360;
    float testSat = ((double)arc4random() / ARC4RANDOM_MAX);
    float testVal = ((double)arc4random() / ARC4RANDOM_MAX);
    _test.activeColor = [CCColor ColorWithHue:testHue Sat:testSat Val:testVal Alpha:1.0f];
    
    //demo 2 arbitrarily using the Heat setter 0.0 to 1.0
    //float temp = ((double)arc4random() / ARC4RANDOM_MAX);
    //_test.activeColor = [CCColor Heat:temp];
    
}

@end
