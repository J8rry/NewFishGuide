//
//  JKSeeBigViewController.m
//  BuDeJie
//
//  Created by Jerry on 16/4/15.
//  Copyright © 2016年 Jerry. All rights reserved.
//

#import "JKSeeBigViewController.h"
#import "JKTopicsItem.h"
#import <UIImageView+WebCache.h>
#import <Photos/Photos.h>
#import <SVProgressHUD.h>

@interface JKSeeBigViewController () <UIScrollViewDelegate>

@property (nonatomic, weak) UIImageView *imageView;

@property (nonatomic, weak) UIView *adView;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;

- (PHAsset *)createAssets;
- (PHAssetCollection *)creatAssetCollection;

@end

NSString * const AssetCollectionIndentifier = @"百思不得姐";
@implementation JKSeeBigViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   // 创建ScrollView
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = [UIScreen mainScreen].bounds;
    [scrollView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back)]];
    [self.view insertSubview:scrollView atIndex:0];
    
    // 添加广告View
    UIView *adView = [[UIView alloc] init];
    UILabel *label = [[UILabel alloc] init];
    label.text = @"这不是广告";
    label.frame = CGRectMake(20, 20, 200, 100);
    label.textColor = [UIColor whiteColor];
    adView.backgroundColor = [UIColor orangeColor];
    adView.jk_x = 0;
    adView.jk_width = scrollView.jk_width;
    adView.jk_height = 150;
    
    UITapGestureRecognizer *adTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ad)];
    [adView addGestureRecognizer:adTap];
    [adView addSubview:label];
    [scrollView addSubview:adView];
    
    // 设置点击放大的图片
    UIImageView *imageView = [[UIImageView alloc] init];
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.topics.image1] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (error) return;
        if (image) {
            self.saveButton.enabled = YES;
        }
    }];
    imageView.jk_width = scrollView.jk_width;
    imageView.jk_height = imageView.jk_width * self.topics.height / self.topics.width;
    imageView.jk_x = 0;
    
    [scrollView addSubview:imageView];
    self.imageView = imageView;
    

    // 判断图片的高度
    if (imageView.jk_height >= JKUIScreenH) { // 高度大于scrollView
        imageView.jk_y = 0;
        adView.jk_y = imageView.jk_height + 30;
        scrollView.contentSize = CGSizeMake(0, imageView.jk_height + adView.jk_height + 40);
    } else { // 高度小于scrollView
        imageView.jk_centerY = scrollView.jk_height * 0.5;
        adView.jk_y = scrollView.jk_height - 10;
        scrollView.contentSize = CGSizeMake(0, scrollView.jk_height + adView.jk_height + 20);
    }
    
    // 给图片添加缩放功能
    CGFloat maxScale =  self.topics.width / imageView.jk_width;
    if (maxScale > 1.0) {
        scrollView.maximumZoomScale = maxScale;
        scrollView.delegate = self;
    }

}


#pragma mark - 事件
- (void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)ad
{

}

- (IBAction)backButton:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)savePicture {
    
    
    PHAuthorizationStatus oldStatus = [PHPhotoLibrary authorizationStatus];
    
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        dispatch_async(dispatch_get_main_queue(), ^{
            switch ([PHPhotoLibrary authorizationStatus]) {
                case PHAuthorizationStatusRestricted:
                [SVProgressHUD showErrorWithStatus:@"由于系统原因,无法访问相册"];
                    break;
                    
                case PHAuthorizationStatusDenied:
                    
                    if (oldStatus == PHAuthorizationStatusDenied)
                    JKLog(@"允许访问已被禁用, 请打开[设置-隐私-照片]")
                    [self setUpAleart];
            
                    break;
                    
                case PHAuthorizationStatusAuthorized:
                    [self saveImageToAlbum];
                    break;
                    
                default:
                    break;
            }
        });
    }];
}

- (void)setUpAleart
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请点击设置,将相片访问设置为允许" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if ([[UIApplication sharedApplication]canOpenURL:url]) {
            [[UIApplication sharedApplication]openURL:url];
        }
    }];
    
    [alert addAction:action];
    
    [self presentViewController:alert animated:YES completion:nil];
}

/**
 *  保存图片到相册
 */
- (PHFetchResult<PHAsset *> *)createAssets
{
    __block NSString *assetIndentifier = nil;
    // 1. 保存图片到相册
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        assetIndentifier = [PHAssetChangeRequest creationRequestForAssetFromImage:self.imageView.image].placeholderForCreatedAsset.localIdentifier;
    } error:nil];

    if (assetIndentifier == nil) return nil;

    return [PHAsset fetchAssetsWithLocalIdentifiers:@[assetIndentifier] options:nil];
}

/**
 *  创建自定义相册
 */
- (PHAssetCollection *)creatAssetCollection
{
    __block NSString *title = [NSBundle mainBundle].infoDictionary[(NSString *)kCFBundleNameKey];
    
    PHFetchResult<PHAssetCollection *> *assetCollections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    
    
    for (PHAssetCollection *collection in assetCollections) {
        if ([collection.localizedTitle isEqualToString:AssetCollectionIndentifier]){
            return collection;
        }
    }

    __block NSString *assetCollectionIdentifier = nil;
    
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        assetCollectionIdentifier = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:title].placeholderForCreatedAssetCollection.localIdentifier;
        } error:nil];
    
    if (assetCollectionIdentifier == nil) return nil;
    
    return [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[assetCollectionIdentifier] options:nil].firstObject;
}



- (void)saveImageToAlbum
{
    // 3. 将图片保存到自定的相簿里
    PHFetchResult<PHAsset *> *creatAssets = self.createAssets;
    
    PHAssetCollection *assetsCollection = self.creatAssetCollection;
    
    if (creatAssets == nil || assetsCollection == nil) {
        [SVProgressHUD showErrorWithStatus:@"保存失败"];
        return;
    }
    
    NSError *error = nil;
    [[PHPhotoLibrary sharedPhotoLibrary]performChangesAndWait:^{
        PHAssetCollectionChangeRequest *request = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:assetsCollection];
        [request insertAssets:creatAssets atIndexes:[NSIndexSet indexSetWithIndex:0]];
    } error:&error];
    
    if (error == nil) {
        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
    } else {
        [SVProgressHUD showSuccessWithStatus:@"保存失败"];
    }
}

#pragma mark - UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

@end
