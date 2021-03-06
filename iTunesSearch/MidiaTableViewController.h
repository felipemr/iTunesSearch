//
//  ViewController.h
//  iTunesSearch
//
//  Created by joaquim on 09/03/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iTunesManager.h"

@interface MidiaTableViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property iTunesManager *itunes;
@property (strong, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet UITextField *searchText;
@property (weak, nonatomic) IBOutlet UIButton *searchBtn;

- (IBAction)search:(id)sender;

@end

