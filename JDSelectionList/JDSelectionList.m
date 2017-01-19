//
//  JDSelectionList.m
//  SelectList
//
//  Created by 黄景达 on 2017/1/17.
//  Copyright © 2017年 YellowHuang. All rights reserved.
//

#import "JDSelectionList.h"

@interface JDSelectionList ()

@property (nonatomic, strong) UIView *bottomLine;
@property (nonatomic, strong) NSMutableArray *buttonArray;
@property (nonatomic, assign) NSInteger currentIndex;

@end

@implementation JDSelectionList


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //设置参数默认值
        _titleColor = [UIColor grayColor];
        _selectColor = [UIColor orangeColor];
        _fontSize = 14.0f;
        _bottomLineColor = [UIColor orangeColor];
        _bottomLineHeight = 2.0f;
        _contentOfIndex = 0;
        _bottomLineMultiplier = 0.9f;
        _currentIndex = _contentOfIndex;
        //下划线
        _bottomLine = [[UIView alloc] init];
        _bottomLine.backgroundColor = _bottomLineColor;
        [self addSubview:_bottomLine];
        //初始化 button 数组
        _buttonArray = [NSMutableArray array];
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    if (self.buttonArray.count == 0) {
        [self createUI];
    }
    
}

- (void)reloadData{
    
    for (UIButton *button in self.buttonArray) {
        [button removeFromSuperview];
    }
    [self.buttonArray removeAllObjects];
    [self createUI];
}

- (void)createUI{
    //获取 button 个数
    NSInteger buttonCount = [self.dataSource numberOfItemsInSelectionList:self];
    if (buttonCount < 1) {
        return;
    }
    
    CGFloat buttonHeight = self.frame.size.height - self.bottomLineHeight;//宽
    CGFloat buttonWidth = self.frame.size.width / buttonCount;//长
    CGFloat buttonY = 0;//Y 坐标
    
    //创建并设置 buttons
    for (NSInteger index = 0; index < buttonCount; index ++) {
        
        CGFloat buttonX = buttonWidth * index;//X 坐标
        
        UIButton *button = [self createButtonWithIndex:index];
        button.frame = CGRectMake(buttonX,
                                  buttonY,
                                  buttonWidth,
                                  buttonHeight);
        
        [self addSubview:button];
        [self.buttonArray addObject:button];
    }
    
    if (self.buttonArray.count) {
        UIButton *initialButton = self.buttonArray[self.contentOfIndex];
        initialButton.selected = YES;
        CGFloat bottomLineHeight = self.bottomLineHeight;
        CGFloat bottomLineWidth = buttonWidth * self.bottomLineMultiplier;
        CGFloat bottomLineX = initialButton.frame.origin.x + (buttonWidth - bottomLineWidth)/2;
        CGFloat bottomLineY = initialButton.frame.origin.y + initialButton.frame.size.height;
        self.bottomLine.frame = CGRectMake(bottomLineX,
                                           bottomLineY,
                                           bottomLineWidth,
                                           bottomLineHeight);
    }
    
}

- (UIButton *)createButtonWithIndex:(NSInteger)index{
    
    //通过代理取出 title
    NSString *title = [self.dataSource selectionList:self titleForItemAtIndex:index];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:self.titleColor forState:UIControlStateNormal];
    [button setTitleColor:self.selectColor forState:UIControlStateSelected];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.font = [UIFont systemFontOfSize:self.fontSize];
    
    return button;
}

- (void)buttonAction:(UIButton *)button{
    for (UIButton *button in self.buttonArray) {
        button.selected = NO;
    }
    
    button.selected = YES;
    
    NSInteger buttonOfIndex = [self.buttonArray indexOfObject:button];
    //如果buttonOfIndex找不到或者等于当前buttonOfIndex则 return
    if (buttonOfIndex == NSNotFound || buttonOfIndex == self.currentIndex) {
        return;
    }
    
    self.currentIndex = buttonOfIndex;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(selecotionList:didSelectButtonAtIndex:)]) {
        [self.delegate selecotionList:self didSelectButtonAtIndex:buttonOfIndex];
    }
    
    [self layoutIfNeeded];
    [UIView animateWithDuration:0.4
                          delay:0
         usingSpringWithDamping:0.5
          initialSpringVelocity:0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         //动画内容
                         CGFloat bottomLineHeight = self.bottomLineHeight;
                         CGFloat bottomLineWidth = button.frame.size.width * self.bottomLineMultiplier;
                         CGFloat bottomLineX = button.frame.origin.x + (button.frame.size.width - bottomLineWidth)/2;
                         CGFloat bottomLineY = button.frame.origin.y + button.frame.size.height;
                         
                         self.bottomLine.frame = CGRectMake(bottomLineX,
                                                            bottomLineY,
                                                            bottomLineWidth, bottomLineHeight);
                         
    } completion:^(BOOL finished) {
        
    }];
    
    
    
}
//跳转到对应下标 button
- (void)scrollToButtonAtIndex:(NSInteger)index{
    
    @try {
        
        UIButton *newSelectedButton = self.buttonArray[index];
        UIButton *oldSelectedButton = self.buttonArray[self.currentIndex];
        
        oldSelectedButton.selected = NO;
        newSelectedButton.selected = YES;
        self.currentIndex = index;
        
        [self layoutIfNeeded];
        [UIView animateWithDuration:0.4
                              delay:0
             usingSpringWithDamping:0.5
              initialSpringVelocity:0
                            options:UIViewAnimationOptionCurveLinear
                         animations:^{
                             //动画内容
                             CGFloat bottomLineHeight = self.bottomLineHeight;
                             CGFloat bottomLineWidth = newSelectedButton.frame.size.width * self.bottomLineMultiplier;
                             CGFloat bottomLineX = newSelectedButton.frame.origin.x + (newSelectedButton.frame.size.width - bottomLineWidth)/2;
                             CGFloat bottomLineY = newSelectedButton.frame.origin.y + newSelectedButton.frame.size.height;
                             
                             self.bottomLine.frame = CGRectMake(bottomLineX,
                                                                bottomLineY,
                                                                bottomLineWidth, bottomLineHeight);
                             
                         } completion:^(BOOL finished) {
                             
                         }];
        
    } @catch (NSException *exception) {
        NSLog(@"%s\n %@", __FUNCTION__, exception);
    } @finally {
        
    }
    
}

@end
