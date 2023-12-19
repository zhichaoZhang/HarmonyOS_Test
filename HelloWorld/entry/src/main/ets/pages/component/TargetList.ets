/**
 * 任务列表
 */
import { TargetManageConstants } from '../../common/constants/TargetManageConstant'
import TargetListItem from '../../view/targetmanage/TargetListItem'
import TargetManageViewModel, { TaskItemBean } from '../../viewmodel/TargetManageViewModel'

@Component
export default struct TargetList {
  @Consume overAllProgressChanged: boolean
  @State isEditModel: boolean = false
  @State selectArray: Array<boolean> = []
  @State clickIndex: number = TargetManageConstants.DEFAULT_CLICK_INDEX
  @State selectAll: boolean = false
  @Link targetData: Array<TaskItemBean>
  onAddClick?: () => void

  build() {
    Column() {
      Row() {
        Text($r('app.string.sub_goals'))
          .fontSize($r('app.float.secondary_title'))
          .fontWeight(TargetManageConstants.FONT_WEIGHT_LARGE)
          .fontColor($r('app.color.title_black_color'))
        Blank()
        if (this.targetData.length > 0) {
          if (this.isEditModel) {
            Text($r('app.string.cancel_button'))
              .operateTextStyle($r('app.color.main_blue'))
              .margin({ left: $r('app.float.operate_button_margin') })
              .onClick(() => {
                this.selectAll = false
                this.isEditModel = false
                this.selectAllOrCancel(false)
              })
            Text($r('app.string.select_all_button'))
              .operateTextStyle($r('app.color.main_blue'))
              .margin({ left: $r('app.float.operate_button_margin') })
            Checkbox()
              .select(this.isSelectAll())
              .selectedColor($r('app.color.main_blue'))
              .width(TargetManageConstants.CHECKBOX_WIDTH)
              .onClick(() => {
                this.selectAll = !this.selectAll
                this.selectAllOrCancel(this.selectAll)
              })
          } else {
            Text($r('app.string.edit_button'))
              .operateTextStyle($r('app.color.main_blue'))
              .onClick(() => {
                this.isEditModel = true
                this.selectAllOrCancel(false)
              })
          }
        }
      }
      .width(TargetManageConstants.FULL_WIDTH)
      .height($r('app.float.history_line_height'))
      .padding({
        left: $r('app.float.list_padding'),
        right: $r('app.float.list_padding_right')
      })

      List({ space: TargetManageConstants.LIST_SPACE }) {
        ForEach(this.targetData, (item: TaskItemBean, index: number | undefined) => {
          ListItem() {
            TargetListItem({
              taskItem: item,
              index: index,
              selectArr: $selectArray,
              isEditMode: this.isEditModel,
              clickIndex: $clickIndex
            })
          }
        }, (item: TaskItemBean) => JSON.stringify(item))
      }.edgeEffect(EdgeEffect.None)
      .margin({ top: $r('app.float.list_margin_top') })
      .width(TargetManageConstants.FULL_WIDTH)
      .height(TargetManageConstants.LIST_HEIGHT)

      Blank()

      if (this.isEditModel) {
        Button($r('app.string.delete_button'))
          .opacity(this.isSelectRows() ? TargetManageConstants.NO_OPACITY : TargetManageConstants.OPACITY)
          .enabled(this.isSelectRows() ? true : false)
          .operateButtonStyle($r('app.color.main_red'))
          .onClick(() => {
            this.deleteSelected()
            this.selectAllOrCancel(false)
            this.selectAll = false
          })
      } else {
        Button($r('app.string.add_task'))
          .operateButtonStyle($r('app.color.main_blue'))
          .onClick(() => {
            if (this.onAddClick !== undefined) {
              this.onAddClick()
            }
          })
      }
    }.width(TargetManageConstants.MAIN_BOARD_WIDTH)
    .height(TargetManageConstants.FULL_HEIGHT)
    .padding({ top: $r('app.float.operate_row_margin') })
  }

  /**
   * 删除选中项并退出编辑模式
   */
  deleteSelected() {
    TargetManageViewModel.deleteTasks(this.selectArray)
    this.targetData = TargetManageViewModel.getData()
    this.overAllProgressChanged = !this.overAllProgressChanged
    this.isEditModel = false
  }

  /**
   * 选中或取消选中所有
   * @param selectStatus
   */
  selectAllOrCancel(selectStatus: boolean) {
    let newSelectArray: Array<boolean> = []
    this.targetData.forEach(() => {
      newSelectArray.push(selectStatus)
    })
    this.selectArray = newSelectArray
  }

  /**
   * 是否选中了所有
   * @returns
   */
  isSelectAll(): boolean {
    if (this.selectArray.length === 0) {
      return false
    }
    let deSelectCount = this.selectArray.filter((selected: boolean) => selected === false).length
    if (deSelectCount === 0) {
      this.selectAll = true
      return true
    }
    this.selectAll = false
    return false
  }

  /**
   * 是否有选中的行
   * @returns
   */
  isSelectRows(): boolean {
    return this.selectArray.filter((selected: boolean) => selected === true).length !== 0
  }
}

@Extend(Text) function operateTextStyle(color: Resource) {
  .fontSize($r('app.float.text_button_font'))
  .fontColor(color)
  .lineHeight($r('app.float.text_line_height'))
  .fontWeight(TargetManageConstants.FONT_WEIGHT)
}

/**
 * 自定义按钮样式
 * @param color 颜色资源
 */
@Extend(Button) function operateButtonStyle(color: Resource) {
  .width($r('app.float.button_width'))
  .height($r('app.float.button_height'))
  .fontSize($r('app.float.button_font'))
  .fontWeight(TargetManageConstants.FONT_WEIGHT)
  .fontColor(color)
  .backgroundColor($r('app.color.button_background'))
}