//
//  LFImagePickerBottomBar.m
//  LFImagePicker
//
//  Created by LongFan on 15/10/10.
//  Copyright © 2015年 LongFan. All rights reserved.
//

#import "LFImagePickerBottomBar.h"
#import "UIView+LayoutMethods.h"

@interface LFImagePickerBottomBar ()

@property (nonatomic, strong) UILabel *selectedCountLabel;

@end

@implementation LFImagePickerBottomBar

#pragma mark - life cycle
- (instancetype)init
{
    if (self = [super init]) {
        self.backgroundColor = [UIColor blackColor];
        self.alpha = 0.5;
        [self addSubview:self.selectedCountLabel];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.selectedCountLabel sizeToFit];
    [self.selectedCountLabel leftInContainer:10 shouldResize:NO];
    [self.selectedCountLabel centerYEqualToView:self];
}

#pragma mark - public
- (void)refreshSelectedCount:(NSInteger)count
{
    self.selectedCountLabel.text = [NSString stringWithFormat:NSLocalizedString(@"selected:%lu", @"count label text"), (long)count];
    [self layoutSubviews];
}

#pragma mark - getters & setters
- (UILabel *)selectedCountLabel
{
    if (_selectedCountLabel == nil) {
        _selectedCountLabel = [[UILabel alloc] init];
        _selectedCountLabel.text = NSLocalizedString(@"selected:0", @"count label text");
        _selectedCountLabel.textColor = [UIColor whiteColor];
    }
    return _selectedCountLabel;
}

@end
