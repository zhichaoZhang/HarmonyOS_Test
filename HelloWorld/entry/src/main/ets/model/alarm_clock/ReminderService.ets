/**
 * 基于系统代理提醒的服务
 */
import notificationManager from '@ohos.notificationManager'
import reminderAgentManager from '@ohos.reminderAgentManager'
import { AlarmClockConstant } from '../../common/constants/AlarmClockConstant'
import Logger from '../../common/constants/Logger'
import ReminderItem from '../../viewmodel/alarm_clock/ReminderItem'

export default class ReminderService {

  /**
   * 开启通知权限
   */
  public openNotificationPermission() {
    notificationManager.requestEnableNotification().then(() => {
      Logger.info('Enable notification success')
    }).catch((err: Error) => {
      Logger.error('Enable notification failed because ' + JSON.stringify(err))
    })
  }

  /**
   * 添加或修改闹钟提醒
   * @param alarmItem
   * @param callback
   */
  public addReminder(alarmItem: ReminderItem, callback?: (reminderId: number) => void) {
    let reminder = this.initReminder(alarmItem)
    reminderAgentManager.publishReminder(reminder, (err, reminderId: number) => {
      if (callback != null) {
        callback(reminderId)
      }
    })
  }

  /**
   * 删除提醒
   * @param reminderId
   */
  public deleteReminder(reminderId: number) {
    reminderAgentManager.cancelReminder(reminderId)
  }

  /**
   * 根据指定信息创建一个系统的闹钟代理提醒
   * @param item
   * @returns
   */
  private initReminder(item: ReminderItem): reminderAgentManager.ReminderRequestAlarm {
    return {
      reminderType: item.remindType,
      hour: item.hour,
      minute: item.minute,
      daysOfWeek: item.repeatDays,
      title: item.name,
      ringDuration: item.duration * AlarmClockConstant.DEFAULT_TOTAL_MINUTE,
      snoozeTimes: item.intervalTimes,
      timeInterval: item.intervalMinute * AlarmClockConstant.DEFAULT_TOTAL_MINUTE,
      actionButton: [
        {
          title: '关闭',
          type: reminderAgentManager.ActionButtonType.ACTION_BUTTON_TYPE_CLOSE
        },
        {
          title: '稍后提醒',
          type: reminderAgentManager.ActionButtonType.ACTION_BUTTON_TYPE_SNOOZE
        }
      ],
      //提醒点击落地页
      wantAgent: {
        pkgName: 'com.zzc.helloworld',
        abilityName: 'EntryAbility'
      },
      notificationId: item.notificationId,
      expiredContent: 'this reminder has expired',
      snoozeContent: 'remind later',
      slotType: notificationManager.SlotType.SOCIAL_COMMUNICATION
    }
  }
}