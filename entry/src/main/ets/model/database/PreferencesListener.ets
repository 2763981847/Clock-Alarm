/**
 * Preferences listener interface.
 */
export default interface PreferencesListener {
  /**
   * Preferences on data changed listener.
   *
   * @param key string
   */
  onDataChanged: (key?: string) => void
}