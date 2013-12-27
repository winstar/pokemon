//
//  TestViewController.m
//  pokemon
//
//  Created by 王建平 on 13-7-10.
//  Copyright (c) 2013年 白彝澄源. All rights reserved.
//

#import "TestViewController.h"
#import "SqliteHelper.h"
#import "PokemonInfoViewController.h"
#import "NVSlideMenuController.h"
#import "PMTableCell.h"
#import "PMTypeColor.h"
#import "PMListTopScrollView.h"
#import "TestCell.h"

@implementation TestViewController {
    NSMutableArray *pokemons;
    PMTypeColor *pmTypeColor;
}

@synthesize pokemonTableView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    //self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRewind target:self.slideMenuController action:@selector(toggleMenuAnimated:)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"菜单" style:UIBarButtonSystemItemAction target:self.slideMenuController action:@selector(toggleMenuAnimated:)];
    
    pmTypeColor = [PMTypeColor shareInstance];
    pokemons = [[SqliteHelper sharedHelper] getAllPokemon:@"SELECT * FROM Pokemon" withIndex:0];
}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	self.slideMenuController.panGestureEnabled = YES;
}

- (void)changeWithArea:(NSString *)area
{
    NSString *sql;
    if ([area isEqualToString:@"全国"]) {
        sql = @"SELECT * FROM Pokemon";
        pokemons = [[SqliteHelper sharedHelper] getAllPokemon:sql withIndex:0];
    } else if ([area isEqualToString:@"关东"]) {
        sql = @"SELECT * FROM Pokemon where Index_Kanto != -1 order by Index_Kanto";
        pokemons = [[SqliteHelper sharedHelper] getAllPokemon:sql withIndex:2];
    } else if ([area isEqualToString:@"城都"]) {
        sql = @"SELECT * FROM Pokemon where Index_Johto != -1 order by Index_Johto";
        pokemons = [[SqliteHelper sharedHelper] getAllPokemon:sql withIndex:3];
    } else if ([area isEqualToString:@"丰缘"]) {
        sql = @"SELECT * FROM Pokemon where Index_Hoenn != -1 order by Index_Hoenn";
        pokemons = [[SqliteHelper sharedHelper] getAllPokemon:sql withIndex:4];
    } else if ([area isEqualToString:@"神奥"]) {
        sql = @"SELECT * FROM Pokemon where Index_Sinnoh != -1 order by Index_Sinnoh";
        pokemons = [[SqliteHelper sharedHelper] getAllPokemon:sql withIndex:5];
    } else if ([area isEqualToString:@"合众"]) {
        sql = @"SELECT * FROM Pokemon where Index_Unova != -1 order by Index_Unova";
        pokemons = [[SqliteHelper sharedHelper] getAllPokemon:sql withIndex:6];
    }
    [pokemonTableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [pokemons count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"TestCell";
    
    TestCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = (TestCell *)[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    PMCell *pm = (PMCell *)[pokemons objectAtIndex:indexPath.row];
    cell.nameLabel.text = pm.name;
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
