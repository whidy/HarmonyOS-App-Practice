import TodoItem from '../components/TodoItem';

@Entry
@Component
struct Todo {
  @State message: string = 'My TODO List';
  @State todoListData: Array<string> = [];
  @State isEditMode: boolean = false;
  @State isItemEditMode: boolean = false;
  @State itemTitle: string = ''

  build() {
    Column() {
      Row() {
        Column() {
          Text(this.message).fontSize(30).fontWeight(FontWeight.Bold)
        }.width('100%')
      }.padding({ top: 20, bottom: 20, })

      Divider().width(300).height(1)

      Row() {
        if (this.isEditMode) {
          Row() {
            Text("列表")
          }

          Row() {
            Row() {
              Text("关闭").fontColor(Color.Gray).margin({ right: 10 })
              Image($r('app.media.close')).width(30).height(30).opacity(0.6)
            }.justifyContent(FlexAlign.End).onClick(() => {
              this.isEditMode = false
            })
          }
        } else {
          Row() {
            Text("列表")
          }

          Row() {
            Row() {
              Text("编辑").fontColor(Color.Blue).margin({ right: 10 })
              Image($r('app.media.edit')).width(30).height(30)
            }.justifyContent(FlexAlign.End).onClick(() => {
              this.isEditMode = true
            })
          }
        }

      }.justifyContent(FlexAlign.SpaceBetween).width('100%').padding({ top: 10, bottom: 10 })

      Divider().width(480).height(1)

      Column() {
        Column() {
          if (this.todoListData.length > 0) {
            ForEach(this.todoListData, (item: string, index: number) => {
              TodoItem({ title: item, isEditMode: this.isEditMode, index })
            }, (item, index) => JSON.stringify(item) + index)
          } else {
            Text('暂无数据').padding(50).opacity(0.5)
          }
        }
        Button("增加一条", { type: ButtonType.Capsule }).onClick(() => {
          this.isItemEditMode = true
        })
      }.justifyContent(FlexAlign.SpaceBetween).flexShrink(1)

      if (this.isItemEditMode) {
        Column() {
          Row() {
            Text("新增").fontSize(18)
            Image($r('app.media.close')).width(30).height(30)
          }.justifyContent(FlexAlign.SpaceBetween).width('80%').margin({ bottom: 30 })

          TextInput({ placeholder: "请输入名字", })
            .type(InputType.Normal)
            .width('80%')
            .height(30)
            .margin({ bottom: 30 })
            .placeholderFont({ size: 12, })
            .onChange((value: string) => {
              this.itemTitle = value
            }) // Text(this.itemTitle)
          Row() {
            Button('取消').onClick(() => {
              this.isItemEditMode = false
            }).backgroundColor(Color.Gray).margin({ right: 20 })
            Button('确认').onClick(() => {
              this.todoListData.push(this.itemTitle)
              this.isItemEditMode = false
            })
          }.justifyContent(FlexAlign.End).width('80%')
        }
        .position({ x: '0', y: '30%' })
        .alignItems(HorizontalAlign.Center)
        .width('100%')
        .padding({ top: 20, left: 20, right: 20, bottom: 20 })
        .backgroundColor('#fff')
        .shadow({ radius: 3, color: 'rgba(0,0,0,0.4)', offsetX: 3, offsetY: 3, })
        .border({ width: 1, color: Color.Gray, style: BorderStyle.Dotted })
      }

    }
    .height("auto")
    .padding({ left: 20, right: 20 })
    .margin(10)
    .border({ width: 1, style: BorderStyle.Solid, color: Color.Blue, radius: 4 })
  }
}