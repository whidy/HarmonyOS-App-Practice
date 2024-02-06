import router from '@ohos.router'
import { VideoPlayer } from '../components/VideoPlayer';

@Entry
@Component
struct Index {
  private controller: TabsController = new TabsController()
  @State message: string = 'Hello World'
  @State loading: boolean = true

  build() {
    Row() {
      Column() {
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
      .width('100%')
      VideoPlayer()
    }
    .height('100%')
  }
}