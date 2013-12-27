//
//  ViewController.h
//  pokemon
//
//  Created by 白彝澄源 on 13-6-20.
//  Copyright (c) 2013年 白彝澄源. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SqliteHelper.h"
#import "AWActionSheet.h"

@interface ViewController : UIViewController<UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate, UISearchDisplayDelegate, UIActionSheetDelegate, AWActionSheetDelegate>

@property (nonatomic, strong) IBOutlet UITableView *pokemonTableView;
@property (nonatomic, copy) void(^onShowMenuButtonClicked)(void);

- (void)setOnShowMenuButtonClicked:(void (^)(void))onShowMenuButtonClicked;
- (void)changeWithArea:(NSString *)area;

@end
