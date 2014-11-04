//
//  ViewController.m
//  RLPickerTableViewDemo
//
//  Created by tempus-MAC on 14-11-4.
//  Copyright (c) 2014年 tempus. All rights reserved.
//

#import "ViewController.h"
#import "RLPickerTableView.h"

@interface ViewController ()

@property(nonatomic,strong)NSArray *arrayTitle;
@property(nonatomic)NSInteger selectedTitle;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _arrayTitle =@[@"钢铁侠",@"雷神",@"美国队长",@"绿巨人"];
    _selectedTitle = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonClick:(id)sender {
    __weak ViewController *weakself =self;
    RLPickerTableView *pickerTableView =[RLPickerTableView pickerViewForArrayList:_arrayTitle defaultSelected:self.selectedTitle callBackResult:^(NSInteger selectedIndex) {
        weakself.selectedTitle =selectedIndex;
    }];
    [pickerTableView show];
    
    
}
- (IBAction)buttonNavigationBar:(id)sender {
    __weak ViewController *weakself =self;
    RLPickerTableView *pickerTableView =[RLPickerTableView pickerViewForArrayList:_arrayTitle defaultSelected:_selectedTitle callBackResult:^(NSInteger selectedIndex) {
        weakself.selectedTitle =selectedIndex;
    }];
    [pickerTableView showInNavigationBar:self.view];
}

- (IBAction)buttonViewClick:(id)sender {
    __weak ViewController *weakself =self;
    RLPickerTableView *pickerTableView =[RLPickerTableView pickerViewForArrayList:_arrayTitle defaultSelected:_selectedTitle callBackResult:^(NSInteger selectedIndex) {
        weakself.selectedTitle =selectedIndex;
    }];
    [pickerTableView showInView:self.view];
}
@end
