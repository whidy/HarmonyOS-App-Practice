import prompt from '@ohos.promptAction';
import { VideoSlider } from './VideoSlider';
import { changeSliderTime } from '../model/VideoControll'
import {
  START_TIME,
  STRING_PERCENT,
  COMMON_NUM_DURATION,
  MESSAGE,
  ALL_PERCENT,
  COMMON_NUM_MINUTE,
  COMMON_NUM_DOUBLE,
  ZERO_STR,
  SPLIT
} from '../common/constants/CommonConstants';

@Component
export struct VideoPlayer {
  private source: string | Resource = '';
  private previewUris: Resource = $r('app.media.SampleVideo');
  private controller: VideoController = new VideoController();
  @Provide durationTime: number = 0
  @Provide durationStringTime: string = '00:00'
  @Provide currentTime: number = 0
  @Provide currentStringTime: string = '00:00'
  @Consume flag: boolean;
  @Consume isPlay: boolean;
  @Consume isOpacity: boolean;

  build() {
    Row() {
      Video({ src: this.source, previewUri: this.previewUris, controller: this.controller })
        .onPrepared((e) => {
          this.prepared.call(this, e)
        })
        .onUpdate(e => {
          this.currentTime = e.time
          this.currentStringTime = changeSliderTime(this.currentTime)
        })
        .onFinish(() => {
          this.finish.call(this)
        })
        .onError(() => {
          prompt.showToast({ duration: 5000, message: MESSAGE })
        })
        .width('100%')
        .height('100%')
        .objectFit(ImageFit.Contain)
        .controls(false)
      VideoSlider({ controller: this.controller })
    }
  }

  /**
   * video component prepared callback
   */
  prepared(duration: number) {
    this.durationTime = duration;
    let second: number = duration % COMMON_NUM_MINUTE;
    let min: number = Number.parseInt((duration / COMMON_NUM_MINUTE).toString());
    let head = min < COMMON_NUM_DOUBLE ? `${ZERO_STR}${min}` : min;
    let end = second < COMMON_NUM_DOUBLE ? `${ZERO_STR}${second}` : second;
    this.durationStringTime = `${head}${SPLIT}${end}`;
    this.flag = true;
  }

  /**
   * video component finish callback
   */
  finish() {
    this.isPlay = false;
    this.isOpacity = false;
  }
}