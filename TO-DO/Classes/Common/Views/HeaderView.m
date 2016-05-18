//
//  HeaderView.m
//  TO-DO
//
//  Created by Siegrain on 16/5/14.
//  Copyright © 2016年 com.siegrain. All rights reserved.
//

#import "HeaderView.h"
#import "Macros.h"
#import "Masonry.h"
#import "TodoHelper.h"
#import "UIImage+Extension.h"

static CGFloat const kAvatarSizeMultipliedByHeight = 0.16;
static CGFloat const kTitleLabelHeight = 40;

@implementation HeaderView {
    HeaderAvatarPosition avatarPosition;
    HeaderTitleAlignement titleAlignement;
}
#pragma mark - initial
+ (instancetype)headerViewWithAvatarPosition:(HeaderAvatarPosition)avatarPosition titleAlignement:(HeaderTitleAlignement)titleAlignement
{
    HeaderView* headerView = [[HeaderView alloc] init];
    headerView->avatarPosition = avatarPosition;
    headerView->titleAlignement = titleAlignement;
    [headerView setup];
    [headerView bindConstraints];

    return headerView;
}
- (void)setup
{
    _backgroundImageView = [[UIImageView alloc] init];
    _backgroundImageView.contentMode = UIViewContentModeScaleToFill;
    [self addSubview:_backgroundImageView];

    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [TodoHelper themeFontWithSize:32];
    _titleLabel.textColor = [UIColor whiteColor];
    [self addSubview:_titleLabel];

    _subtitleLabel = [[UILabel alloc] init];
    _subtitleLabel.font = [TodoHelper themeFontWithSize:12];
    _subtitleLabel.textColor = ColorWithRGB(0xCCCCCC);
    [self addSubview:_subtitleLabel];

    _avatarButton = [[UIButton alloc] init];
    _avatarButton.layer.masksToBounds = YES;
    _avatarButton.layer.cornerRadius = kScreenHeight * kAvatarSizeMultipliedByHeight / 2;
    [_avatarButton addTarget:self action:@selector(avatarButtonDidPress) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_avatarButton];

    _rightOperationButton = [[UIButton alloc] init];
    [_rightOperationButton addTarget:self action:@selector(rightOperationButtonDidPress) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_rightOperationButton];
}
- (void)bindConstraints
{
    [_backgroundImageView mas_makeConstraints:^(MASConstraintMaker* make) {
        make.left.right.top.offset(0);
        if (avatarPosition == HeaderAvatarPositionBottom)
            make.height.equalTo(self).multipliedBy(0.9);
        else
            make.height.equalTo(self);
    }];

    [_rightOperationButton mas_makeConstraints:^(MASConstraintMaker* make) {
        make.bottom.offset(-kScreenHeight * 0.03);
        make.right.offset(-20);
        make.width.offset(kScreenHeight * 0.1);
        make.height.equalTo(_rightOperationButton.mas_width);
    }];

    [_avatarButton mas_makeConstraints:^(MASConstraintMaker* make) {
        make.centerX.equalTo(_backgroundImageView);
        if (avatarPosition == HeaderAvatarPositionCenter)
            make.top.offset(kScreenHeight * 0.18);
        else
            make.bottom.offset(0);
        make.width.offset(kScreenHeight * kAvatarSizeMultipliedByHeight);
        make.height.equalTo(_avatarButton.mas_width);
    }];

    [_titleLabel mas_makeConstraints:^(MASConstraintMaker* make) {
        make.centerX.equalTo(_backgroundImageView);
        if (avatarPosition == HeaderAvatarPositionCenter && titleAlignement == HeaderTitleAlignementCenter)
            make.top.equalTo(_avatarButton.mas_bottom).offset(5);
        else
            make.centerY.offset(-30);
        make.height.offset(kTitleLabelHeight);
    }];

    [_subtitleLabel mas_makeConstraints:^(MASConstraintMaker* make) {
        make.top.equalTo(_titleLabel.mas_bottom).offset(5);
        make.height.offset(20);
        make.centerX.equalTo(_titleLabel);
    }];
}
#pragma mark - avatar button event
- (void)avatarButtonDidPress
{
    if (_headerViewDidPressAvatarButton) _headerViewDidPressAvatarButton();
}
#pragma mark - right operation button event
- (void)rightOperationButtonDidPress
{
}
@end