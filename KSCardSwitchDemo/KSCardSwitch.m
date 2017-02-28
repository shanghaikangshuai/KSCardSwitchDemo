//
//  KSCardSwitch.m
//  KSCardSwitchDemo
//
//  Created by 康帅 on 17/2/27.
//  Copyright © 2017年 Bujiaxinxi. All rights reserved.
//

#import "KSCardSwitch.h"
#import "KSCard.h"
#import "KSCardModel.h"
#import "KSCardSwitchFlowLayout.h"

//居中卡片宽度与屏幕宽度比例
static float CardWidthScale = 0.7f;
static float CardHeightScale = 0.8f;

@interface KSCardSwitch()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>{
    UIImageView *_imageView;
    UICollectionView *_collectionView;
    CGFloat _dragStartX;
    CGFloat _dragEndX;
    NSInteger _currentIndex;
}
@end
@implementation KSCardSwitch
/*
 ** 构造方法
 */
-(instancetype)init{
    self=[super init];
    if (self) {
        [self commonInit];
    }
    return self;
}
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self=[super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}
/*
 ** 初始化参数
 */
-(void)commonInit{
    [self addBackIma];
    [self addCollection];
}
-(void)addBackIma{
    //背景
    _imageView=[[UIImageView alloc]initWithFrame:self.bounds];
    [self addSubview:_imageView];
    //模糊效果
    UIBlurEffect *effect=[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectView=[[UIVisualEffectView alloc]initWithEffect:effect];
    effectView.frame=self.bounds;
    [self addSubview:effectView];
}
-(void)addCollection{
    KSCardSwitchFlowLayout *layout=[[KSCardSwitchFlowLayout alloc]init];
    [layout setItemSize:CGSizeMake([self cellWidth], [self cellHeight])];
    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [layout setMinimumLineSpacing:[self cellMargin]];
    
    _collectionView=[[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:layout];
    _collectionView.showsHorizontalScrollIndicator=NO;
    _collectionView.backgroundColor=[UIColor clearColor];
    [_collectionView registerClass:[KSCard class] forCellWithReuseIdentifier:@"KSCard"];
    [_collectionView setUserInteractionEnabled:YES];
    _collectionView.delegate=self;
    _collectionView.dataSource=self;
    [self addSubview:_collectionView];
}
#pragma mark-Setter
-(void)setModels:(NSArray *)models{
    _models=models;
    if (_models.count) {
        KSCardModel *model=_models.firstObject;
        _imageView.image=[UIImage imageNamed:model.imageName];
    }
}
#pragma CollectionDelegate
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    _dragStartX=scrollView.contentOffset.x;
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    _dragEndX=scrollView.contentOffset.x;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self fixCellToCenter];
    });
}
-(void)fixCellToCenter{
    //手指最小移动距离，小于这个距离不触发操作
    float dragMiniDistance=self.bounds.size.width/20.0f;
    if (_dragStartX-_dragEndX>=dragMiniDistance) {//视图向右滑
        _currentIndex-=1;
    }else if (_dragEndX-_dragStartX>=dragMiniDistance){//视图向左滑
        _currentIndex+=1;
    }
    NSInteger maxIndex=[_collectionView numberOfItemsInSection:0]-1;
    _currentIndex=_currentIndex<=0?0:_currentIndex;
    _currentIndex=_currentIndex>=maxIndex?maxIndex:_currentIndex;
    [self scrollToCenter];
}
-(void)scrollToCenter{
    static NSInteger lastIndex=1000;//用来保存上一次的Index，初始值1000
    
    [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:_currentIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    
    if (lastIndex==_currentIndex) {
        return;
    }
    
    KSCardModel *model=[_models objectAtIndex:_currentIndex];
    UIImageView *temp=[[UIImageView alloc]initWithFrame:self.bounds];
    temp.image=[UIImage imageNamed:model.imageName];
    [self insertSubview:temp belowSubview:_imageView];
    temp.alpha=0;
    
    [UIView animateWithDuration:0.2 animations:^{
        _imageView.alpha=0;
        temp.alpha=1;
    } completion:^(BOOL finished) {
        [_imageView removeFromSuperview];
        _imageView=temp;
    }];
    
    if (_currenuSelect) {
        _currenuSelect(_currentIndex);
    }
    
    lastIndex=_currentIndex;
}
#pragma CollectionDataSource
-(CGFloat)cellWidth{
    return self.bounds.size.width*CardWidthScale;
}
-(CGFloat)cellHeight{
    return self.bounds.size.height*CardHeightScale;
}
-(CGFloat)cellMargin{
    return (self.bounds.size.width-[self cellWidth])/4;
}
-(CGFloat)collectionInset{
    return self.bounds.size.width/2.0f-[self cellWidth]/2.0f;
}
//设置每组的cell的边界
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, [self collectionInset], 0, [self collectionInset]);
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _models.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID=@"KSCard";
    KSCard *card=[collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    card.model=_models[indexPath.row];
    return card;
}
@end
