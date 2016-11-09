//
//  ViewController.m
//  GPUimageDemo
//
//  Created by 任永乐 on 16/11/9.
//  Copyright © 2016年 ryl. All rights reserved.
//

#import "ViewController.h"
#import "GPUImage.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UISlider *slider1;
@property (weak, nonatomic) IBOutlet UISlider *slider2;
@property (weak, nonatomic) IBOutlet UISlider *slider3;

@property(nonatomic,strong)UIImage *img;

@end

@implementation ViewController{
    UIImageView *_imgV;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _imgV = [[UIImageView alloc]init];
    [self.view addSubview:_imgV];
    
    
    _img = [UIImage imageNamed:@"biaoqingdi"];
   
    _imgV.frame = CGRectMake(0, 0, _img.size.width, _img.size.height);
    _imgV.image = _img;
    
    
}
- (IBAction)sliderChange:(UISlider *)sender {
    UISlider *slider = (UISlider *)[self.view viewWithTag:sender.tag];
    switch (slider.tag) {
        case 101:
        {
            // 亮度
            GPUImageBrightnessFilter *filter = [[GPUImageBrightnessFilter alloc] init];
            filter.brightness = slider.value;
            [filter forceProcessingAtSize:_img.size];
            [filter useNextFrameForImageCapture];
            [self filterWithObject:filter];
        }
            break;
        case 102:
        {
            //曝光度
            GPUImageExposureFilter *exposure = [[GPUImageExposureFilter alloc] init];//创建滤镜对象
            exposure.exposure = slider.value;//设置亮度 -10 to 10 默认 0
            [exposure forceProcessingAtSize:_img.size];//设置要渲染的区域
            [exposure useNextFrameForImageCapture];//捕获图片效果
            [self filterWithObject:exposure];
        }
            break;
        case 103:
        {
            //            高斯模糊
            GPUImageGaussianBlurFilter *gaussianBlur = [[GPUImageGaussianBlurFilter alloc] init];//创建滤镜对象
            gaussianBlur.texelSpacingMultiplier = slider.value;
            [gaussianBlur forceProcessingAtSize:_img.size];//设置要渲染的区域
            [gaussianBlur useNextFrameForImageCapture];//捕获图片效果
            [self filterWithObject:gaussianBlur];
        }
            break;
            
        default:
            break;
    }
    
    
    
    
    
    
    
    
    
    

    
    
    
    
    
}

- (void)filterWithObject:(GPUImageFilter *)filter{
    GPUImagePicture *stillImageSource = [[GPUImagePicture alloc]initWithImage:_img];
    [stillImageSource addTarget:filter];
    
    
    
    [stillImageSource processImage];
    
    UIImage *newImage = [filter imageFromCurrentFramebuffer];
    
    
    _imgV.image = newImage;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
