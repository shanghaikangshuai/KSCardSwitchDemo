//
//  KSCard.m
//  KSCardSwitchDemo
//
//  Created by 康帅 on 17/2/27.
//  Copyright © 2017年 Bujiaxinxi. All rights reserved.
//

#import "KSCard.h"
#import "KSCardModel.h"

@interface KSCard ()
{
    UIImageView *_imageView;
    UILabel *_textLabel;
}
@end
@implementation KSCard
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self buildUI];
    }
    return self;
}

-(void)buildUI
{
    self.layer.cornerRadius = 10.0f;
    self.layer.masksToBounds = true;
    self.backgroundColor = [UIColor whiteColor];
    
    CGFloat labelHeight = self.bounds.size.height * 0.20f;
    CGFloat imageViewHeight = self.bounds.size.height - labelHeight;
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, imageViewHeight)];
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    _imageView.layer.masksToBounds = true;
    [self addSubview:_imageView];
    
    _textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, imageViewHeight, self.bounds.size.width, labelHeight)];
    _textLabel.textColor = [UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1];
    _textLabel.font = [UIFont systemFontOfSize:22];
    _textLabel.textAlignment = NSTextAlignmentCenter;
    _textLabel.adjustsFontSizeToFitWidth = true;
    [self addSubview:_textLabel];
}

-(void)setModel:(id)model
{
    KSCardModel *cardModel = (KSCardModel*)model;
    _imageView.image = [UIImage imageNamed:cardModel.imageName];
    _textLabel.text = cardModel.title;
}
@end
