//
//  JDSelectionList.h
//  SelectList
//
//  Created by 黄景达 on 2017/1/17.
//  Copyright © 2017年 YellowHuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JDSelectionListDataSource;
@protocol JDSelectionListDelegate;


@interface JDSelectionList : UIView

@property (nonatomic, weak) id<JDSelectionListDelegate> delegate;
@property (nonatomic, weak) id<JDSelectionListDataSource> dataSource;

//跳转到对应下标的 button
- (void)scrollToButtonAtIndex:(NSInteger)index;
- (void)reloadData;

@property (nonatomic, strong) UIColor *titleColor;// normal字体颜色
@property (nonatomic, strong) UIColor *selectColor;//选中的字体颜色
@property (nonatomic, strong) UIColor *bottomLineColor;//下划线颜色
@property (nonatomic, assign) CGFloat bottomLineHeight;//下划线高度
@property (nonatomic, assign) CGFloat fontSize;//字体大小
@property (nonatomic, assign) NSInteger contentOfIndex;//默认选择的下标
@property (nonatomic, assign) CGFloat bottomLineMultiplier;//下划线比例 0 - 1

@end

//*******               //

@protocol JDSelectionListDelegate <NSObject>

- (void)selecotionList:(JDSelectionList *)selectionList didSelectButtonAtIndex:(NSInteger)index;

@end

@protocol JDSelectionListDataSource <NSObject>

@required

- (NSInteger)numberOfItemsInSelectionList:(JDSelectionList *)selectionList;
- (NSString *)selectionList:(JDSelectionList *)selectionList titleForItemAtIndex:(NSInteger)index;

@end
