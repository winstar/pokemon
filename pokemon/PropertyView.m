//
//  PropertyView.m
//  pokemon
//
//  Created by 王建平 on 13-7-6.
//  Copyright (c) 2013年 白彝澄源. All rights reserved.
//

#import "PropertyView.h"
#import "xkViewController.h"
#import "PokemonInfoViewController.h"

@implementation PropertyView {

    PMTypeColor *pmTypeColor;
    NSMutableArray *propertyLabelList;
    NSMutableArray *propertyDataList;
    UIColor *defaultColor;
    ShapeTableView *shapeTableView;
    UILabel *proNameLable;
    UILabel *type1Label;
    UILabel *type2Label;
    UIImageView *lineView;
    UIButton *btn;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        pmTypeColor = [PMTypeColor shareInstance];
        propertyLabelList = [NSMutableArray arrayWithCapacity:18];
        propertyDataList = [NSMutableArray arrayWithCapacity:18];
        defaultColor = [UIColor colorWithRed:0 green:0.75 blue:0.5 alpha:1];
        [self loadUI];
        
        shapeTableView = [[ShapeTableView alloc] initWithFrame:CGRectMake(0, 10, 100, 462) style:UITableViewStylePlain];
        shapeTableView.rowHeight = 25.0;
        shapeTableView.backgroundColor = [UIColor clearColor];
        shapeTableView.dataSource = shapeTableView;
        shapeTableView.delegate = shapeTableView;
        [self addSubview:shapeTableView];
    }
    return self;
}

- (void) loadUI
{
    proNameLable = [[UILabel alloc] initWithFrame:CGRectMake(120, 10, 60, 20)];
    proNameLable.text = @"当前属性";
    proNameLable.backgroundColor = [UIColor clearColor];
    proNameLable.textColor = [UIColor grayColor];
    proNameLable.font = [UIFont systemFontOfSize:14];
    [self addSubview:proNameLable];
    
    type1Label = [[UILabel alloc] initWithFrame:CGRectMake(190, 10, 20, 20)];
    type1Label.textColor = [UIColor whiteColor];
    type1Label.textAlignment = NSTextAlignmentCenter;
    type1Label.font = [UIFont systemFontOfSize:14];
    [self addSubview:type1Label];
    
    type2Label = [[UILabel alloc] initWithFrame:CGRectMake(213, 10, 20, 20)];
    type2Label.textColor = [UIColor whiteColor];
    type2Label.textAlignment = NSTextAlignmentCenter;
    type2Label.font = [UIFont systemFontOfSize:14];
    [self addSubview:type2Label];
    
    lineView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 40, 220, 0.4)];
    lineView.image = [UIImage imageNamed:@"line"];
    [self addSubview:lineView];
    
    for (int k=0; k<17; k++) {
        int i = k % 6;
        int j = k / 6;
        UILabel *pLabel = [[UILabel alloc] initWithFrame:CGRectMake(120 + i * 32, 50 + j * 50, 20, 20)];
        pLabel.font = [UIFont systemFontOfSize:14];
        pLabel.textColor = [UIColor whiteColor];
        pLabel.backgroundColor = [pmTypeColor getTypeColor:k+1];
        pLabel.textAlignment = NSTextAlignmentCenter;
        pLabel.text = [pmTypeColor getTypeName:k + 1];
        [propertyLabelList addObject:pLabel];
        [self addSubview:pLabel];
        
        UILabel *vLabel = [[UILabel alloc] initWithFrame:CGRectMake(120 + i * 32, 71 + j * 50, 20, 20)];
        vLabel.font = [UIFont systemFontOfSize:13];
        vLabel.textAlignment = NSTextAlignmentCenter;
        vLabel.backgroundColor = [UIColor clearColor];
        [propertyDataList addObject:vLabel];
        [self addSubview:vLabel];
        
    }
    
    btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:@"攻防属性相克表" forState:UIControlStateNormal];
    [btn setTitle:@"攻防属性相克表" forState:UIControlStateSelected];
    [btn addTarget:self action:@selector(startBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
}

- (void)startBtnClick
{
    PokemonInfoViewController *controller;
    
    controller = (PokemonInfoViewController *)self.superview.superview.nextResponder;
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    xkViewController *menuVC = [storyBoard instantiateViewControllerWithIdentifier:@"SHUXINGViewController"];
    menuVC.isOpenInView = YES;
        
    [[controller navigationController] pushViewController:menuVC animated:YES];
}

- (void) loadData:(int)pmId
{
    NSMutableArray *propertyArray = [[SqliteHelper sharedHelper] getProperty:pmId];
    [shapeTableView setShapeArray:propertyArray];
    
    if (propertyArray.count == 1) {
        btn.frame = CGRectMake(20, 160, 150, 30);
        proNameLable.frame = CGRectMake(24, 10, 60, 20);
        type1Label.frame = CGRectMake(94, 10, 20, 20);
        type2Label.frame = CGRectMake(117, 10, 20, 20);
        lineView.frame = CGRectMake(0, 40, 320, 0.4);
        shapeTableView.hidden = YES;
        for (int k=0; k<17; k++) {
            int i = k % 9;
            int j = k / 9;
            UILabel *vLabel = [propertyLabelList objectAtIndex:k];
            UILabel *pLabel = [propertyDataList objectAtIndex:k];
            vLabel.frame = CGRectMake(24 + i * 32, 50 + j * 50, 20, 20);
            pLabel.frame = CGRectMake(24 + i * 32, 71 + j * 50, 20, 20);
        }
    } else {
        btn.frame = CGRectMake(110, 220, 150, 30);
        proNameLable.frame = CGRectMake(120, 10, 60, 20);
        type1Label.frame = CGRectMake(190, 10, 20, 20);
        type2Label.frame = CGRectMake(213, 10, 20, 20);
        lineView.frame = CGRectMake(100, 40, 220, 0.4);
        shapeTableView.hidden = NO;
        for (int k=0; k<17; k++) {
            int i = k % 6;
            int j = k / 6;
            UILabel *vLabel = [propertyLabelList objectAtIndex:k];
            UILabel *pLabel = [propertyDataList objectAtIndex:k];
            vLabel.frame = CGRectMake(120 + i * 32, 50 + j * 50, 20, 20);
            pLabel.frame = CGRectMake(120 + i * 32, 71 + j * 50, 20, 20);
        }
    }
}

- (void) loadShapeData:(Property *)property
{
    type1Label.text = [[PMTypeColor shareInstance] getTypeName:property.type1];
    type1Label.backgroundColor = [[PMTypeColor shareInstance] getTypeColor:property.type1];
    
    type2Label.text = [[PMTypeColor shareInstance] getTypeName:property.type2];
    type2Label.backgroundColor = [[PMTypeColor shareInstance] getTypeColor:property.type2];
    
    NSMutableArray *propertyArray = [property getPropertyArray];
    for (int k=0; k<17; k++) {
        NSString *proValue = [propertyArray objectAtIndex:k];
        UILabel *pLabel = [propertyDataList objectAtIndex:k];
        [pLabel setText:proValue];
        if ([proValue isEqualToString:@"1"]) {
            pLabel.textColor = defaultColor;
        } else if ([proValue isEqualToString:@"0"]) {
            pLabel.textColor = [UIColor blackColor];
        } else if ([proValue isEqualToString:@"2"] || [proValue isEqualToString:@"4"]) {
            pLabel.textColor = [UIColor redColor];
        } else {
            pLabel.textColor = [UIColor blueColor];
        }
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
