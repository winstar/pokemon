//
//  ViewController.m
//  pokemon
//
//  Created by 白彝澄源 on 13-6-20.
//  Copyright (c) 2013年 白彝澄源. All rights reserved.
//

#import "ViewController.h"
#import "PokemonInfoViewController.h"
#import "NVSlideMenuController.h"
#import "PMTableCell.h"
#import "PMTypeColor.h"
#import "PMListTopScrollView.h"
#import "AWActionSheet.h"

@interface ViewController ()
    
@end

@implementation ViewController {
    NSMutableArray *pokemons;
    PMTypeColor *pmTypeColor;
    NSArray *searchPokemons;
    PMListTopScrollView *topView;
    int areaIndex;
}

@synthesize pokemonTableView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"菜单" style:UIBarButtonSystemItemAction target:self.slideMenuController action:@selector(toggleMenuAnimated:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"类别" style:UIBarButtonSystemItemAction target:self action:@selector(searchButtonClicked:)];
    pmTypeColor = [PMTypeColor shareInstance];
    
    pokemons = [[SqliteHelper sharedHelper] getAllPokemon:@"SELECT * FROM Pokemon" withIndex:0];
    areaIndex = 0;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        topView = [[PMListTopScrollView alloc] initWithFrame:CGRectMake(0, 64, 320, 32)];
    } else {
        topView = [[PMListTopScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 32)];
    }
    [self.view addSubview:topView];
    topView.viewController = self;
    [pokemonTableView setFrame:CGRectMake(0, 32, 320, 536)];
    [pokemonTableView setContentOffset:CGPointMake(0, 44)];
}

- (void)searchButtonClicked:(id)sender
{
    
    //[self.searchDisplayController setActive:YES animated:YES];
    //[self.searchDisplayController.searchBar becomeFirstResponder];
    AWActionSheet *sheet = [[AWActionSheet alloc] initWithIconSheetDelegate:self ItemCount:[self numberOfItemsInActionSheet]];
    [sheet showInView:self.view];
}

