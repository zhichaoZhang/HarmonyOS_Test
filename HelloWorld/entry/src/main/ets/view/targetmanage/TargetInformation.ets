import { TargetManageConstants } from '../../common/constants/TargetManageConstant'

/**
 * 任务总信息
 */
@Component
export default struct TargetInformation {
  @Prop latestUpdateDate: string
  @Prop totalTasksNumber: number
  @Prop completedTasksNumber: number

  build() {
    Column() {
      this.TargetItem()
      this.OverallProgress()
    }
    .padding($r('app.float.target_padding'))
    .width(TargetManageConstants.MAIN_BOARD_WIDTH)
    .height($r('app.float.target_info_height'))
    .backgroundColor(Color.White)
    .borderRadius(TargetManageConstants.TARGET_BORDER_RADIUS)
  }

  @Builder
  TargetItem() {
    Row() {
      Image($r('app.media.ic_main'))
        .width($r('app.float.target_image_length'))
        .height($r('app.float.target_image_length'))
        .objectFit(ImageFit.Fill)
        .borderRadius(TargetManageConstants.IMAGE_BORDER_RADIUS)

      Column() {
        Text($r('app.string.target_name'))
          .fontSize($r('app.float.target_name_font'))
          .fontWeight(TargetManageConstants.FONT_WEIGHT_LARGE)
          .width(TargetManageConstants.TITLE_WIDTH)
        Text($r('app.string.target_info'))
          .opacityTextStyle()
          .fontSize($r('app.float.target_desc_font'))
          .margin({ top: $r('app.float.title_margin') })
      }
      .margin({ left: TargetManageConstants.TARGET_MARGIN_LEFT })
      .alignItems(HorizontalAlign.Start)
    }.width(TargetManageConstants.FULL_WIDTH)
  }

  /**
   * 整体进度
   */
  @Builder
  OverallProgress() {
    Row() {
      Column() {
        Text($r('app.string.overall_progress'))
          .fontSize($r('app.float.button_font'))
          .fontColor($r('app.color.title_black_color'))
          .fontWeight(TargetManageConstants.FONT_WEIGHT)

        Row() {
          Text($r('app.string.latest_updateTime'))
            .opacityTextStyle()
          Text(this.latestUpdateDate)
            .opacityTextStyle()
        }
        .margin({ top: $r('app.float.text_margin') })
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Stack() {
        Row() {
          Text(this.completedTasksNumber.toString())
            .fontSize($r('app.float.progress_font'))
            .fontWeight(TargetManageConstants.FONT_WEIGHT)
            .fontColor($r('app.color.main_blue'))
          Text(`/${this.totalTasksNumber}`)
            .fontSize($r('app.float.progress_font'))
            .fontWeight(TargetManageConstants.FONT_WEIGHT)
        }

        Progress({ value: this.completedTasksNumber,
          total: this.totalTasksNumber,
          type: ProgressType.Ring })
          .color($r('app.color.main_blue'))
          .style({
            strokeWidth: TargetManageConstants.STROKE_WIDTH
          })
          .width($r('app.float.progress_length'))
          .height($r('app.float.progress_length'))
      }
    }
    .width(TargetManageConstants.FULL_WIDTH)
    .height($r('app.float.progress_length'))
    .margin({ top: $r('app.float.progress_margin_top') })
  }
}

/**
 * 自定义透明文本样式
 */
@Extend(Text) function opacityTextStyle() {
  .fontColor($r('app.color.title_black_color'))
  .fontSize($r('app.float.text_font'))
  .opacity(TargetManageConstants.OPACITY)
  .fontWeight(TargetManageConstants.FONT_WEIGHT)
}