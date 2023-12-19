/**
 * Preferences数据变更监听
 */
export default interface PreferencesListener {
  onDataChanged: (key: string) => void
}