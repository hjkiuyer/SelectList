//
//  ViewController.m
//  SelectList
//
//  Created by 黄景达 on 2017/1/16.
//  Copyright © 2017年 YellowHuang. All rights reserved.
//

#import "ViewController.h"
#import "JDSelectionList.h"

@interface ViewController ()<JDSelectionListDelegate, JDSelectionListDataSource>

@property (nonatomic, strong) NSArray *titleArr;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) JDSelectionList *listView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake((375 - 100) / 2.0, 400, 100, 40);
    [button addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"点击跳转" forState: UIControlStateNormal];
    button.backgroundColor = [UIColor grayColor];
    [self.view addSubview:button];
    
    self.label = [[UILabel alloc] init];
    self.label.frame = CGRectMake((375 - 100) / 2.0 , 300, 100, 30);
    [self.view addSubview:self.label];
    
    JDSelectionList *listView = [[JDSelectionList alloc] init];
    self.listView = listView;
    listView.delegate = self;
    listView.dataSource = self;
//    listView.fontSize = 16;
//    listView.backgroundColor = [UIColor yellowColor];
//    listView.bottomLineMultiplier = 0.4;
//    listView.contentOfIndex = 3;
//    listView.bottomLineHeight = 5;
    listView.frame = CGRectMake(0, 50, 375, 30);
    
    [self.view addSubview:listView];
    
    self.titleArr = @[@"待付款",@"已付款",@"已发货",@"待评价",@"已完成",@"退款/货"];
    
}

- (void)action:(UIButton *)sender{
    
    [self.listView scrollToButtonAtIndex:7];
    
}

- (NSInteger)numberOfItemsInSelectionList:(JDSelectionList *)selectionList{
    return self.titleArr.count;
}
- (NSString *)selectionList:(JDSelectionList *)selectionList titleForItemAtIndex:(NSInteger)index{
    return self.titleArr[index];
}

- (void)selecotionList:(JDSelectionList *)selectionList didSelectButtonAtIndex:(NSInteger)index{
    NSLog(@" 点击下标%ld", index);
    self.label.text = [NSString stringWithFormat:@"点击了下标%ld", index];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
