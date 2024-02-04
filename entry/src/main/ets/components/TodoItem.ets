import emitter from '@ohos.events.emitter';
@Component
export default struct TodoItem {
  private title?: string;
  private index?: number;
  @State isChecked: boolean = false;
  @Prop isEditMode: boolean
  @Link todoListData: Array<string>

  build() {
    Column() {
      Row() { // Text(this.index.toString())
        Row() {
          if (this.isChecked) {
            Text(this.title).fontSize(28).decoration({ type: TextDecorationType.LineThrough })
            Image($r('app.media.check1')).width(30).height(30)
          } else {
            Text(this.title).fontSize(28).opacity(0.5)
            // Image($r('app.media.check2')).width(30).height(30).opacity(0.5)
          }
        }.justifyContent(FlexAlign.SpaceBetween).backgroundColor(Color.Pink)

        if (this.isEditMode) {
          Row() {
            Image($r('app.media.delete')).width(30).height(30).onClick(item => {
              // todo
              this.todoListData.splice(this.index, 1)
            })
          }.backgroundColor(Color.Red)
        }
      }
      .justifyContent(FlexAlign.SpaceBetween)
      .width('100%')

      .padding({ top: 15, bottom: 15, left: 10, right: 10 })
      .onClick(() => {
        this.isChecked = !this.isChecked
      })


      Divider().width('90%').height(1)
    }.backgroundColor(Color.Green)
  }
}