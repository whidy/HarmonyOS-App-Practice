import TodoItem from '../components/TodoItem';
import TodoItemEdit from '../components/TodoItemEdit';
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
      }.padding({ bottom: 20, })

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

      Divider().width('100%').height(1)

      Column() {
        Column() {
          if (this.todoListData.length > 0) {
            ForEach(this.todoListData, (item: string, index: number) => {
              TodoItem({ title: item, isEditMode: this.isEditMode, index, todoListData: $todoListData })
            }, (item, index) => JSON.stringify(item) + index)
          } else {
            Text('暂无数据').padding(50).opacity(0.5)
          }
        }
        Button("增加一条", { type: ButtonType.Capsule }).onClick(() => {
          this.isItemEditMode = true
        }).margin({top: 20})
      }.justifyContent(FlexAlign.SpaceBetween).flexShrink(1)

      if (this.isItemEditMode) {
        TodoItemEdit({
          itemTitle: $itemTitle,
          isItemEditMode: $isItemEditMode,
          todoListData: $todoListData,
        })
      }

    }
    // todo 关于这个高度在外边距有10的情况下如何铺满？
    .height("auto")
    .padding(20)
    .margin(10)
    .border({ width: 1, style: BorderStyle.Solid, color: Color.Blue, radius: 4 })
  }
}