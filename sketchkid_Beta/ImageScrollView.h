//
//  ImageScrollView.h
//  kidsArt
//
//  Created by Andrea Terzani on 05/09/12.
//  Copyright (c) 2012 Andrea Terzani. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageScrollView : UIScrollView <UIScrollViewDelegate> {
    UIImageView        *imageView;
    NSUInteger     index;
}
@property (assign) NSUInteger index;

@property(strong,nonatomic)UIImageView *_imageView;

- (void)displayImage:(UIImage *)image;
- (void)displayTiledImageNamed:(NSString *)imageName size:(CGSize)imageSize;
- (void)setMaxMinZoomScalesForCurrentBounds;

- (CGPoint)pointToCenterAfterRotation;
- (CGFloat)scaleToRestoreAfterRotation;
- (void)restoreCenterPoint:(CGPoint)oldCenter scale:(CGFloat)oldScale;

@end
