//
//  ATPhotoScrollView.h
//  kidsArt
//
//  Created by Andrea Terzani on 05/09/12.
//  Copyright (c) 2012 Andrea Terzani. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageScrollView.h"

//@class ImageScrollView;
@class ATPhotoScrollView;

@protocol ATPhotoScrollViewDelegate <NSObject>

-(void)ATPhotoScrollViewDidTapOnView:(ATPhotoScrollView*)sender withIndex:(NSUInteger)index andImageview:(UIImageView*)photoview;
-(void)ATPhotoScrollViewDidChangeIndex:(NSUInteger*)index;
@end


@interface ATPhotoScrollView : UIViewController
{
    UIScrollView *pagingScrollView;

    NSMutableSet *recycledPages;
    NSMutableSet *visiblePages;

    // these values are stored off before we start rotation so we adjust our content offset appropriately during rotation
    int           firstVisiblePageIndexBeforeRotation;
    CGFloat       percentScrolledIntoFirstVisiblePage;
    
    
}


@property(strong,nonatomic)NSMutableArray *sketchArray;
@property (strong,nonatomic) id <ATPhotoScrollViewDelegate> delegate;

- (void)configurePage:(ImageScrollView *)page forIndex:(NSUInteger)index;
- (BOOL)isDisplayingPageForIndex:(NSUInteger)index;

- (CGRect)frameForPagingScrollView;
- (CGRect)frameForPageAtIndex:(NSUInteger)index;
- (CGSize)contentSizeForPagingScrollView;

- (void)tilePages;
- (ImageScrollView *)dequeueRecycledPage;

- (NSUInteger)imageCount;
- (NSString *)imageNameAtIndex:(NSUInteger)index;
- (CGSize)imageSizeAtIndex:(NSUInteger)index;
- (UIImage *)imageAtIndex:(NSUInteger)index;

-(void)disableZoomAndScroll;
-(void)enableZoomAndScroll;


-(void)setToIndex:(NSUInteger)index;
-(UIImageView*)getCurrentImageView;
@end
