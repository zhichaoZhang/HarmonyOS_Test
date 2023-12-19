import ReminderItem from './ReminderItem';
/**
 * 闹钟提醒描述
 */
@Observed export default class AlarmItem extends ReminderItem {
  name = '闹钟'
  isOpen: boolean = true
  isRepeat: boolean = false
  duration: number = 5
  intervalMinute: number = 10
  intervalTimes: number = 3
}