//
//  ViewController.m
//  ListTableView
//
//  Created by 懂懂科技 on 2017/3/20.
//  Copyright © 2017年 DDKJ. All rights reserved.
//

#import "ViewController.h"
#import "InfoTableViewCell.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>{
    CGFloat _originX;
    CGFloat _originY;
}
@property (nonatomic, strong) UITableView *titleTableView;
@property (nonatomic, strong) UITableView *contentTableView;
@property (nonatomic, strong) UIScrollView *contentView;
@end

@implementation ViewController
//MARK:- 快速创建label
- (UILabel *)quickCreateLabelWithLeft:(CGFloat)left width:(CGFloat)width title:(NSString *)title {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(left, 10, width, 40)];
    label.text = title;
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _originX = 100;
    _originY = 50;
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;

    UILabel *titleLabel = [self quickCreateLabelWithLeft:0 width:_originX title:@"线路名称"];
    [self.view addSubview:titleLabel];
    
    _contentView = [[UIScrollView alloc] initWithFrame:CGRectMake(_originX, 0, width - _originX, height)];
    _contentView.contentSize = CGSizeMake(500, height);
    _contentView.backgroundColor = [UIColor orangeColor];
    _contentView.bounces = NO;
    _contentView.delegate = self;
    [self.view addSubview:_contentView];
    
    self.titleTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, _originY, 100, height) style:UITableViewStylePlain];
    self.titleTableView.dataSource = self;
    self.titleTableView.delegate = self;
    self.titleTableView.tableFooterView = [UIView new];
    [self.view addSubview:self.titleTableView];
    
    
    self.contentTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, _originY, 500, height - _originY) style:UITableViewStylePlain];
    self.contentTableView.dataSource = self;
    self.contentTableView.delegate = self;
    self.contentTableView.tableFooterView = [UIView new];
    [_contentView addSubview:self.contentTableView];
    
    for (int i = 0; i < 5; i ++) {
        CGFloat x = i * 100;
        UILabel *label = [self quickCreateLabelWithLeft:x width:100 title:[NSString stringWithFormat:@"title%d",i]];
        label.textAlignment = NSTextAlignmentCenter;
        [_contentView addSubview:label];
    }

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.titleTableView) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        cell.textLabel.text = @"title";
        return cell;
    } else {
        InfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"InfoTableViewCell"];
        if (!cell) {
            cell = [[NSBundle mainBundle] loadNibNamed:@"InfoTableViewCell" owner:nil options:nil].firstObject;
        }
        return cell;
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == _titleTableView) {
        [_contentTableView setContentOffset:CGPointMake(_contentTableView.contentOffset.x, _titleTableView.contentOffset.y)];
    } else if (scrollView == _contentTableView) {
        [_titleTableView setContentOffset:CGPointMake(0, _contentTableView.contentOffset.y)];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
