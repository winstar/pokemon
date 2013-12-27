//
//  PropertyView.h
//  pokemon
//
//  Created by 王建平 on 13-7-6.
//  Copyright (c) 2013年 白彝澄源. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PMTypeColor.h"
#import "SqliteHelper.h"
#import "ShapeTableView.h"

@interface PropertyView : UIView

- (void) loadData:(int)pmId;
- (void) loadShapeData:(Property *)property;

@end
