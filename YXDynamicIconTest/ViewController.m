//
//  ViewController.m
//  YXDynamicIconTest
//
//  Created by ios on 2020/4/15.
//  Copyright © 2020 August. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) NSMutableArray *dataSourceArr;
@property (nonatomic, strong) UIButton *btn;
@property (nonatomic, assign) NSInteger selectedIndex;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    _dataSourceArr = [[NSMutableArray alloc] init];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    dic = [[NSMutableDictionary alloc] initWithDictionary:@{@"title":@"求发", @"iconName":@"qiufa"}];
    [_dataSourceArr addObject:dic];
    dic = [[NSMutableDictionary alloc] initWithDictionary:@{@"title":@"如丽", @"iconName":@"ruli"}];
    [_dataSourceArr addObject:dic];
    dic = [[NSMutableDictionary alloc] initWithDictionary:@{@"title":@"壹美", @"iconName":@"yimei"}];
    [_dataSourceArr addObject:dic];
    
    _btn = [UIButton buttonWithType:UIButtonTypeSystem];
    _btn.frame = CGRectMake(100, 100, 100, 100);
    [_btn addTarget:self action:@selector(progressBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btn];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self changeSelected:_selectedIndex];
}

#pragma mark - progressBtn
- (void)progressBtn:(UIButton *)btn {
    
    _selectedIndex ++;
    if (_selectedIndex > 2) {
        _selectedIndex = 0;
    }
    [self changeSelected:_selectedIndex];
}

#pragma mark - 改变选中
- (void)changeSelected:(NSInteger)index {
    
    [_btn setTitle:[_dataSourceArr[index] objectForKey:@"title"] forState:UIControlStateNormal];
    [self changeAppIconWithName:[_dataSourceArr[index] objectForKey:@"iconName"]];
}

#pragma mark - 动态切换icon
- (void)changeAppIconWithName:(NSString *)iconName {
    
    if (![[UIApplication sharedApplication] supportsAlternateIcons]) {
        return;
    }
    
    if ([iconName isEqualToString:@""]) {
        iconName = nil;
    }
    [[UIApplication sharedApplication] setAlternateIconName:iconName completionHandler:^(NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"更换app图标发生错误了 ： %@",error);
        }
    }];
}

@end
