### 使用ffmpeg的视频中的固定长度的开头/结尾部批量裁剪掉
由于时间仓促，脚本先简单书写并可以满足我自己的使用需求，其实可以优化地更完美。
- 注：系统中需先安装ffmpeg

应用场景有如下图，有一批视频文件，其视频开头处都有30秒固定长度的起始画面，结尾处都有20秒的固定长度结束画面，此时可以用这脚本快速（有多快？就相当于复制粘贴的速度）把多余部分裁剪掉。
http://ww1.sinaimg.cn/large/9c4ddab1gy1fnmppp43mdj20k006zgnb.jpg

### 使用方法
保留视频「从开头」至「结束前10秒（即：舍弃原视频末尾10秒的视频长度）」的范围
```
./cut.videos.using.ffmpeg.sh 0 10
```

保留视频「从开头5分30秒」至「视频结束」的范围
```
./cut.videos.using.ffmpeg.sh 00：05：30 0
```

保留视频「从开头1小时00分59秒开始」至「视频结束前的30分钟（30分钟=1800秒）」的范围
```
./cut.videos.using.ffmpeg.sh 01：00：59 1800
```

注：如下可指定具体的「起始」和「结束」时间
```
ffmpeg -hide_banner a.mp4 -c copy -ss 00:10:30 -to 00:30:10 CUT_a.mp4

再批量转码压缩一下收藏起来 :)
parallel -j1 ffmpeg -i {} -hide_banner -c:v libx265 -b:v 100k -vf scale=iw*0.75:ih*0.75 -preset slower -c:a aac -b:a 48k _{.}.mp4 ::: CUT*.mp4
正式转码前可先拿视频的一部分片段（比如截取视频的30秒时长）来测试下输出的效果是否是你理想中的，输出后可直接播放看看即心理有数
ffmpeg -i a.mp4 -c:v libx265 -b:v 100k -vf scale=iw*0.75:ih*0.75 -preset slower -c:a aac -b:a 48k -ss 00:00:00 -to 00:00:30 a.x265.mp4
```
