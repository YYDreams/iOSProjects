//
//  UIImage+HH.h
//  leyingyinggame
//
//  Created by 花花 on 2016/11/19.
//  Copyright © 2016年 TuMi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (HH)

/**
 可以自由拉伸的图片

 @param imgName 图片名称
 @return 拉伸后图片
 */
+ (UIImage *)resizedImage:(NSString *)imgName;

/**
 可以自由拉伸的图片

 @param imgName 图片名称
 @param xPos 横向比例
 @param yPos 纵向比例
 @return 拉伸后图片
 */
+ (UIImage *)resizedImage:(NSString *)imgName xPos:(CGFloat)xPos yPos:(CGFloat)yPos;

/**
 颜色生成图片

 @param color 颜色
 @param size 尺寸
 @return 图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

/**
 将图片渲染成指定颜色

 @param color 颜色
 @return 图片
 */
- (UIImage *)imageWithColor:(UIColor *)color;

/**
 根据图片url获取图片尺寸

 @param imageURL 图片url
 @return 图片尺寸
 */
+ (CGSize)getImageSizeWithURL:(id)imageURL;

/**
 生成圆角图片

 @return 图片
 */
- (UIImage *)imageForRoundCorner;

/**
 缩放图片

 @param image 图片
 @param newSize 新尺寸
 @return 新图片
 */
+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;

/**
 个人主页背景缩放

 @param image 图片
 @return 新图片
 */
+ (UIImage *)imageByCroppingWithImage:(UIImage *)image;

/**
 分享专用缩放图片

 @param image 图片
 @return 新图片
 */
+ (UIImage *)imageCompressedForShareImage:(UIImage *)image;


/**
 生成虚线image

 @param imageView 源imageView
 @return 虚线image
 */
+ (UIImage *)dashLineImageWithImageView:(UIImageView *)imageView;


/**
 画带圆角和边框的纯色背景图片
 
 @param color 填充颜色
 @param cornerRidus 圆角大小
 @param rect 范围
 @param boardColor 边线颜色
 @return 图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color cornerRidus:(CGFloat)cornerRidus rect:(CGRect)rect boardColor:(UIColor*)boardColor;

@end
