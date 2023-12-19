import { TargetManageConstants } from '../../common/constants/TargetManageConstant'

/**
 * 进度编辑
 */
@Component
export default struct ProgressEditPanel {
  @Link slideMode: number
  @Prop slidingProgress: number
  onCancel?: () => void
  onClickOk?: (progress: number) => void

  build() {
    Column() {
      Row() {
        Slider({
          value: this.slidingProgress,
          min: TargetManageConstants.SLIDER_MIN_VALUE,
          max: TargetManageConstants.SLIDER_MAX_VALUE,
          style: SliderStyle.InSet,
          step: TargetManageConstants.SLIDER_STEP
        })
          .width(TargetManageConstants.SLIDER_INNER_WIDTH)
          .onChange((value: number, mode: SliderChangeMode) => {
            this.slidingProgress = Math.floor(value)
            this.slideMode = mode
          })
        Text(`${this.slidingProgress}%`)
          .fontSize($r('app.float.progress_font'))
          .fontWeight(TargetManageConstants.FONT_WEIGHT)
          .fontColor($r('app.color.dialog_progress'))
          .textAlign(TextAlign.Center)
          .margin({ left: $r('app.float.slider_margin_left') })
      }
      .width(TargetManageConstants.SLIDER_WIDTH)
      .height(TargetManageConstants.SLIDER_HEIGHT)

      Row() {
        CustomButton({ buttonText: $r('app.string.cancel_button') })
          .onClick(() => {
            if (this.onCancel !== undefined) {
              this.onCancel()
            }
          })

        CustomButton({ buttonText: $r('app.string.confirm_button') })
          .onClick(() => {
            if (this.onClickOk !== undefined) {
              this.onClickOk(this.slidingProgress)
            }
          })
      }
      .margin({ top: TargetManageConstants.SLIDER_BUTTON_MARGIN })
      .width(TargetManageConstants.DIALOG_OPERATION_WIDTH)
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .height($r('app.float.edit_panel_height'))
    .width(TargetManageConstants.FULL_WIDTH)
    .justifyContent(FlexAlign.End)
  }
}

/**
 * 自定义按钮
 */
@Component
struct CustomButton {
  @State buttonColor: Resource = $r('app.color.start_window_background')
  buttonText?: Resource

  build() {
    Text(this.buttonText)
      .dialogButtonStyle()
      .backgroundColor(this.buttonColor)
      .textAlign(TextAlign.Center)
      .onTouch((event?: TouchEvent) => {
        if (event !== undefined && event.type === TouchType.Down) {
          this.buttonColor = $r('app.color.custom_button_color')
        }
        if (event !== undefined && event.type === TouchType.Up) {
          this.buttonColor = $r('app.color.start_window_background')
        }
      })
  }
}

/**
 * 自定义按钮样式
 */
@Extend(Text) function dialogButtonStyle() {
  .fontSize($r('app.float.button_font'))
  .height($r('app.float.dialog_btn_height'))
  .width($r('app.float.dialog_btn_width'))
  .fontColor($r('app.color.main_blue'))
}