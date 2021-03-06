//
//  ViewController.h
//  LFImagePicker
//
//  Created by LongFan on 15/9/24.
//  Copyright © 2015年 LongFan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, LFImagePickerTargetType) {
    LFImagePickerTargetTypeCoverImage,
    LFImagePickerTargetTypeItemImage
};

typedef NS_ENUM(NSUInteger, LFImagePickerThemeType) {
    LFImagePickerThemeTypePlayPlus,
    LFImagePickerThemeTypeYuJian
};

@protocol LFimagePickerDelegate, LFImagePickerCompressorProtocol;

@interface LFImagePickerViewController : UIViewController

@property (nonatomic, assign) NSInteger maxSelectedCount;
@property (nonatomic, assign) NSInteger maxVideoCount;
@property (nonatomic, assign) NSInteger maxVideoDuration;
@property (nonatomic, strong) UIColor *tintColor;

@property (nonatomic, assign) LFImagePickerTargetType targetType;

@property (nonatomic, assign) BOOL videoAvailable;
@property (nonatomic, assign) BOOL audioAvailable;

@property (nonatomic, weak) id<LFimagePickerDelegate> delegate;

- (instancetype)initWithThemeColor:(UIColor *)color themeType:(LFImagePickerThemeType)type;

@end

@protocol LFimagePickerDelegate <NSObject>

- (void)imagePicker:(LFImagePickerViewController *)picker didImportImages:(NSArray *)imageList;
- (void)imagePicker:(LFImagePickerViewController *)picker didImportFailedInfo:(NSDictionary *)info;
- (void)imagePicker:(LFImagePickerViewController *)picker didReachMaxSelectedCount:(NSInteger)maxCount;
- (void)imagePicker:(LFImagePickerViewController *)picker didReachMaxVideoCount:(NSInteger)maxCount;

@optional
- (void)imagePicker:(LFImagePickerViewController *)picker didTappedImportButton:(UIButton *)button;
- (void)imagePicker:(LFImagePickerViewController *)picker didRejectSelectVideoAtIndexPath:(NSIndexPath *)indexPath;
- (void)imagePicker:(LFImagePickerViewController *)picker didRejectSelectAudioAtIndexPath:(NSIndexPath *)indexPath;

@end

@protocol LFImagePickerCompressorProtocol <NSObject>



@end

