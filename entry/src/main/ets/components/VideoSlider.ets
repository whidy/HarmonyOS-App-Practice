import {
  STACK_STYLE
} from '../common/constants/CommonConstants';

@Component
export struct VideoSlider {
  private controller: VideoController;
  @Consume isPlay: boolean;
  @Consume isOpacity: boolean;
  @Consume durationStringTime: string;
  @Consume currentStringTime: string;
  @Consume durationTime: number;
  @Consume currentTime: number;
  @Consume flag: boolean;
  @Consume isLoading: boolean;
  @Consume progressVal: number;
  build() {
    Row({space: 12}) {
      Image(this.isPlay ? $r('app.media.pause') : $r('app.media.play')).onClick(() => {
        // todo
        this.iconOnclick.call(this)
      })
      Text(this.currentStringTime)
      Slider({
        value: this.currentTime,
        min: 0,
        max: this.durationTime,
        step: 1
      }).onChange((value: number, mode: SliderChangeMode) => {
        this.sliderOnchange.call(this, value, mode)
      })
      Text(this.durationStringTime)
    }.backgroundColor('#fff')
  }

  /**
   * icon onclick callback
   */
  iconOnclick() {
    if (this.isPlay === true) {
      this.controller.pause()
      this.isPlay = false;
      this.isOpacity = false;
      return;
    }
    if (this.flag === true) {
      this.controller.start();
      this.isPlay = true;
      this.isOpacity = true;
    } else {
      this.isLoading = true;
      // The video loading is not complete. The loading action is displayed.
      let intervalLoading = setInterval(() => {
        if (this.progressVal >= STACK_STYLE.PROGRESS_TOTAL) {
          this.progressVal = 0;
        } else {
          this.progressVal += STACK_STYLE.PROGRESS_STEP;
        }
      }, STACK_STYLE.MILLI_SECONDS)
      // The scheduled task determines whether the video loading is complete.
      let intervalFlag = setInterval(() => {
        if (this.flag === true) {
          this.controller.start();
          this.isPlay = true;
          this.isOpacity = true;
          this.isLoading = false;
          clearInterval(intervalFlag);
          clearInterval(intervalLoading);
        }
      }, STACK_STYLE.MILLI_SECONDS);
    }
  }

  /**
   * video slider component onchange callback
   */
  sliderOnchange(value: number, mode: SliderChangeMode) {
    this.currentTime = Number.parseInt(value.toString());
    this.controller.setCurrentTime(Number.parseInt(value.toString()), SeekMode.Accurate);
    if (mode === SliderChangeMode.Begin || mode === SliderChangeMode.Moving) {
      this.isOpacity = false;
    }
    if (mode === SliderChangeMode.End) {
      this.isOpacity = true;
    }
  }
}