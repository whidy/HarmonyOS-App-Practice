@Component
export default struct TodoItemEdit {
  @Link itemTitle: string
  @Link isItemEditMode: boolean
  @Link todoListData: Array<string>

  build() {
    // todo 弹层的层级关系问题，有外层border影响。
    Column() {
      Row() {
        Text("新增").fontSize(18)
        Image($r('app.media.close')).width(30).height(30)
      }.justifyContent(FlexAlign.SpaceBetween).width('80%').margin({ bottom: 30 })

      TextInput({ placeholder: "请输入名字" })
        .type(InputType.Normal)
        .fontSize(20)
        .width('80%')
        .height(40)
        .margin({ bottom: 30 })
        .placeholderFont({ size: 14 })
        .placeholderColor(Color.Gray)
        .onChange((value: string) => {
          this.itemTitle = value
        }) // Text(this.itemTitle)
      Row() {
        Button('取消').onClick(() => {
          this.isItemEditMode = false
        }).backgroundColor(Color.Gray).margin({ right: 10 })
        Button('确认').onClick(() => {
          this.todoListData.push(this.itemTitle)
          this.isItemEditMode = false
        }).margin({ left: 10 })
      }.justifyContent(FlexAlign.Center).width('80%')
    }
    // todo 如何设置弹窗定位
    // .position({ x: '0', y: '50%' })
    .alignItems(HorizontalAlign.Center)
    .width('100%')
    .padding({ top: 20, left: 20, right: 20, bottom: 20 })
    .backgroundColor('#fff')
    .shadow({ radius: 3, color: 'rgba(0,0,0,0.4)', offsetX: 3, offsetY: 3, })
    .border({ width: 1, color: Color.Gray, style: BorderStyle.Dotted })
  }
}
