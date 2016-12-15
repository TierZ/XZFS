//
// Created by jason on 4/4/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <UIKit/UIKit.h>
@interface UIImage (Additions)

- (UIImage *)stretchableImageFromCenter;
- (UIImage*)scaleToWidth:(CGFloat)width force:(BOOL)force;
- (UIImage*)scaleToWidth:(CGFloat)width;
- (UIImage *)subImageAtRect:(CGRect)rect;
- (UIImage *)imageRotatedToUp;
+ (UIImage*)blurImage:(UIImage*)theImage andblurRadius:(CGFloat )blurRadius;
+ (UIImage *)createImageFromColor:(UIColor *)color andSize:(CGSize )size;


@end
