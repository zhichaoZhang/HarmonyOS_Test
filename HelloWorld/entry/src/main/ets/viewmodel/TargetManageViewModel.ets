/**
 * 页面数据处理
 */
import Logger from '../common/constants/Logger'

const TAG = '[TargetManageViewModel]'

export class TargetManageViewModel {
  private targetTaskData: Array<TaskItemBean> = []

  getData(): Array<TaskItemBean> {
    return this.targetTaskData
  }

  /**
   * 删除选中的任务
   * @param selectArr 所有任务的选中状态
   */
  deleteTasks(selectArr: Array<boolean>) {
    if (!selectArr) {
      Logger.error(TAG, 'Failed to delete data because selectArr is ' + selectArr)
      return
    }
    let dataLen = this.targetTaskData.length
    for (let i = 0; i < dataLen; i++) {
      if (selectArr[i]) {
        this.targetTaskData.splice(i, 1)
      }
    }
  }

  /**
   * 添加新任务
   * @param data 任务数据
   */
  addTask(data: TaskItemBean) {
    if (!data) {
      Logger.error(TAG, 'addTask error because data is ' + data)
      return
    }
    this.targetTaskData.push(data)
  }

  /**
   * 获取最近任务的进度
   * @returns 进度
   */
  getLatestProgressValue(): number {
    if (this.targetTaskData.length == 0) {
      return 0
    }
    let len = this.targetTaskData.length
    return this.targetTaskData[len - 1].progressValue
  }

  /**
   * 更新任务进度
   * @param index  任务索引
   * @param updateValue 进度
   * @param updateDate 更新日期
   * @returns 是否更新成功
   */
  updateProgress(index: number, updateValue: number, updateDate: string): boolean {
    if (!this.targetTaskData[index]) {
      return false
    }
    this.targetTaskData[index].progressValue = updateValue
    this.targetTaskData[index].updateDate = updateDate
  }
}

export default new TargetManageViewModel()

/**
 * 任务项实体类
 */
export class TaskItemBean {

  /**
   * 任务名称
   */
  taskName: string

  /**
   * 更新时间
   */
  updateDate: string

  /**
   * 任务进度
   */
  progressValue: number

  constructor(taskName: string, progressValue: number, updateData: string) {
    this.taskName = taskName
    this.progressValue = progressValue
    this.updateDate = updateData
  }
}