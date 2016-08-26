//
//  ViewController.m
//  SZDrawView
//
//  Created by Next on 16/8/26.
//  Copyright © 2016年 Next. All rights reserved.
//

#import "ViewController.h"
#import "SZDrawView.h"

@interface ViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic,weak) SZDrawView * drawView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor grayColor];
    
    //drawView
    SZDrawView * drawView = [[SZDrawView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.bounds.size.height - 180)];
    [self.view addSubview:drawView];
    drawView.backgroundColor = [UIColor whiteColor];
    self.drawView = drawView;
    
    //button
    UIButton * buttonSave = [[UIButton alloc] initWithFrame:CGRectMake(20, self.view.bounds.size.height - 150, self.view.bounds.size.width / 2 - 30, 50)];
    [self.view addSubview:buttonSave];
    [buttonSave setTitle:@"SAVE" forState:UIControlStateNormal];
    [buttonSave setBackgroundColor:[UIColor greenColor]];
    [buttonSave addTarget:self action:@selector(buttonSave:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * buttonOpen = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 + 10, self.view.bounds.size.height - 150, self.view.bounds.size.width / 2 - 30, 50)];
    [self.view addSubview:buttonOpen];
    [buttonOpen setTitle:@"Open" forState:UIControlStateNormal];
    [buttonOpen setBackgroundColor:[UIColor greenColor]];
    [buttonOpen addTarget:self action:@selector(buttonOpen:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * buttonClear = [[UIButton alloc] initWithFrame:CGRectMake(20, self.view.bounds.size.height - 75, self.view.bounds.size.width / 2 - 30, 50)];
    [self.view addSubview:buttonClear];
    [buttonClear setTitle:@"Clear" forState:UIControlStateNormal];
    [buttonClear setBackgroundColor:[UIColor greenColor]];
    [buttonClear addTarget:self action:@selector(buttonClear:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * buttonEdit = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 + 10, self.view.bounds.size.height - 75, self.view.bounds.size.width / 2 - 30, 50)];
    [self.view addSubview:buttonEdit];
    [buttonEdit setTitle:@"Edit" forState:UIControlStateNormal];
    [buttonEdit setBackgroundColor:[UIColor greenColor]];
    [buttonEdit addTarget:self action:@selector(buttonEdit:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)buttonSave:(id)sender{
    UIImage * image = [self.drawView saveViewToImage];
    //保存图像到系统相册
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)buttonOpen:(id)sender{
    // 弹出系统的相册
    // 选择控制器（系统相册）
    UIImagePickerController *picekerVc = [[UIImagePickerController alloc] init];
    
    // 设置选择控制器的来源
    // UIImagePickerControllerSourceTypePhotoLibrary 相册集
    // UIImagePickerControllerSourceTypeSavedPhotosAlbum:照片库
    picekerVc.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    
    // 设置代理
    picekerVc.delegate = self;
    
    // modal
    [self presentViewController:picekerVc animated:YES completion:nil];
}

- (void)buttonClear:(id)sender{
    [self.drawView removeFromSuperview];
    //drawView
    SZDrawView * drawView = [[SZDrawView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.bounds.size.height - 180)];
    [self.view addSubview:drawView];
    drawView.backgroundColor = [UIColor whiteColor];
    self.drawView = drawView;
}

- (void)buttonEdit:(id)sender{
    
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    // Was there an error?
    if (error != NULL)
    {
        // Show error message...
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Save Image Error" message:error.domain preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction * action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [alert popoverPresentationController];
        }];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else  // No errors
    {
        // Show message image successfully saved
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Message" message:@"Save Success" preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction * action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [alert popoverPresentationController];
        }];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

#pragma mark - UIImagePickerControllerDelegate
// 当用户选择一张图片的时候调用
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // 获取选中的照片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    // 把选中的照片画到画板上
    
    _drawView.image = image;
    
    // dismiss
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
