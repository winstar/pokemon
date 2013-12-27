//
//  EntityCalculatorViewController.h
//  pokemon
//
//  Created by 王建平 on 13-7-11.
//  Copyright (c) 2013年 白彝澄源. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Pokemon.h"

@interface EntityCalculatorViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

//@property (nonatomic, strong) Pokemon *pokemon;
@property int level;

@property (nonatomic, weak) IBOutlet UILabel *idLabel;
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UIImageView *pmImageView;

@property (nonatomic, weak) IBOutlet UILabel *levelLabel;
@property (nonatomic, weak) IBOutlet UILabel *nuliLabel;
@property (nonatomic, weak) IBOutlet UILabel *xinggeLabel;

@property (nonatomic, strong) IBOutlet UIControl *panelView;
@property (nonatomic, strong) IBOutlet UITableView *entityTableView;

@end
