//
//  UIImage+Utilities.m
//  PSIslandTerrainGenerator
//
//  Created by Philippe Sawaya on 9/24/13.
//  Copyright (c) 2013 Philippe Sawaya. All rights reserved.
//

#import "UIImage+Utilities.h"

@implementation UIImage (Utilities)

+(UIImage *)newImageFromMaskImage:(UIImage *)mask inColor:(UIColor *)color {
    CGImageRef maskImage = mask.CGImage;
    CGFloat width = mask.size.width;
    CGFloat height = mask.size.height;
    CGRect bounds = CGRectMake(0, 0, width, height);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef bitmapContext = CGBitmapContextCreate(NULL, width, height, 8, 0, colorSpace, (CGBitmapInfo)kCGImageAlphaPremultipliedLast);
    CGContextClipToMask(bitmapContext, bounds, maskImage);
    CGContextSetFillColorWithColor(bitmapContext, color.CGColor);
    CGContextFillRect(bitmapContext, bounds);
    CGImageRef mainViewContentBitmapContext = CGBitmapContextCreateImage(bitmapContext);
    CGContextRelease(bitmapContext);
    UIImage *result = [UIImage imageWithCGImage:mainViewContentBitmapContext];
    return result;
}

@end
