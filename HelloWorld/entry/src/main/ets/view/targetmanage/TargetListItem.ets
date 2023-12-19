/**
 * 任务条目
 */
import { TargetManageConstants } from '../../common/constants/TargetManageConstant'
import getCurrentTime from '../../common/utils/DateUtil'
import TargetManageViewModel, { TaskItemBean } from '../../viewmodel/TargetManageViewModel'
import ProgressEditPanel from './ProgressEditPanel'

@Component
export default struct TargetListItem {
  private taskItem?: TaskItemBean
  @State latestProgress?: number = 0
  @State updateDate?: string = ''
  @Link selectArr: Array<boolean>
  @Prop isEditMode: boolean
  @Link @Watch('onClickIndexChanged') clickIndex: number
  @State isExpanded: boolean = false
  @Consume overAllProgressChanged: boolean
  @State sliderModel: number = TargetManageConstants.DEFAULT_SLIDER_MODE
  public index: number = 0

  /**
   * 可见状态回调
   */
  aboutToAppear() {
    this.latestProgress = this.taskItem?.progressValue
    this.updateDate = this.taskItem.updateDate
  }

  /**
   * 点击位置变更回调
   */
  onClickIndexChanged() {
    if (this.clickIndex != this.index) {
      this.isExpanded = false
    }
  }

  build() {
    Stack({ alignContent: Alignment.Start }) {
      Column() {
        this.TargetItem()
        if (this.isExpanded) {
          Blank()
          ProgressEditPanel({
            slidingProgress: this.latestProgress,
            onCancel: () => this.isExpanded = false,
            onClickOk: (progress: number): void => {
              this.latestProgress = progress
              this.updateDate = getCurrentTime()
              let result = TargetManageViewModel.updateProgress(this.index, this.latestProgress, this.updateDate)
              if (result) {
                this.overAllProgressChanged = !this.overAllProgressChanged
              }
              this.isExpanded = false
            },
            slideMode: $sliderModel
          }).transition({
            scale: {
              x: TargetManageConstants.TRANSITION_ANIMATION_X,
              y: TargetManageConstants.TRANSITION_ANIMATION_Y
            }
          })
        }
      }
      .padding({
        left: $r('app.float.list_padding'),
        top: $r('app.float.list_padding_top'),
        bottom: $r('app.float.list_padding_bottom'),
        right: this.isEditMode ? $r('app.float.list_edit_padding') : $r('app.float.list_padding')
      })
      .height(this.isExpanded ? $r('app.float.expanded_item_height') : $r('app.float.list_item_height'))
      .width(TargetManageConstants.FULL_WIDTH)
      .opacity(this.latestProgress === TargetManageConstants.SLIDER_MAX_VALUE ? TargetManageConstants.OPACITY : TargetManageConstants.NO_OPACITY)
      .borderRadius(TargetManageConstants.LIST_RADIUS)
      .animation({ duration: TargetManageConstants.DURATION })
      .backgroundColor(this.selectArr[this.index] ? $r('app.color.edit_blue') : Color.White)
      .onClick(() => {
        if (this.sliderModel === TargetManageConstants.CLICK_SLIDER_MODE) {
          this.sliderModel = TargetManageConstants.DEFAULT_SLIDER_MODE
          return
        }
        if (!this.isEditMode) {
          animateTo({ duration: TargetManageConstants.DURATION }, () => {
            this.isExpanded = !this.isExpanded
          })
          this.clickIndex = this.index
        }
      })

      if (this.isEditMode) {
        Row() {
          Checkbox()
            .select(this.selectArr[this.index])
            .selectedColor($r('app.color.main_blue'))
            .width(TargetManageConstants.CHECKBOX_WIDTH)
            .margin({ right: $r('app.float.list_padding') })
            .onChange((isCheck: boolean) => {
              this.selectArr[this.index] = isCheck
            })
        }.width(TargetManageConstants.FULL_WIDTH)
        .justifyContent(FlexAlign.End)
      }
    }
  }

  @Builder TargetItem() {
    Row() {
      Text(this.taskItem?.taskName)
        .fontSize($r('app.float.list_font'))
        .fontWeight(TargetManageConstants.FONT_WEIGHT)
        .fontColor($r('app.color.title_black_color'))
        .width(TargetManageConstants.TASK_NAME_WIDTH)
        .textAlign(TextAlign.Start)
        .maxLines(TargetManageConstants.MAX_LINES)
      Blank()
      Column() {
        Text(`${this.latestProgress}%`)
          .fontSize($r('app.float.list_font'))
          .fontWeight(TargetManageConstants.FONT_WEIGHT)
          .fontColor($r('app.color.title_black_color'))
        Row() {
          Text($r('app.string.latest_updateTime'))
            .opacityTextStyle()
          Text(this.updateDate)
            .opacityTextStyle()
        }.margin({ top: $r('app.float.text_margin') })
      }.alignItems(HorizontalAlign.End)
    }.width(TargetManageConstants.FULL_WIDTH)
  }
}

@Extend(Text) function opacityTextStyle() {
  .fontSize($r('app.float.text_font'))
  .fontColor($r('app.color.title_black_color'))
  .opacity(TargetManageConstants.OPACITY)
  .fontWeight(TargetManageConstants.FONT_WEIGHT)
}