//
//  KSCardSwitchFlowLayout.m
//  KSCardSwitchDemo
//
//  Created by 康帅 on 17/2/28.
//  Copyright © 2017年 Bujiaxinxi. All rights reserved.
//

#import "KSCardSwitchFlowLayout.h"

@implementation KSCardSwitchFlowLayout
-(NSArray <UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSArray *arr=[self getCopyOfAttributes:[super layoutAttributesForElementsInRect:rect]];
    CGFloat centerX=self.collectionView.contentOffset.x+self.collectionView.bounds.size.width/2;
    
    //刷新cell缩放动画
    for (UICollectionViewLayoutAttributes *attribute in arr) {
        CGFloat distance=fabs(attribute.center.x-centerX);
        CGFloat apartScale=distance/self.collectionView.bounds.size.width;
        CGFloat scale=fabs(cos(apartScale*M_PI/4));
        attribute.transform=CGAffineTransformMakeScale(1.0, scale);
    }
    return arr;
}

-(BOOL) shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}

-(NSArray *)getCopyOfAttributes:(NSArray *)attributes{
    NSMutableArray *copyArr=[NSMutableArray new];
    for (UICollectionViewLayoutAttributes *attribute in attributes) {
        [copyArr addObject:[attribute copy]];
    }
    return copyArr;
}
@end
