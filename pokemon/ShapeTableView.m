//
//  ShapeTableView.m
//  pokemon
//
//  Created by 王建平 on 13-7-6.
//  Copyright (c) 2013年 白彝澄源. All rights reserved.
//

#import "ShapeTableView.h"

@implementation ShapeTableView {
    NSMutableArray *shapeInfoArray;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [shapeInfoArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"ShapeCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
        cell.backgroundColor = [UIColor clearColor];
    }
    Property *property = [shapeInfoArray objectAtIndex:indexPath.row];
    if ([shapeInfoArray count] == 1) {
        cell.textLabel.text = @"普通形态";
        cell.textLabel.highlightedTextColor = [UIColor blackColor];
    } else {
        cell.textLabel.text = property.shape;
        cell.textLabel.highlightedTextColor = [[PMTypeColor shareInstance] getTypeColor:property.type1];
    }
    
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.textColor = [UIColor grayColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PropertyView *propertyView = (PropertyView *)self.superview;
    Property *property = [shapeInfoArray objectAtIndex:indexPath.row];
    [propertyView loadShapeData:property];
}

- (void)setShapeArray:(NSMutableArray *)array
{
    shapeInfoArray = array;
    [self reloadData];
    NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:0];
    [self selectRowAtIndexPath:index animated:NO scrollPosition:UITableViewScrollPositionNone];
    PropertyView *propertyView = (PropertyView *)self.superview;
    Property *property = [shapeInfoArray objectAtIndex:0];
    [propertyView loadShapeData:property];
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
