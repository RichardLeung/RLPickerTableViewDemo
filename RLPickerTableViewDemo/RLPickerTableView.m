//
//  RLPickerTableView.m
//  CococProject
//
//  Created by 梁原 on 14-9-17.
//  Copyright (c) 2014年 tempus. All rights reserved.
//

#import "RLPickerTableView.h"
#import "RLListSelectPanelCell.h"

@interface RLPickerTableView()


//Data
@property(nonatomic,strong)NSArray *array;
@property(nonatomic)NSInteger index;
@property(nonatomic)BOOL isShow;
@property(nonatomic)BOOL isBottom;

//View
@property(nonatomic,strong)UITableView *tableViewContent;
@property(nonatomic,strong)UIButton *buttonCancel;
@property(nonatomic,strong)UILabel *labelTitle;
@property(nonatomic,strong)UIView *backgroundView;
@property(nonatomic,strong)UIView *blurView;

@property(nonatomic,strong)RLPickerTableViewRowSelectionBlock selectedBlock;

@end

@implementation RLPickerTableView

typedef void (^RLPickerTableViewRowSelectionBlock)(NSInteger selectedIndex);

+ (RLPickerTableView *)pickerViewForArrayList:(NSArray *)array
                          defaultSelected:(NSInteger)index
                           callBackResult:(RLPickerTableViewRowSelectionBlock )block{
    
    RLPickerTableView *pickerTableView = [[self alloc]initWithArrayList:array defaultSelected:index callback:block];
    return pickerTableView;
}

- (instancetype)initWithArrayList:(NSArray *)array
              defaultSelected:(NSInteger)index
                     callback:(RLPickerTableViewRowSelectionBlock)block
{
    self = [super init];
    if (self) {
        self.array =array;
        self.index =index;
        self.isShow =NO;
        self.backgroundColor =[UIColor colorWithRed:(235)/255.0f green:(235)/255.0f blue:(235)/255.0f alpha:1];
        
        if (self.blurView ==nil) {
            self.blurView =[[UIView alloc]init];
            self.blurView.backgroundColor =[UIColor colorWithRed:(10)/255.0f green:(10)/255.0f blue:(10)/255.0f alpha:0.6];
            UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss)];
            [self.blurView addGestureRecognizer:tap];
        }
        
        if (self.tableViewContent ==nil) {
            self.tableViewContent =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, self.frame.size.height) style:UITableViewStyleGrouped];
            self.tableViewContent.delegate =self;
            self.tableViewContent.dataSource =self;
            self.tableViewContent.scrollEnabled =NO;
            //[self.tableViewContent registerClass:[RLListSelectPanelCell class] forCellReuseIdentifier:@"SelectListCell"];
            [self addSubview:self.tableViewContent];
            [self.tableViewContent setSeparatorInset:UIEdgeInsetsZero];
            [self.tableViewContent selectRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
        }
        if (block) {
            self.selectedBlock =block;
        }
    }
    return self;
}

-(void)layoutSubviews{
    [self.tableViewContent setFrame:CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, self.frame.size.height)];
}

-(void)showInNavigationBar:(UIView *)superView{
    _isBottom =NO;
    [self.blurView setFrame:superView.bounds];
    [superView addSubview:self.blurView];
    self.blurView.alpha =0;
    double height =44*self.array.count;
    self.frame =CGRectMake(0,-height , [[UIScreen mainScreen]bounds].size.width,height );
    self.alpha =0;
    [superView addSubview:self];
    [UIView animateWithDuration:0.3 animations:^{
        self.blurView.alpha =1;
        self.alpha =1;
        [self setFrame:CGRectMake(0, 64, self.frame.size.width, self.frame.size.height)];
    }];
}


-(void)show{
    _isBottom =YES;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [self.blurView setFrame:window.bounds];
    [window addSubview:self.blurView];
    self.blurView.alpha =0;
    //self.blurView.alpha =0.8;
    self.frame =CGRectMake(0, [[UIScreen mainScreen]bounds].size.height, [[UIScreen mainScreen]bounds].size.width,44*self.array.count);
    self.alpha = 0;
    [window addSubview:self];
    [UIView animateWithDuration:0.3 animations:^{
        self.blurView.alpha = 1;
        self.alpha =1;
        [self setFrame:CGRectMake(0, [[UIScreen mainScreen]bounds].size.height-self.frame.size.height, self.frame.size.width, self.frame.size.height)];
    }];
}

-(void)showInView:(UIView *)superView{
    _isBottom =YES;
    [self.blurView setFrame:superView.bounds];
    [superView addSubview:self.blurView];
    self.blurView.alpha =0;
    self.frame =CGRectMake(0, [[UIScreen mainScreen]bounds].size.height, [[UIScreen mainScreen]bounds].size.width, 44*self.array.count);
    self.alpha =0;
    [superView addSubview:self];
    [UIView animateWithDuration:0.3 animations:^{
        self.blurView.alpha =1;
        self.alpha =1;
        [self setFrame:CGRectMake(0, [[UIScreen mainScreen]bounds].size.height-self.frame.size.height, self.frame.size.width, self.frame.size.height)];
    }];
}

-(void)dismiss{
    if (_isBottom ==YES) {
        __weak RLPickerTableView *weakself =self;
        [UIView animateWithDuration:0.4 animations:^{
            [weakself setFrame:CGRectMake(0, [[UIScreen mainScreen]bounds].size.height, [[UIScreen mainScreen]bounds].size.width, [[UIScreen mainScreen]bounds].size.width)];
            weakself.alpha = 0;
            weakself.blurView.alpha =0;
        }completion:^(BOOL finished) {
            [weakself.blurView removeFromSuperview];
            weakself.blurView =nil;
            [weakself removeFromSuperview];
        }];
    }else{
        __weak RLPickerTableView *weakself =self;
        [UIView animateWithDuration:0.4 animations:^{
            [weakself setFrame:CGRectMake(0, -self.frame.size.height, self.frame.size.width, self.frame.size.height)];
            weakself.alpha = 0;
            weakself.blurView.alpha =0;
        }completion:^(BOOL finished) {
            [weakself.blurView removeFromSuperview];
            weakself.blurView =nil;
            [weakself removeFromSuperview];
        }];
    }
}


#pragma mark -UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.array.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID =@"cellID";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell ==nil) {
        cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    if (indexPath.row ==self.index) {
        cell.textLabel.textColor =[UIColor orangeColor];
    }else{
        cell.textLabel.textColor =[UIColor blackColor];
    }
    cell.textLabel.text =[self.array objectAtIndex:indexPath.row];
    cell.textLabel.textAlignment =NSTextAlignmentCenter;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font =[UIFont systemFontOfSize:17];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cellLast =[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.index inSection:0]];
    cellLast.textLabel.textColor =[UIColor blackColor];
    UITableViewCell *cell =[tableView cellForRowAtIndexPath:indexPath];
    cell.textLabel.textColor =[UIColor orangeColor];
    if (self.selectedBlock != nil){
        self.selectedBlock(indexPath.row);
    }
    [self dismiss];
}

@end