-(int)numberOfItemsInActionSheet
{
    return 18;
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
        areaIndex = 0;
    } else if ([area isEqualToString:@"关东"]) {
        sql = @"SELECT * FROM Pokemon where Index_Kanto != -1 order by Index_Kanto";
        pokemons = [[SqliteHelper sharedHelper] getAllPokemon:sql withIndex:2];
        areaIndex = 1;
    } else if ([area isEqualToString:@"城都"]) {
        sql = @"SELECT * FROM Pokemon where Index_Johto != -1 order by Index_Johto";
        pokemons = [[SqliteHelper sharedHelper] getAllPokemon:sql withIndex:3];
        areaIndex = 2;
    } else if ([area isEqualToString:@"丰缘"]) {
        sql = @"SELECT * FROM Pokemon where Index_Hoenn != -1 order by Index_Hoenn";
        pokemons = [[SqliteHelper sharedHelper] getAllPokemon:sql withIndex:4];
        areaIndex = 3;
    } else if ([area isEqualToString:@"神奥"]) {
        sql = @"SELECT * FROM Pokemon where Index_Sinnoh != -1 order by Index_Sinnoh";
        pokemons = [[SqliteHelper sharedHelper] getAllPokemon:sql withIndex:5];
        areaIndex = 4;
    } else if ([area isEqualToString:@"合众"]) {
        sql = @"SELECT * FROM Pokemon where Index_Unova != -1 order by Index_Unova";
        pokemons = [[SqliteHelper sharedHelper] getAllPokemon:sql withIndex:6];
        areaIndex = 5;
    }
    searchPokemons = pokemons;
    [pokemonTableView reloadData];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        [pokemonTableView setContentOffset:CGPointMake(0, -20)];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView != pokemonTableView) {
        return [searchPokemons count];
    } else {
        return [pokemons count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"PokemonCell";
    
    PMTableCell *cell = [pokemonTableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = (PMTableCell *)[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    PMCell *pm;
    if (tableView != pokemonTableView) {
        pm = (PMCell *)[searchPokemons objectAtIndex:indexPath.row];
    } else {
        pm = (PMCell *)[pokemons objectAtIndex:indexPath.row];
    }
    
    NSString *areaNum = [NSString stringWithFormat:@"%03d", pm.id];
    NSString *naturalNum = [NSString stringWithFormat:@"%03d", pm.natural];
    cell.idLabel.text = areaNum;
    cell.nameLabel.text = pm.name;
    cell.imageView.image = [UIImage imageNamed:naturalNum];
    cell.imageView.layer.cornerRadius = 20;
    cell.imageView.backgroundColor = [UIColor grayColor];
    if (pm.type1 != 0) {
        cell.type1Label.text = [pmTypeColor getTypeName:pm.type1];
        UIColor *color = [pmTypeColor getTypeColor:pm.type1];
        cell.type1Label.backgroundColor = color;
        cell.type1Label.highlightedTextColor = color;
    } else {
        cell.type1Label.text = @"";
        cell.type1Label.backgroundColor = [UIColor clearColor];
    }
    if (pm.type2 != 0) {
        cell.type2Label.text = [pmTypeColor getTypeName:pm.type2];
        UIColor *color = [pmTypeColor getTypeColor:pm.type2];
        cell.type2Label.backgroundColor = color;
        cell.type2Label.highlightedTextColor = color;
    } else {
        cell.type2Label.text = @"";
        cell.type2Label.backgroundColor = [UIColor clearColor];
    }
    
    return cell;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    NSPredicate *_predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"[0-9]+"];
    if ([_predicate evaluateWithObject:searchString]) {
        //匹配编号
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"id==%d", [searchString intValue]];
        searchPokemons = [pokemons filteredArrayUsingPredicate:predicate];
    } else {
        //匹配名称
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name contains[cd] %@", searchString];
        searchPokemons = [pokemons filteredArrayUsingPredicate:predicate];
    }
    return YES;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    return YES;
}

- (void) searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller
{
    self.slideMenuController.panGestureEnabled = NO;
    //topView.hidden = YES;
}

- (void) searchDisplayControllerDidEndSearch:(UISearchDisplayController *)controller
{
    self.slideMenuController.panGestureEnabled = YES;
    //topView.hidden = NO;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{

    if ([segue.identifier isEqualToString:@"showPokemonInfo"]) {
        PokemonInfoViewController *destViewController = segue.destinationViewController;
        PMCell *pm;
        if (self.searchDisplayController.isActive) {
            NSIndexPath *indexPath = [self.searchDisplayController.searchResultsTableView indexPathForSelectedRow];
            pm  = (PMCell *)[searchPokemons objectAtIndex:indexPath.row];
        } else {
            NSIndexPath *indexPath = [self.pokemonTableView indexPathForSelectedRow];
            pm = (PMCell *)[pokemons objectAtIndex:indexPath.row];
        }
        destViewController.pokemonId = pm.natural;
        destViewController.pokemonName = pm.name;
        destViewController.pokemonType = pm.type1;
        [destViewController setTitle:pm.name];
        self.slideMenuController.panGestureEnabled = NO;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(AWActionSheetCell *)cellForActionAtIndex:(NSInteger)index
{
    AWActionSheetCell* cell = [[AWActionSheetCell alloc] init];
    
    
    [[cell iconView] setBackgroundColor:[pmTypeColor getTypeColor:index + 1]];
    [[cell titleLabel] setText:[pmTypeColor getTypeName:index + 1]];
    cell.index = index;
    return cell;
}

-(void)DidTapOnItemAtIndex:(NSInteger)index
{
    index = index + 1;
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM Pokemon where (Type_1_ID = %d or Type_2_ID = %d) ", index, index];
    if (areaIndex == 0) {
        pokemons = [[SqliteHelper sharedHelper] getAllPokemon:sql withIndex:0];
    } else if (areaIndex == 1) {
        sql = [NSString stringWithFormat:@"%@ and Index_Kanto != -1 order by Index_Kanto", sql];
        pokemons = [[SqliteHelper sharedHelper] getAllPokemon:sql withIndex:2];
    } else if (areaIndex == 2) {
        sql = [NSString stringWithFormat:@"%@ and Index_Johto != -1 order by Index_Johto", sql];
        pokemons = [[SqliteHelper sharedHelper] getAllPokemon:sql withIndex:3];
    } else if (areaIndex == 3) {
        sql = [NSString stringWithFormat:@"%@ and Index_Hoenn != -1 order by Index_Hoenn", sql];
        pokemons = [[SqliteHelper sharedHelper] getAllPokemon:sql withIndex:4];
    } else if (areaIndex == 4) {
        sql = [NSString stringWithFormat:@"%@ and Index_Sinnoh != -1 order by Index_Sinnoh", sql];
        pokemons = [[SqliteHelper sharedHelper] getAllPokemon:sql withIndex:5];
    } else if (areaIndex == 5) {
        sql = [NSString stringWithFormat:@"%@ and Index_Unova != -1 order by Index_Unova", sql];
        pokemons = [[SqliteHelper sharedHelper] getAllPokemon:sql withIndex:6];
    }
    searchPokemons = pokemons;
    [pokemonTableView reloadData];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        [pokemonTableView setContentOffset:CGPointMake(0, -20)];
    }
}

@end
