//
//  CCColor+HSVManagement.m
//  Adding HSV functionality to the base CCColor class
//
//  Updated to Cocos2d-Objc 3.4 02/20/15
//  Created by Kenneth Barber on 1/23/12.
//  Copyright 2012 DoublePlus Touch Ltd. All rights reserved.
//  Shared by creator: Attribution-ShareAlike CC BY-SA

#import "CCColor+HSVManagement.h"


@implementation CCColor(HSVManagement)


+(COL_HSV)GetHSVFromCCColor:(CCColor*)iColor{
    
    double rd = iColor.red;
    double gd = iColor.green;
    double bd = iColor.blue;
    
    float Max;
    float Min;
    float Chroma;
    COL_HSV HSV;
    
    Max = fmax(rd, fmax(gd, bd));
    Min = fmin(rd, fmin(gd, bd));
    Chroma = Max - Min;
    
    //If Chroma is 0, then S is 0 by definition, and H is undefined but 0 by convention.
    if(Chroma != 0)
    {
        if(rd == Max)
        {
            HSV.hue = (gd - bd) / Chroma;
            
            if(HSV.hue < 0.0)
            {
                HSV.hue += 6.0;
            }
        }
        else if(gd == Max)
        {
            HSV.hue = ((bd - rd) / Chroma) + 2.0;
        }
        else //RGB.B == Max
        {
            HSV.hue = ((rd - gd) / Chroma) + 4.0;
        }
        
        HSV.hue *= 60.0;
        HSV.sat = Chroma / Max;
    }
    
    HSV.val = Max;
    HSV.alpha = iColor.alpha;
    
    return HSV;
    
}

+(CCColor*)ColorWithHue:(float)iHue Sat:(float)iSat Val:(float)iVal Alpha:(float)iAlpha{
    
    ccColor4F RGB;
    
    int i;
    float f, p, q, t;
    if( iSat == 0 ) {
        // achromatic (grey)
        RGB.r = RGB.g = RGB.b = iVal;
        RGB.a = iAlpha;
        return [CCColor colorWithRed:RGB.r green:RGB.g blue:RGB.b alpha:RGB.a];
    }
    iHue /= 60;			// sector 0 to 5
    i = floor( iHue );
    f = iHue - i;			// factorial part of h
    p = iVal * ( 1 - iSat );
    q = iVal * ( 1 - iSat * f );
    t = iVal * ( 1 - iSat * ( 1 - f ) );
    switch( i ){
        case 0:
            RGB.r = iVal;
            RGB.g = t;
            RGB.b = p;
            break;
        case 1:
            RGB.r = q;
            RGB.g = iVal;
            RGB.b = p;
            break;
        case 2:
            RGB.r = p;
            RGB.g = iVal;
            RGB.b = t;
            break;
        case 3:
            RGB.r = p;
            RGB.g = q;
            RGB.b = iVal;
            break;
        case 4:
            RGB.r = t;
            RGB.g = p;
            RGB.b = iVal;
            break;
        default:		// case 5:
            RGB.r = iVal;
            RGB.g = p;
            RGB.b = q;
            break;
    }
    RGB.a = iAlpha;
 
    return [CCColor colorWithRed:RGB.r green:RGB.g blue:RGB.b alpha:RGB.a];
    
}
//(1.0 - value) * 240
+(CCColor*)RYG:(float)temperature{
    
    COL_HSV tHSV = (COL_HSV){.hue = 0.0f, .sat = 1.0f, .val = 1.0f, .alpha = 1.0f};
    
    tHSV.hue = 120.0 * clampf(temperature, 0.0, 1.0);
    
    return [CCColor ColorWithHue:tHSV.hue Sat:tHSV.sat Val:tHSV.val Alpha:tHSV.alpha];
}

+(CCColor*)Heat:(float)temperature{
    
    COL_HSV tHSV = (COL_HSV){.hue = 0.0f, .sat = 1.0f, .val = 1.0f, .alpha = 1.0f};
    
    tHSV.hue = 240 * clampf(temperature, 0.0, 1.0);
    
    return [CCColor ColorWithHue:tHSV.hue Sat:tHSV.sat Val:tHSV.val Alpha:tHSV.alpha];
}

@end
