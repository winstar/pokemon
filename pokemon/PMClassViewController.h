//
//  PMClassViewController.h
//  pokemon
//
//  Created by 王建平 on 13-9-14.
//  Copyright (c) 2013年 白彝澄源. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PMClassViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) IBOutlet UITableView *PMTableView;
@property int ID;
@property int category;
@property int FromPM;

@end
