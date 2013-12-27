//
//  MenuViewController.h
//  pokemon
//
//  Created by 白彝澄源 on 13-6-22.
//  Copyright (c) 2013年 白彝澄源. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AGMedallionView.h"

@interface MenuViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) IBOutlet UITableView *menuTableView;
@property (nonatomic, strong) IBOutlet UIImageView *bgImageView;
@property (nonatomic, strong) IBOutlet AGMedallionView *medallionView;
@property (nonatomic, strong) IBOutlet UIView *headerView;
@property (nonatomic, strong) IBOutlet UIView *imagePanel;
@property (nonatomic, strong) IBOutlet UIImageView *pmImageView;
@property (nonatomic, strong) IBOutlet UILabel *nameLabel;
@property int currentMenu;

@end
