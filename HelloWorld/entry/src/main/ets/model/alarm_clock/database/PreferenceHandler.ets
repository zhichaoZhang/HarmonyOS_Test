import preferences from '@ohos.data.preferences'
import { AlarmClockConstant } from '../../../common/constants/AlarmClockConstant'
import PreferencesListener from './PreferencesListener'
/**
 * 基于轻量级数据库首选项处理器
 */
export default class PreferenceHandler {
  static instance: PreferenceHandler = new PreferenceHandler()
  private preferences: preferences.Preferences | null = null
  private defaultValue = ''
  private listeners: PreferencesListener[]

  private constructor() {
    this.listeners = new Array()
  }

  /**
   * 初始化配置
   * @param context
   */
  public async configure(context: Context) {
    this.preferences = await preferences.getPreferences(context, AlarmClockConstant.PREFERENCE_ID)
    this.preferences.on('change', (data: Record<string, Object>) => {
      for (let preferencesListener of this.listeners) {
        preferencesListener.onDataChanged(data.key as string)
      }
    })
  }

  public async set(key: string, value: string) {
    if (this.preferences != null) {
      await this.preferences.put(key, value)
      await this.preferences.flush()
    }
  }

  public async get(key: string) {
    let data: string = ''
    if (this.preferences != null) {
      data = await this.preferences.get(key, this.defaultValue) as string
    }
    return data
  }

  public clear() {
    if (!this.preferences != null) {
      this.preferences.clear()
    }
  }

  public addPreferencesListener(listener: PreferencesListener) {
    this.listeners.push(listener)
  }
}