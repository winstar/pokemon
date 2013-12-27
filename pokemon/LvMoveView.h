//
//  LvMoveView.h
//  pokemon
//
//  Created by 王建平 on 13-7-9.
//  Copyright (c) 2013年 白彝澄源. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LvMoveView : UIView <UITableViewDataSource, UITableViewDelegate> {
    UITableView *moveTableView;
}

- (void)loadData:(int)id Type:(int)type1;

@end
