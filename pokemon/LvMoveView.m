//
//  LvMoveView.m
//  pokemon
//
//  Created by 王建平 on 13-7-9.
//  Copyright (c) 2013年 白彝澄源. All rights reserved.
//

#import "LvMoveView.h"
#import "SqliteHelper.h"
#import "LvMoveCell.h"
#import "PMTypeColor.h"
#import "MoveItemViewController.h"

@implementation LvMoveView {
    NSMutableArray *moveArray;
    NSMutableArray *columnLabelArray;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        moveTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 24, frame.size.width, frame.size.height - 24)];
        moveArray = [[NSMutableArray alloc] init];
        columnLabelArray = [[NSMutableArray alloc] initWithCapacity:7];
        moveTableView.delegate = self;
        moveTableView.dataSource = self;
        moveTableView.backgroundColor = [UIColor clearColor];
        moveTableView.showsHorizontalScrollIndicator = NO;
        moveTableView.showsVerticalScrollIndicator = NO;
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:moveTableView];
        NSArray *columnArray = [NSArray arrayWithObjects:@"等级", @"技能", @"属性", @"分类", @"威力", @"命中率", @"PP", nil];
        int weight[7] = {33,80,30,40,30,40,30};
        int wt = 15;
        for (int i=0; i<7; i++) {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(wt, 2, weight[i], 20)];
            label.textAlignment = NSTextAlignmentCenter;
            label.backgroundColor = [UIColor grayColor];
            label.text = [columnArray objectAtIndex:i];
            label.textColor = [UIColor whiteColor];
            label.font = [UIFont systemFontOfSize:12];
            [self addSubview:label];
            [columnLabelArray addObject:label];
            wt = wt + weight[i] + 2;
        }
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [moveArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"LvMoveCell";
    
    LvMoveCell *cell = (LvMoveCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[LvMoveCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    LvMove *lm = (LvMove *)[moveArray objectAtIndex:indexPath.row];
    [cell setLvMove:lm];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LvMove *lm = (LvMove *)[moveArray objectAtIndex:indexPath.row];
    NSLog(@"%d", lm.moveId);
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MoveItemViewController *moveVC = [storyBoard instantiateViewControllerWithIdentifier:@"MoveItemViewController"];
    moveVC.MoveId = lm.moveId;
    moveVC.FromPM = 1;
    [[self viewController].navigationController pushViewController:moveVC animated:YES];
}

- (UIViewController *)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 28;
}

- (void)loadData:(int)id Type:(int)type1
{
    UIColor *topBgColor = [[PMTypeColor shareInstance] getTypeColor:type1];
    for (UILabel *label in columnLabelArray) {
        label.backgroundColor = topBgColor;
    }
    moveArray = [[SqliteHelper sharedHelper] getLvMove:id];
    [moveTableView reloadData];
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
