//
//  MidiaViewViewController.m
//  iTunesSearch
//
//  Created by Felipe Marques Ramos on 13/03/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import "MidiaViewViewController.h"

@interface MidiaViewViewController ()

@end

@implementation MidiaViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.nome setText:_midia.nome];
    
    [self.preco setText:[NSString stringWithFormat:@"USD :%@",_midia.preco]];
    
    NSData *data=[NSData dataWithContentsOfURL:[NSURL URLWithString:_midia.imgUrl]];
    UIImage *img=[UIImage imageWithData:data];
    [self.img setImage:img];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
