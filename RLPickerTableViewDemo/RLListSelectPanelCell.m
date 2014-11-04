//
//  RLListSelectPanelCell.m
//  CococProject
//
//  Created by tempus-MAC on 14-9-17.
//  Copyright (c) 2014年 tempus. All rights reserved.
//

#import "RLListSelectPanelCell.h"

@implementation RLListSelectPanelCell

- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor =[UIColor clearColor];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
    if (selected ==YES) {
        self.imageViewMark.image =[UIImage imageNamed:@"btn_choose3_selected"];
        self.labelTilte.textColor =[UIColor colorWithRed:(20)/255.0f green:(102)/255.0f blue:(239)/255.0f alpha:1];
    }else{
        self.imageViewMark.image =[UIImage imageNamed:@"btn_choose3_normal"];
        self.labelTilte.textColor =[UIColor grayColor];
    }
}

@end
