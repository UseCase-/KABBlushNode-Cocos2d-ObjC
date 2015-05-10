//
//  CCColor+HSVManagement.h
//  Adding HSV functionality to the base CCColor class
//
//  Updated to Cocos2d-Objc 3.4 02/20/15
//  Created by Kenneth Barber on 1/23/12.
//  Copyright 2012 DoublePlus Touch Ltd. All rights reserved.
//  Shared by creator: Attribution-ShareAlike CC BY-SA

#import <Foundation/Foundation.h>
#import "cocos2d.h"

typedef struct _hsv_color {
    float hue;      /* Hue degree between 0.0 and 360.0 */
    float sat;      /* Saturation between 0.0 (gray) and 1.0 */
    float val;      /* Value between 0.0 (black) and 1.0 */
    float alpha;    /* Value between 0.0 (transparent) and 1.0 */
} COL_HSV;

@interface CCColor(HSVManagement)

+(COL_HSV)GetHSVFromCCColor:(CCColor*)iColor;
+(CCColor*)ColorWithHue:(float)iHue Sat:(float)iSat Val:(float)iVal Alpha:(float)iAlpha;
+(CCColor*)RYG:(float)temperature;
+(CCColor*)Heat:(float)temperature;

@end
