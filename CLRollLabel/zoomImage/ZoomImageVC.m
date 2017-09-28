//
//  ZoomImageVC.m
//  CLRollLabel
//
//  Created by admin on 2017/9/25.
//  Copyright © 2017年 ClaudeLi. All rights reserved.
//

#import "ZoomImageVC.h"
#define  ImageHight 200.0f
@interface ZoomImageVC ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *tableView;
//底层背景图
@property(nonatomic,strong)UIImageView *zoomImageView;
//图像
@property(nonatomic,strong)  UIImageView *circleView;
//昵称
@property(nonatomic,strong)UILabel *label;
@end

@implementation ZoomImageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"拖动列表时,放大列表顶部的图片";
    //1.初始化_tableView
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    //2.设置代理
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    
    //3.设置contentInset属性（上左下右 的值）
    self.tableView.contentInset = UIEdgeInsetsMake(ImageHight+64, 0, 0, 0);
    //4.添加tableView
    [self.view addSubview:self.tableView];
    
    //5.配置ImageView
    self.zoomImageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"123.jpg"]];
    self.zoomImageView.frame=CGRectMake(0, -ImageHight , self.view.frame.size.width, ImageHight);
    
    //核心就是这句代码!
    //UIViewContentModeScaleAspectFill高度改变,宽度也会改变
    //不设置那将只会被纵向拉伸
    self.zoomImageView.contentMode=UIViewContentModeScaleAspectFill;
    [self.tableView addSubview: self.zoomImageView];
    
    
    
    //    //6.设置autoresizesSubviews让子类自动布局
    //    self.zoomImageView.autoresizesSubviews = YES;
    //
    //    self.circleView = [[UIImageView alloc]initWithFrame:CGRectMake(10, ImageHight-50, 40, 40)];
    //    self.circleView.backgroundColor = [UIColor redColor];
    //    self.circleView.layer.cornerRadius = 7.5f;
    //    self.circleView.image = [UIImage imageNamed:@"123.jpg"];
    //    self.circleView.clipsToBounds = YES;
    //    self.circleView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;//自动布局，自适应顶部
    //    [_zoomImageView addSubview:_circleView];
    //
    //    self.label = [[UILabel alloc]initWithFrame:CGRectMake(60, ImageHight-40, 280, 20)];
    //    self.label.textColor = [UIColor whiteColor];
    //    self.label.text = @"SunnyYoung";
    //    self.label.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;//自动布局，自适应顶部
    //    [_zoomImageView addSubview: self.label];
    //    //解决tableView  在nav 遮挡的时候 还会透明的显示问题;
    //    self.edgesForExtendedLayout=UIRectEdgeNone;
    
}

// 改变frame值
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //根据实际选择 加不加上NavigationBarHigth(44,64 或者没有导航条)
    CGFloat y=scrollView.contentOffset.y;
    if(y< -ImageHight)
    {
        CGRect frame= self.zoomImageView.frame;
        frame.origin.y=y;
        frame.size.height=-y;
        self.zoomImageView.frame=frame;
        
    }
    
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"Jay"];
    if(cell==nil){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Jay"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.separatorInset=UIEdgeInsetsZero;
        cell.clipsToBounds = YES;
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"第-%ld-天 ",indexPath.row];
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
