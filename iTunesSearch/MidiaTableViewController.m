 //
//  ViewController.m
//  iTunesSearch
//
//  Created by joaquim on 09/03/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import "MidiaTableViewController.h"
#import "TableViewCell.h"
#import "iTunesManager.h"
//#import "Entidades/Filme.h"
#import "Entidades/Midia.h"
#import "MidiaViewViewController.h"

@interface MidiaTableViewController () {
    NSArray *midias;
}

@end

@implementation MidiaTableViewController

@synthesize itunes,searchBtn;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"Itunes Search"];
    itunes = [iTunesManager sharedInstance];
    [self.tableview reloadData];
    
    UINib *nib = [UINib nibWithNibName:@"TableViewCell" bundle:nil];
    [self.tableview registerNib:nib forCellReuseIdentifier:@"celulaPadrao"];

    
    [searchBtn setTitle:NSLocalizedString(@"Search", @"botao de pesquisa") forState:UIControlStateNormal];
    
// Necessario para que a table view tenha um espaco em relacao ao topo, pois caso contrario o texto ficara atras da barra superior
    self.tableview.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.tableview.bounds.size.width, 15.f)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Metodos do UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [midias count];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return [midias[0] count];
            break;
            
        case 1:
            return [midias[1] count];
            break;
        case 2:
            return [midias[2] count];
            break;
        case 3:
            return [midias[3] count];
            break;
        case 4:
            return [midias[4] count];
            break;
        default:
            return 0;
            break;
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *celula = [self.tableview dequeueReusableCellWithIdentifier:@"celulaPadrao"];
    long row=indexPath.row;
    Midia *midia = [midias[indexPath.section] objectAtIndex:row];
    [celula.nome setText:midia.nome];
    [celula.tipo setText:midia.tipo];
    [celula.genero setText:midia.genero];
    [celula.artista setText:midia.artista];
    
    [celula.imgView setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:midia.imgUrl]]]];
//        //    float duracaoH= [filme.duracao floatValue]/3600000;
//        //    [celula.duracao setText:[NSString stringWithFormat:@"%f.2",duracaoH]];
        [celula.preco setText:[NSString stringWithFormat:@"USD:%@",midia.preco]];
    
    return celula;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    Midia *midia=midias[section][0];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 18)];
    /* Create custom view to display section header... */
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(22, 3, tableView.frame.size.width, 18)];
    
    UIImage *imgM=[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",midia.tipo]];
    UIImageView *img =[[UIImageView alloc]initWithImage:imgM];
    img.frame=CGRectMake(5, 5, 15, 15);
    
    label.text=midia.tipo;
    
    [view addSubview:label];
    [view addSubview:img];
    [view setBackgroundColor:[UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1]];
    return view;
}

#pragma Table View Delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"oopa %@",indexPath);
    MidiaViewViewController *mvc=[[MidiaViewViewController alloc]init];
    long section=indexPath.section;
    long row = indexPath.row;
    NSArray *tipoMidia=midias[section];
    mvc.midia=tipoMidia[row];
    [self.navigationController pushViewController:mvc animated:YES];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
} 


- (IBAction)search:(id)sender {
    midias = [itunes buscarMidias:_searchText.text];
    [self.tableview reloadData];
}
@end
