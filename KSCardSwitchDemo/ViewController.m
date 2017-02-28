//
//  ViewController.m
//  KSCardSwitchDemo
//
//  Created by 康帅 on 17/2/27.
//  Copyright © 2017年 Bujiaxinxi. All rights reserved.
//

#import "ViewController.h"
#import "KSCardModel.h"
#import "KSCardSwitch.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"KSCardSwitch";
    self.view.backgroundColor=[UIColor whiteColor];
    
    NSString *filePath=[[NSBundle mainBundle] pathForResource:@"DataPropertyList" ofType:@"plist"];
    NSArray *arr=[NSArray arrayWithContentsOfFile:filePath];
    NSMutableArray *models=[NSMutableArray array];
    for (NSDictionary *dic in arr) {
        KSCardModel *model=[KSCardModel new];
        [model setValuesForKeysWithDictionary:dic];
        [models addObject:model];
    }
    
    KSCardSwitch *view=[[KSCardSwitch alloc]initWithFrame:self.view.bounds];
    view.models=models;
    view.currenuSelect=^(NSInteger currentIndex){
        NSLog(@"当前选中第%ld个",(long)currentIndex);
    };
    [self.view addSubview:view];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
