//
//  RMAnimationIconViewController.m
//  RMTableViewHeaderAnimation
//
//  Created by Watson on 2016/12/29.
//  Copyright © 2016年 renming. All rights reserved.
//

#import "RMAnimationIconViewController.h"

#define kScreenW [UIScreen mainScreen].bounds.size.width

#define kScreenH [UIScreen mainScreen].bounds.size.height
//头像最后定在导航栏后的大小，不能大于导航栏高度64
#define kIconH_Finish 40.0
//导航栏高度
#define kNaviH 64.0

@interface RMAnimationIconViewController ()<UITableViewDelegate, UITableViewDataSource>

/**头部背景图片**/
@property (nonatomic) UIImageView* topIV;

@property (nonatomic) NSInteger headerHeight;

@property (nonatomic) NSString* imageName;

@property (nonatomic) UIImageView* iconIV;

@property (nonatomic) NSString* iconImageName;

@property (nonatomic) CGFloat iconSize;

@property (nonatomic) CGFloat iconHeight;

@end

@implementation RMAnimationIconViewController

-(instancetype)initWithTopViewName:(NSString *)imageName tableHeaderHeight:(NSInteger)headerHeight iconImageName:(NSString *)iconName iconSize:(CGFloat)iconSize iconHeight:(CGFloat)iconHeight
{
    if (self = [super init])
    {
        self.imageName = imageName;
        self.headerHeight = headerHeight;
        self.iconImageName = iconName;
        self.iconSize = iconSize;
        self.iconHeight = iconHeight;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configInitData];
    [self iconIV];
}

-(UIImageView *)iconIV
{
    if (!_iconIV)
    {
        _iconIV = [[UIImageView alloc] init];
        _iconIV.frame = CGRectMake(kScreenW/2.0 - _iconSize/2.0, _iconHeight, _iconSize, _iconSize);
        _iconIV.image = [UIImage imageNamed:_iconImageName];
        _iconIV.layer.cornerRadius = _iconSize/2.0;
        _iconIV.clipsToBounds = YES;
        [self.navigationController.view addSubview:_iconIV];
    }
    return _iconIV;
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
    
    if (offsetY <= 0)
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
        
        _iconIV.frame = CGRectMake(kScreenW/2.0 - _iconSize/2.0, _iconHeight, _iconSize, _iconSize);
        _iconIV.layer.cornerRadius = _iconSize/2.0;
    }
    else
    {
        CGRect rect = _topIV.frame;
        rect.origin.y = -offsetY;
        _topIV.frame = rect;
        
        //控制头部导航栏出现
        if (offsetY > _tableView.tableHeaderView.frame.size.height - kNaviH)
        {
            [self.navigationController setNavigationBarHidden:NO animated:YES];
            _iconIV.frame = CGRectMake(kScreenW/2.0 - kIconH_Finish/2.0, kNaviH/2.0 - kIconH_Finish/2.0, kIconH_Finish, kIconH_Finish);
            _iconIV.layer.cornerRadius = kIconH_Finish/2.0;
            [self.navigationController.view bringSubviewToFront:_iconIV];
        }
        else
        {
            [self.navigationController setNavigationBarHidden:YES animated:YES];
            
            CGRect iconRect = _iconIV.frame;
            //用于设置icon的y轴变化
            iconRect.origin.y = -((_iconHeight - (kNaviH/2.0 - kIconH_Finish/2.0))/(_headerHeight - kNaviH)) * offsetY + _iconHeight;
            //用于设置icon的大小变化
            iconRect.size.width = -((_iconSize - kIconH_Finish)/(_headerHeight - kNaviH)) * offsetY + _iconSize;
            iconRect.size.height = -((_iconSize - kIconH_Finish)/(_headerHeight - kNaviH)) * offsetY + _iconSize;
            //用于设置icon的中心点一直在正中央移动
            iconRect.origin.x = kScreenW/2.0 - iconRect.size.width/2.0;
            //用于设置icon的切圆角，若初始图片为圆形，相关代码可注释掉
            _iconIV.layer.cornerRadius = iconRect.size.width/2.0;
            
            _iconIV.frame = iconRect;
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
    [_iconIV removeFromSuperview];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.tabBarController.tabBar.hidden = NO;
}


@end
