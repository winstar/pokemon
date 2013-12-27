//
//  TestViewController.h
//  pokemon
//
//  Created by 王建平 on 13-7-10.
//  Copyright (c) 2013年 白彝澄源. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TestViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) IBOutlet UITableView *pokemonTableView;

@end
