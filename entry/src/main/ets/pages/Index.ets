import router from '@ohos.router'
import { VideoPlayer } from '../components/VideoPlayer';
import {
  MARGIN_FONT_SIZE,
  COMMON_NUM_FONT_WEIGHT,
  ALL_PERCENT,
  STACK_STYLE
} from '../common/constants/CommonConstants';

@Entry
@Component
struct Index {
  private controller: TabsController = new TabsController()
  private source: string = '';
  @State message: string = 'Hello World'
  @State loading: boolean = true

  private startIconResource: Resource = $r('app.media.play');
  @Provide isPlay: boolean = false;
  videoController: VideoController = new VideoController();
  @Provide isOpacity: boolean = false;
  @Provide isLoading: boolean = false;
  @Provide progressVal: number = 0;
  @Provide flag: boolean = false;

  build() {
    Column() {
      Row() {
        Tabs({ barPosition: BarPosition.Start, controller: this.controller }) {
          TabContent() {
            Column() {
              // todo how to change loading state? 2024年02月01日
              if (this.loading) {
                LoadingProgress()
                  .color(Color.Blue)
                  .height(60)
                  .width(60)
              }

              Button() {
                Row() {
                  Image($r('app.media.icon')).width(20).height(20).margin({right: 10})
                  Text("todo").fontSize(28)
                }
              }.type(ButtonType.Capsule).width(360).height(40).onClick(() => {
                router.pushUrl({ url: "pages/Todo" })
              })
            }
            .width('100%')
            .height('100%')
            .backgroundColor(Color.Green)
          }
          .tabBar('green')

          TabContent() {
            Column() {
              Text(this.message)
                .fontSize(50)
                .fontWeight(FontWeight.Bold)
              Button($r('app.string.login_text'), { type: ButtonType.Capsule })
                .width($r('app.float.button_width'))
                .height($r('app.float.button_height'))
                .fontSize($r('app.float.login_fontSize'))
                .backgroundColor($r('app.color.button_color'))
            }.width('100%')
            .height('100%')
            .backgroundColor(Color.Blue)
          }
          .tabBar('blue')
        }
        .barMode(BarMode.Scrollable)
        .barWidth('100%')
        .barHeight(60)
        .width('100%')
        .height('100%')
      }
      .height('50%')
      .width('100%')
      Row() {
        Stack() {
          if (!this.isPlay && !this.isLoading) {
            Image(this.startIconResource)
              .width(MARGIN_FONT_SIZE.FIFTH_MARGIN)
              .height(MARGIN_FONT_SIZE.FIFTH_MARGIN)
              .zIndex(STACK_STYLE.IMAGE_Z_INDEX)
          }
          if (this.isLoading) {
            Progress({
              value: STACK_STYLE.PROGRESS_VALUE,
              total: STACK_STYLE.PROGRESS_TOTAL,
              type: ProgressType.ScaleRing
            })
              .color(Color.Grey)
              .value(this.progressVal)
              .width(STACK_STYLE.PROGRESS_WIDTH)
              .style({
                strokeWidth: STACK_STYLE.PROGRESS_STROKE_WIDTH,
                scaleCount: STACK_STYLE.PROGRESS_SCALE_COUNT,
                scaleWidth: STACK_STYLE.PROGRESS_SCALE_WIDTH
              })
              .zIndex(STACK_STYLE.PROGRESS_Z_INDEX)
          }
          VideoPlayer({
            source: this.source,
            controller: this.videoController
          })
            .zIndex(0)
        }

      }
      .width('100%')
      .height('50%')
    }
    .height('100%')
  }
}