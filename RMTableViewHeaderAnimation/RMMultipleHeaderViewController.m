//
//  RMMultipleHeaderViewController.m
//  RMTableViewHeaderAnimation
//
//  Created by Watson on 2016/12/27.
//  Copyright © 2016年 renming. All rights reserved.
//

#import "RMMultipleHeaderViewController.h"

#define kScreenW [UIScreen mainScreen].bounds.size.width

#define kScreenH [UIScreen mainScreen].bounds.size.height

@interface RMMultipleHeaderViewController ()<UITableViewDelegate, UITableViewDataSource>

/**头部背景图片**/
@property (nonatomic) UIImageView* topIV;

@property (nonatomic) NSInteger headerHeight;

@property (nonatomic) NSString* imageName;

@end

@implementation RMMultipleHeaderViewController

-(instancetype)initWithTopViewName:(NSString *)imageName andtableHeaderHeight:(NSInteger)headerHeight
{
    if (self = [super init])
    {
        self.imageName = imageName;
        self.headerHeight = headerHeight;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configInitData];
}

-(void)configInitData
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    _topIV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenW)];
    _topIV.image = [UIImage imageNamed:_imageName];
    [self.view addSubview:_topIV];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH) style:(UITableViewStylePlain)];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor clearColor];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, _headerHeight)];
    headerView.backgroundColor = [UIColor clearColor];
    _tableView.tableHeaderView = headerView;
    [self.view addSubview:_tableView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 关键方法

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    CGFloat delta = _topIV.frame.size.height - _tableView.tableHeaderView.frame.size.height;
    
    if (offsetY < 0)
    {
        CGFloat fabY = fabs(offsetY);
        if (fabY > delta)
        {
            CGRect rect = _topIV.frame;
            rect.origin.y = fabY - delta;
            _topIV.frame = rect;
        }
        else
        {
            _topIV.frame = CGRectMake(0, 0, kScreenW, kScreenW);
        }
    }
    else
    {
        CGRect rect = _topIV.frame;
        rect.origin.y = -offsetY;
        _topIV.frame = rect;
        //控制头部导航栏出现
        if (offsetY > _tableView.tableHeaderView.frame.size.height - 64)
        {
            [self.navigationController setNavigationBarHidden:NO animated:YES];
        }
        else
        {
             [self.navigationController setNavigationBarHidden:YES animated:YES];
        }
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    self.tabBarController.tabBar.hidden = YES;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.tabBarController.tabBar.hidden = NO;
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
