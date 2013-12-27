//
//  AbilityViewController.h
//  pokemon
//
//  Created by 王建平 on 13-7-11.
//  Copyright (c) 2013年 白彝澄源. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AbilityViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) IBOutlet UITableView *abilityTableView;

@end
