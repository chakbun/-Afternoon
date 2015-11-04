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

@interface AftMusicController ()
@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UILabel *musicNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *singerLabel;
@property (nonatomic, strong) AVAudioPlayer *audioPlayer;
@end

@implementation AftMusicController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak __typeof(self) weakSelf = self;
    
    BmobQuery *bquery = [BmobQuery queryWithClassName:@"table_music"];
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
//        for(BmobObject *obj in array) {
//            NSLog(@"============ 日期: %@============",obj.createdAt);
//            NSLog(@"============ 音乐：%@ ============", [obj objectForKey:@"originMusic"]);
//            NSLog(@"============ 歌名:%@ ============",[obj objectForKey:@"title"]);
//            NSLog(@"============ 歌手：%@ ============", [obj objectForKey:@"singer"]);
//            NSLog(@"============ 专辑：%@ ============", [obj objectForKey:@"musicAlbum"]);
//
//        }
        BmobObject *obj = array[array.count - 1];
        BmobFile *musicFile = [obj objectForKey:@"originMusic"];
        BmobFile *coverFile = [obj objectForKey:@"coverUrl"];
        
        [weakSelf.coverImageView sd_setImageWithURL:[NSURL URLWithString:coverFile.url] placeholderImage:nil completed:NULL];
        weakSelf.singerLabel.text = [obj objectForKey:@"singer"];
        weakSelf.musicNameLabel.text = [obj objectForKey:@"title"];
//        NSString *docDirPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
//        NSString *filePath = [NSString stringWithFormat:@"%@/%@.mp3", docDirPath , @"localMusic"];
//        
//        dispatch_group_t loadMusicGroup = dispatch_group_create();
//        
//        dispatch_group_async(loadMusicGroup, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//            NSURL *url = [[NSURL alloc] initWithString:musicFile.url];
//            NSData *audioData = [NSData dataWithContentsOfURL:url];
//            
//            //将数据保存到本地指定位置
//            BOOL writeResult = [audioData writeToFile:filePath atomically:YES];
//            
//            NSLog(@"============ 文件写入结果:%d ============",writeResult);
//        });
        
//        dispatch_group_notify(loadMusicGroup, dispatch_get_main_queue(), ^{
//            NSLog(@"============ 音乐下载完成啦！ ============");
//            NSError *musicError = nil;
//            //播放本地音乐
//            NSURL *fileURL = [NSURL fileURLWithPath:filePath];
//            weakSelf.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:&musicError];
//            if (!musicError) {
//                NSLog(@"============ 准备播放 ============");
//                [weakSelf.audioPlayer prepareToPlay];
//                [weakSelf.audioPlayer play];
//            }
//        });

    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
