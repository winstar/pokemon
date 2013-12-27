//
//  MoveViewController.m
//  pokemon
//
//  Created by 王建平 on 13-7-11.
//  Copyright (c) 2013年 白彝澄源. All rights reserved.
//

#import "MoveViewController.h"
#import "NVSlideMenuController.h"
#import "SqliteHelper.h"
#import "MoveCell.h"
#import "PMTypeColor.h"
#import "MoveItemViewController.h"

@interface MoveViewController ()

@end

@implementation MoveViewController {
    NSMutableArray *moves;
    PMTypeColor *pmTypeColor;
}

@synthesize moveTableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"菜单" style:UIBarButtonSystemItemAction target:self.slideMenuController action:@selector(toggleMenuAnimated:)];
    moves = [[SqliteHelper sharedHelper] getLvMoveArray];
    pmTypeColor = [PMTypeColor shareInstance];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return moves.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"MoveCell";
    
    MoveCell *cell = (MoveCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = (MoveCell *)[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    Move *move = [moves objectAtIndex:indexPath.row];
    cell.idLabel.text = [NSString stringWithFormat:@"%d", move.ID];
    cell.nameLabel.text = move.name;
    cell.propertyLabel.text = [pmTypeColor getTypeName:move.property];
    cell.propertyLabel.backgroundColor = [pmTypeColor getTypeColor:move.property];
    cell.categoryLabel.text = [pmTypeColor getCategoryName:move.category];
    cell.categoryLabel.backgroundColor = [pmTypeColor getCategoryColor:move.category];
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath = [self.moveTableView indexPathForSelectedRow];
    Move *move = [moves objectAtIndex:indexPath.row];
    
    MoveItemViewController *destViewController = segue.destinationViewController;
    destViewController.MoveId = move.ID;
    [destViewController setTitle:move.name];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
