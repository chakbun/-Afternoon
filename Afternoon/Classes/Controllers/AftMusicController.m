//
//  AftMusicController.m
//  Afternoon
//
//  Created by Jaben on 15/10/25.
//  Copyright © 2015年 After. All rights reserved.
//

#import "AftMusicController.h"
#import <BmobSDK/Bmob.h>
#import <BmobSDK/BmobProFile.h>
#import <AVFoundation/AVFoundation.h>
#import "AFHTTPRequestOperationManager.h"
#import "UIImageView+WebCache.h"
#import "VMProgressHUD.h"
#import "JRProgressHubManager.h"

@interface AftMusicController ()
@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UILabel *musicNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *singerLabel;
@property (nonatomic, strong) AVAudioPlayer *audioPlayer;
@end

@implementation AftMusicController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDate *today = [NSDate date];
    NSDateFormatter *yyyyMMddFormatter = [[NSDateFormatter alloc] init];
    yyyyMMddFormatter.dateFormat = @"yyyy-MM-dd";
    
    NSString *todayMusciFileName = [NSString stringWithFormat:@"musicFile_%@",[yyyyMMddFormatter stringFromDate:today]];
    
    NSString *docDirPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filePath = [NSString stringWithFormat:@"%@/%@.mp3", docDirPath , todayMusciFileName];
    
    BOOL fileExist = [[NSFileManager defaultManager] fileExistsAtPath:filePath];
    
    if (fileExist) {
        NSURL *fileURL = [NSURL fileURLWithPath:filePath];
        NSError *musicError = nil;
        self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:&musicError];
        if (!musicError) {
            NSLog(@"============ 准备播放 ============");
            [self.audioPlayer prepareToPlay];
//            [self.audioPlayer play];
        }
    }else {
        
//        __weak __typeof(self) weakSelf = self;
//        
//        BmobQuery *bquery = [BmobQuery queryWithClassName:@"table_music"];
//        [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
//            
//            BmobObject *obj = array[array.count - 1];
//            BmobFile *musicFile = [obj objectForKey:@"originMusic"];
//            BmobFile *coverFile = [obj objectForKey:@"coverUrl"];
//            
//            NSString *singerName = [obj objectForKey:@"singer"];
//            NSString *title = [obj objectForKey:@"title"];
//
//
//            [weakSelf.coverImageView sd_setImageWithURL:[NSURL URLWithString:coverFile.url] placeholderImage:nil completed:NULL];
//            weakSelf.singerLabel.text = singerName;
//            weakSelf.musicNameLabel.text = [obj objectForKey:@"title"];
//            
//            [[JRProgressHubManager shareManager] showProgressWithText:@"正在加载歌曲，请稍后..."];
//            
//            dispatch_group_t loadMusicGroup = dispatch_group_create();
//            
//            dispatch_group_async(loadMusicGroup, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//                NSURL *url = [[NSURL alloc] initWithString:musicFile.url];
//                NSData *audioData = [NSData dataWithContentsOfURL:url];
//                
//                //将数据保存到本地指定位置
//                BOOL writeResult = [audioData writeToFile:filePath atomically:YES];
//                NSLog(@"============ 文件写入结果:%d ============",writeResult);
//            });
//            
//            dispatch_group_notify(loadMusicGroup, dispatch_get_main_queue(), ^{
//                
//                [[JRProgressHubManager shareManager] hiddenProgressView];
//                
//                NSLog(@"============ 音乐下载完成啦！ ============");
//                NSError *musicError = nil;
//                //播放本地音乐
//                NSURL *fileURL = [NSURL fileURLWithPath:filePath];
//                weakSelf.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:&musicError];
//                if (!musicError) {
//                    NSLog(@"============ 准备播放 ============,");
//                    [weakSelf.audioPlayer prepareToPlay];
////                    [weakSelf.audioPlayer play];
//                }
//            });
//        }];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
