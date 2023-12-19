/**
 * 首页视图模型
 */
import { AlarmClockConstant, WeekDays } from '../../common/constants/AlarmClockConstant'
import DataTypeUtils from '../../common/utils/DataTypeUtil'
import { GlobalContext } from '../../common/utils/GlobalContext'
import PreferenceHandler from '../../model/alarm_clock/database/PreferenceHandler'
import PreferencesListener from '../../model/alarm_clock/database/PreferencesListener'
import ReminderService from '../../model/alarm_clock/ReminderService'
import AlarmItem from './AlarmItem'

export default class MainViewModel {
  static instant: MainViewModel = new MainViewModel()
  private reminderService: ReminderService
  private alarms: Array<AlarmItem>

  private constructor() {
    this.alarms = new Array()
    this.reminderService = new ReminderService()
    this.reminderService.openNotificationPermission()
  }

  //查询已经存在的闹钟
  private queryDatabaseAlarms(callback: (alarms: Array<AlarmItem>) => void) {
    let preference = GlobalContext.getContext().getObject('preference') as PreferenceHandler
    preference.get(AlarmClockConstant.ALARM_KEY).then((data: string) => {
      if (!DataTypeUtils.isNull(data)) {
        this.alarms = JSON.parse(data)
        callback(this.alarms)
      }
    })
  }

  public queryAlarmsTasker(callback: (alarms: Array<AlarmItem>) => void) {
    let that = this
    that.queryDatabaseAlarms(callback)
    let preference = GlobalContext.getContext().getObject('preference') as PreferenceHandler
    preference.addPreferencesListener({
      onDataChanged() {
        that.queryDatabaseAlarms(callback)
      }
    } as PreferencesListener)
  }

  public fillZero(value: number): string {
    return (value > 9) ? value.toString() : ('0' + value)
  }

  public getNoonContent(hour: number): string {
    return (hour < AlarmClockConstant.DEFAULT_TOTAL_HOUR) ? AlarmClockConstant.DEFAULT_STRING_MORNING : AlarmClockConstant.DEFAULT_STRING_AFTERNOON
  }

  public getTaskTimeContent(hour: number, minute: number): string {
    return (this.fillZero(hour > AlarmClockConstant.DEFAULT_TOTAL_HOUR ? hour - AlarmClockConstant.DEFAULT_TOTAL_HOUR : hour)
    + AlarmClockConstant.DEFAULT_STRING_COLON + this.fillZero(minute))
  }

  public getAlarmRepeatDayContent(repeatDays: Array<number>): string {
    let content = AlarmClockConstant.DEFAULT_STRING_NULL
    for (let i = 0;i < repeatDays.length; i++) {
      let repeatDay = repeatDays[i]
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
      content += (repeatContent + AlarmClockConstant.DEFAULT_STRING_SPACE)
    }
    return content
  }

  public getDescContent(alarmItem: AlarmItem): string {
    return (AlarmItem.name + AlarmClockConstant.DEFAULT_STRING_COMMA +
    (alarmItem.isRepeat ? this.getAlarmRepeatDayContent(alarmItem.repeatDays) : AlarmClockConstant.DEFAULT_STRING_NO_REPEAT))
  }

  /**
   * 新增或删除一个提醒
   * @param id
   * @param isOpen
   */
  public openAlarm(id: number, isOpen: boolean) {
    for (let i = 0;i < this.alarms.length; i++) {
      if (this.alarms[i].id === id) {
        this.alarms[i].isOpen = isOpen
        if (isOpen) {
          this.reminderService.addReminder(this.alarms[i])
        } else {
          this.reminderService.deleteReminder(this.alarms[i].id)
        }
        //更新本地存储
        let preference = GlobalContext.getContext().getObject('preference') as PreferenceHandler
        preference.set(AlarmClockConstant.ALARM_KEY, JSON.stringify(this.alarms))
        break
      }
    }
  }
}