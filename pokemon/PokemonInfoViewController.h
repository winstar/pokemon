//
//  PokemonInfoViewController.h
//  pokemon
//
//  Created by 白彝澄源 on 13-6-21.
//  Copyright (c) 2013年 白彝澄源. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopScrollView.h"
#import "RootScrollView.h"

@interface PokemonInfoViewController : UIViewController<UIActionSheetDelegate> {
    TopScrollView *topView;
    RootScrollView *rootView;
}
@property (nonatomic, strong) NSString *pokemonName;
@property int pokemonId;
@property int pokemonType;

- (void)changePokemon:(int)id;

@end
