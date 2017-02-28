//
//  KSCardSwitch.h
//  KSCardSwitchDemo
//
//  Created by 康帅 on 17/2/27.
//  Copyright © 2017年 Bujiaxinxi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KSCardSwitch : UIView
@property (strong,nonatomic) NSArray *models;
@property (strong,nonatomic) void(^currenuSelect)(NSInteger currentIndex);
@end
