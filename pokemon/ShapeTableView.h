//
//  ShapeTableView.h
//  pokemon
//
//  Created by 王建平 on 13-7-6.
//  Copyright (c) 2013年 白彝澄源. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Property.h"
#import "PropertyView.h"

@interface ShapeTableView : UITableView <UITableViewDelegate, UITableViewDataSource>

- (void)setShapeArray:(NSMutableArray *)array;

@end
