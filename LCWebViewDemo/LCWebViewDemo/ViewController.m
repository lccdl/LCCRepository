//
//  ViewController.m
//  LCWebViewDemo
//
//  Created by lcc on 16/8/22.
//  Copyright © 2016年 early bird international. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,retain) UIWebView *webView;

@property (nonatomic,retain) UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self creatView];
}

- (void)creatView{

    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 300)];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]]];
    
    //使用kvo为webView添加监听，监听webView的内容高度
    [self.webView.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 80;
    
    //设置webView为tableView的header
    self.tableView.tableHeaderView = self.webView;
    
    [self.view addSubview:self.tableView];
    
    
    

}

//实时改变webView的控件高度，使其高度跟内容高度一致
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{

    if ([keyPath isEqualToString:@"contentSize"]) {
        CGRect frame = self.webView.frame;
        frame.size.height = self.webView.scrollView.contentSize.height;
        self.webView.frame = frame;
        
        self.tableView.tableHeaderView = self.webView;
    }
}

- (void)dealloc{

    //销毁的时候别忘移除监听
    [self.webView.scrollView removeObserver:self forKeyPath:@"contentSize"];
}

#pragma -mark- tableView的代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellID = @"reuseCell";
    
    UITableViewCell *tableViewCell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (tableViewCell == nil) {
        tableViewCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    
    tableViewCell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    
    return tableViewCell;

    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
