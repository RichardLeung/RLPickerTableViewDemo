//
//  RLPickerTableView.h
//  CococProject
//
//  Created by 梁原 on 14-9-17.
//  Copyright (c) 2014年 tempus. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RLPickerTableView;

typedef void (^RLPickerTableViewRowSelectionBlock)(NSInteger selectedIndex);

@interface RLPickerTableView : UIView<UITableViewDelegate,UITableViewDataSource>

+ (RLPickerTableView *)pickerViewForArrayList:(NSArray *)array
                              defaultSelected:(NSInteger)index
                               callBackResult:(RLPickerTableViewRowSelectionBlock )block;

-(void)show;

-(void)showInView:(UIView *)superView;

-(void)showInNavigationBar:(UIView *)superView;

-(void)dismiss;

@end
