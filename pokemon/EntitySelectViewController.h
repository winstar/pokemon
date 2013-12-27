//
//  EntitySelectViewController.h
//  pokemon
//
//  Created by 王建平 on 13-7-14.
//  Copyright (c) 2013年 白彝澄源. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EntitySelectViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property int index;
@property (nonatomic, strong) IBOutlet UITableView *selectTableView;

@end
