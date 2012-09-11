//
//  UIImage+Scale.h
//  sketchKid_alpha_universal
//
//  Created by Andrea on 01/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//



@interface UIImage (Scale)
-(UIImage*)scaleToSize:(CGSize)size;
- (UIImage *)croppedImage:(CGRect)bounds ;
- (UIImage *)fixOrientation;

- (UIImage *)scaledCopyOfSize:(CGSize)newSize ;
- (UIImage*)overlayWith:(UIImage*)overlayImage;
- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees;
- (UIImage*)addFrame:(UIImage*)overlayImage inPoint:(CGPoint)point;
@end
