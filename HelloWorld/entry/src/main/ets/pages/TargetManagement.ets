/**
 * 目标管理页面
 * 父子组件状态传递
 */
import promptAction from '@ohos.promptAction'
import { TargetManageConstants } from '../common/constants/TargetManageConstant'
import getCurrentTime from '../common/utils/DateUtil'
import AddTargetDialog from '../view/targetmanage/AddTargetDialog'
import TargetInformation from '../view/targetmanage/TargetInformation'
import TargetManageViewModel, { TaskItemBean } from '../viewmodel/TargetManageViewModel'
import TargetList from './component/TargetList'

@Entry
@Component
struct TargetManagement {
  @State targetData: Array<TaskItemBean> = TargetManageViewModel.getData()
  @State totalTaskNumber: number = 0
  @State completedTaskNumber: number = 0
  @State latestUpdateDate: string = TargetManageConstants.DEFAULT_PROGRESS_VALUE
  @Provide @Watch('onProgressChanged') overAllProgressChanged: boolean = false
  dialogController: CustomDialogController = new CustomDialogController({
    builder: AddTargetDialog({ onClickOk: (value: string): void => this.saveTask(value) }),
    alignment: DialogAlignment.Bottom,
    offset: {
      dx: TargetManageConstants.DIALOG_OFFSET_X,
      dy: $r('app.float.dialog_offset_y')
    },
    customStyle: true,
    autoCancel: false
  })


  /**
   * 保存任务更新
   * @param taskName
   */
  saveTask(taskName: string) {
    if (taskName === '') {
      promptAction.showToast({
        message: $r('app.string.cannot_input_empty'),
        duration: TargetManageConstants.TOAST_TIME,
        bottom: TargetManageConstants.TOAST_MARGIN_BOTTOM
      })
      return
    }
    TargetManageViewModel.addTask(new TaskItemBean(taskName, 0, getCurrentTime()))
    this.targetData = TargetManageViewModel.getData()
    this.overAllProgressChanged = !this.overAllProgressChanged
    this.dialogController.close()
  }

  /**
   * 进度监听回调
   */
  onProgressChanged() {
    this.totalTaskNumber = this.targetData.length
    this.completedTaskNumber = this.targetData.filter((item: TaskItemBean) => {
      return item.progressValue === TargetManageConstants.SLIDER_MAX_VALUE
    }).length
    this.latestUpdateDate = getCurrentTime()
  }

  build() {
    Column() {
      this.titleBar()
      TargetInformation({
        latestUpdateDate: this.latestUpdateDate,
        totalTasksNumber: this.totalTaskNumber,
        completedTasksNumber: this.completedTaskNumber
      })
      TargetList({
        targetData: $targetData,
        onAddClick: () => this.dialogController.open()
      }).height(TargetManageConstants.LIST_BOARD_HEIGHT)
    }.width(TargetManageConstants.FULL_WIDTH)
    .height(TargetManageConstants.FULL_HEIGHT)
    .backgroundColor($r('app.color.index_background'))
  }

  @Builder titleBar() {
    Text($r('app.string.title'))
      .width(TargetManageConstants.TITLE_WIDTH)
      .height($r('app.float.title_height'))
      .fontSize($r('app.float.title_font'))
      .fontWeight(TargetManageConstants.FONT_WEIGHT_LARGE)
      .textAlign(TextAlign.Start)
      .margin({
        top: $r('app.float.title_margin'),
        bottom: $r('app.float.title_margin')
      })
  }
}