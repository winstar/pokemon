//
//  PokemonInfoViewController.m
//  pokemon
//
//  Created by 白彝澄源 on 13-6-21.
//  Copyright (c) 2013年 白彝澄源. All rights reserved.
//

#import "PokemonInfoViewController.h"
#import "SqliteHelper.h"
#import "TopScrollView.h"
#import "RootScrollView.h"
#import "UIImageView+LBBlurredImage.h"
#import "Globle.h"
#import "Pokemon.h"
#import "PMClassViewController.h"

@interface PokemonInfoViewController ()
    
@end

@implementation PokemonInfoViewController {
    UIImageView *bgImageView;
    NSMutableArray *featureList;
    NSMutableArray *eggList;
}

@synthesize pokemonName;
@synthesize pokemonId;
@synthesize pokemonType;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"类别" style:UIBarButtonSystemItemAction target:self action:@selector(categoryButtonClicked:)];
    
    topView = [TopScrollView shareInstance];
    rootView = [RootScrollView shareInstance];
    [rootView setController:self];
    [rootView loadPMInfoById:pokemonId Type:pokemonType];
    [rootView resetView];
    
    float height = [[Globle shareInstance] globleHeight];
    bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, height)];
    bgImageView.contentMode = UIViewContentModeScaleAspectFill;
    bgImageView.alpha = 0.3;
    
    [bgImageView setImageToBlur:[UIImage imageNamed:[NSString stringWithFormat:@"%03d", pokemonId]]
                     blurRadius:kLBBlurredImageDefaultBlurRadius
                completionBlock:nil];
    [self.view addSubview:bgImageView];
    
    [self.view addSubview:topView];
    [self.view addSubview:rootView];
}

- (void)categoryButtonClicked:(id)sender
{
    Pokemon *pokemon = topView.currPokemon;
    featureList = [NSMutableArray arrayWithCapacity:2];
    eggList = [NSMutableArray arrayWithCapacity:2];
    
    UIActionSheet* mySheet = [[UIActionSheet alloc] initWithTitle:nil
                                                         delegate:self
                                                cancelButtonTitle:nil
                                           destructiveButtonTitle:nil
                                                otherButtonTitles:nil];
    [mySheet setTitle:@"特性及生蛋分组"];
    if (pokemon.ability1ID != 0) {
        [featureList addObject:[NSNumber numberWithInt:pokemon.ability1ID]];
        [mySheet addButtonWithTitle:pokemon.ability1Name];
    }
    if (pokemon.ability2ID != 0) {
        [featureList addObject:[NSNumber numberWithInt:pokemon.ability2ID]];
        [mySheet addButtonWithTitle:pokemon.ability2Name];
    }
    if (pokemon.abilityHID != 0) {
        [featureList addObject:[NSNumber numberWithInt:pokemon.abilityHID]];
        [mySheet addButtonWithTitle:pokemon.abilityHName];
    }
    
    EggType *eggType = [EggType shareInstance];
    if (pokemon.egg1ID != 0) {
        [eggList addObject:[NSNumber numberWithInt:pokemon.egg1ID]];
        [mySheet addButtonWithTitle:[eggType getTypeName:pokemon.egg1ID]];
    }
    
    if (pokemon.egg2ID != 0) {
        [eggList addObject:[NSNumber numberWithInt:pokemon.egg2ID]];
        [mySheet addButtonWithTitle:[eggType getTypeName:pokemon.egg2ID]];
    }
    [mySheet addButtonWithTitle:@"取消"];
    mySheet.cancelButtonIndex = featureList.count + eggList.count;
    [mySheet showInView:self.view];
}

- (void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    //NSLog(@"%d", buttonIndex);
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    PMClassViewController *PMClassVC = [storyBoard instantiateViewControllerWithIdentifier:@"PMClassViewController"];
    PMClassVC.FromPM = 1;
    PMClassVC.title = [actionSheet buttonTitleAtIndex:buttonIndex];
    int featureSize = featureList.count;
    if (buttonIndex < featureSize) {
        int featureId = ((NSNumber *)[featureList objectAtIndex:buttonIndex]).intValue;
        PMClassVC.category = 0;
        PMClassVC.ID = featureId;
        [self.navigationController pushViewController:PMClassVC animated:YES];
    } else if (buttonIndex < featureSize + eggList.count) {
        int eggId = ((NSNumber *)[eggList objectAtIndex:buttonIndex - featureSize]).intValue;
        PMClassVC.category = 1;
        PMClassVC.ID = eggId;
        [self.navigationController pushViewController:PMClassVC animated:YES];
    }
}

- (void)changePokemon:(int)id
{
    pokemonId = id;
    NSMutableArray *pmList = [[SqliteHelper sharedHelper] getPokemon:id];
    Pokemon *pokemon = [pmList objectAtIndex:0];
    pokemonType = pokemon.type1;
    [self setTitle:pokemon.name];
    [rootView loadPMInfoById:pokemonId Type:pokemonType];
    [rootView resetView];
    [bgImageView setImageToBlur:[UIImage imageNamed:[NSString stringWithFormat:@"%03d", pokemonId]]
                     blurRadius:kLBBlurredImageDefaultBlurRadius
                completionBlock:nil];
}

- (void)selectNameButton:(UIButton *)sender
{
    [[self navigationController] popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
