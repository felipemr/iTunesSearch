//
//  MidiaViewViewController.h
//  iTunesSearch
//
//  Created by Felipe Marques Ramos on 13/03/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Midia.h"

@interface MidiaViewViewController : UIViewController

@property (weak,nonatomic) Midia *midia;

@property (weak, nonatomic) IBOutlet UILabel *nome;

@property (strong, nonatomic) IBOutlet UIImageView *img;

@property (weak, nonatomic) IBOutlet UILabel *preco;

@end
