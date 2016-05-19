//
//  BaseViewController.h
//  TO-DO
//
//  Created by Siegrain on 16/5/19.
//  Copyright © 2016年 com.siegrain. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HeaderView;
@class SGUser;

/**
 *  基页（除登录）
 */
@interface BaseViewController : UIViewController {
    HeaderView* headerView;
    SGUser* user;
}
- (void)setupView;
- (void)bindConstraints;

/**
 *  设置 NavBar 上的标题
 */
- (void)setMenuTitle:(NSString*)title;
@end
