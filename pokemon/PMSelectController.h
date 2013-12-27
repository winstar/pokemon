//
//  PMSelectController.h
//  pokemon
//
//  Created by 王建平 on 13-7-13.
//  Copyright (c) 2013年 白彝澄源. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PMSelectController : UIViewController<UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate, UISearchDisplayDelegate>

@property (nonatomic, strong) IBOutlet UITableView *pmListTableView;

@end
