import { AlarmClockConstant, WeekDays } from '../../common/constants/AlarmClockConstant'
import DataTypeUtils from '../../common/utils/DataTypeUtil'
import { GlobalContext } from '../../common/utils/GlobalContext'
import PreferenceHandler from '../../model/alarm_clock/database/PreferenceHandler'
import ReminderService from '../../model/alarm_clock/ReminderService'
import AlarmItem from './AlarmItem'
import DayDataItem from './DayDataItem'

/**
 * 详情页视图模型
 */
export default class DetailViewModel {
  static instant: DetailViewModel = new DetailViewModel()
  private reminderService: ReminderService
  private alarms: Array<AlarmItem>

  private constructor() {
    this.reminderService = new ReminderService()
    this.alarms = new Array<AlarmItem>()
  }

  /**
   * 转换重复星期数为描述
   * @param repeatDay
   * @returns
   */
  public transAlarmRepeatDayContent(repeatDay: number): string {
    let repeatContent: string = AlarmClockConstant.DEFAULT_STRING_MONDAY
    switch (repeatDay) {
      case WeekDays.DEFAULT_NUMBER_MONDAY:
        repeatContent = AlarmClockConstant.DEFAULT_STRING_MONDAY
        break
      case WeekDays.DEFAULT_NUMBER_TUESDAY:
        repeatContent = AlarmClockConstant.DEFAULT_STRING_TUESDAY
        break
      case WeekDays.DEFAULT_NUMBER_WEDNESDAY:
        repeatContent = AlarmClockConstant.DEFAULT_STRING_WEDNESDAY
        break
      case WeekDays.DEFAULT_NUMBER_THURSDAY:
        repeatContent = AlarmClockConstant.DEFAULT_STRING_THURSDAY
        break
      case WeekDays.DEFAULT_NUMBER_FRIDAY:
        repeatContent = AlarmClockConstant.DEFAULT_STRING_FRIDAY
        break
      case WeekDays.DEFAULT_NUMBER_SATURDAY:
        repeatContent = AlarmClockConstant.DEFAULT_STRING_SATURDAY
        break
      case WeekDays.DEFAULT_NUMBER_SUNDAY:
        repeatContent = AlarmClockConstant.DEFAULT_STRING_SUNDAY
        break
      default:
        break
    }
    return repeatContent
  }

  /**
   * 设置初始化的提醒时间
   * @param alarmTime
   */
  public setAlarmDefaultTime(alarmTime?: AlarmItem) {
    let hour: number
    let minute: number
    if (alarmTime == null) {
      let date = new Date()
      hour = date.getHours()
      minute = date.getMinutes()
    } else {
      hour = alarmTime.hour
      minute = alarmTime.minute
    }
    AlarmClockConstant.DAY_DATA[0].delSelect =
    (hour >= AlarmClockConstant.DEFAULT_TOTAL_HOUR ? AlarmClockConstant.DEFAULT_SINGLE : 0)

    AlarmClockConstant.DAY_DATA[AlarmClockConstant.DEFAULT_SINGLE].delSelect =
    (hour === 0 ? AlarmClockConstant.DEFAULT_TOTAL_HOUR :
      (hour > AlarmClockConstant.DEFAULT_TOTAL_HOUR ? hour - AlarmClockConstant.DEFAULT_TOTAL_HOUR : hour)) - AlarmClockConstant.DEFAULT_SINGLE

    AlarmClockConstant.DAY_DATA[AlarmClockConstant.DEFAULT_DATA_PICKER_HOUR_SELECTION].delSelect =
    (minute === 0 ? AlarmClockConstant.DEFAULT_TOTAL_MINUTE : minute) - AlarmClockConstant.DEFAULT_SINGLE
  }

  /**
   * 设置闹钟提醒
   * @param alarmItem
   */
  public async setAlarmRemind(alarmItem: AlarmItem) {
    alarmItem.hour = this.getAlarmTime(AlarmClockConstant.DEFAULT_SINGLE)
    alarmItem.minute = this.getAlarmTime(AlarmClockConstant.DEFAULT_DATA_PICKER_HOUR_SELECTION)
    let index = await this.findAlarmWithId(alarmItem.id)
    if (index !== AlarmClockConstant.DEFAULT_NUMBER_NEGATIVE) {
      this.reminderService.deleteReminder(alarmItem.id)
    } else {
      index = this.alarms.length
      alarmItem.notificationId = index
      this.alarms.push(alarmItem)
    }
    this.reminderService.addReminder(alarmItem, (newId: number) => {
      alarmItem.id = newId
      alarmItem.isOpen = true
      this.alarms[index] = alarmItem
      let preference = GlobalContext.getContext().getObject('preference') as PreferenceHandler
      preference.set(AlarmClockConstant.ALARM_KEY, JSON.stringify(this.alarms))
    })
  }

  /**
   * 移除闹钟提醒
   * @param id
   */
  public async removeAlarmRemind(id: number) {
    this.reminderService.deleteReminder(id)
    let index = await this.findAlarmWithId(id)
    if (index !== AlarmClockConstant.DEFAULT_NUMBER_NEGATIVE) {
      this.alarms.splice(index, AlarmClockConstant.DEFAULT_SINGLE)
    }
    let preference = GlobalContext.getContext().getObject('preference') as PreferenceHandler
    preference.set(AlarmClockConstant.ALARM_KEY, JSON.stringify(this.alarms))
  }

  private getAlarmTime(aType: number): number {
    let times: DayDataItem = AlarmClockConstant.DAY_DATA[aType]
    let selectedIndex = times.delSelect
    let time = Number(times.data[selectedIndex])
    if (aType === AlarmClockConstant.DEFAULT_SINGLE) {
      time = (time === AlarmClockConstant.DEFAULT_TOTAL_HOUR ? 0 : time)
      + (AlarmClockConstant.DAY_DATA[0].delSelect === AlarmClockConstant.DEFAULT_SINGLE ? AlarmClockConstant.DEFAULT_TOTAL_HOUR : 0)
    }
    return time
  }

  private async findAlarmWithId(id: number) {
    let preference = GlobalContext.getContext().getObject('preference') as PreferenceHandler
    let data = await preference.get(AlarmClockConstant.ALARM_KEY)
    if (!DataTypeUtils.isNull(data)) {
      this.alarms = JSON.parse(data)
      for (let i = 0; i < this.alarms.length; i++) {
        if (this.alarms[i].id === id) {
          return i
        }
      }
    }
    return AlarmClockConstant.DEFAULT_NUMBER_NEGATIVE
  }
}