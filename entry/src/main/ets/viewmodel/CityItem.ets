export default class CityItem {
  city: string // 城市名称
  country: string // 国家名称
  UTCOffset: number // 时区偏移

  static equals(one: CityItem, other: CityItem) {
    return one.city === other.city && one.country === other.country
  }

  /**
   * 格式化时区偏移，将其转换为形如+HH:mm或-HH:mm的字符串。
   * @param offset - 时区偏移，单位：小时
   * @returns 格式化后的时区字符串，例如 +08:00 或 -05:30
   */
  static formatUTCOffset(offset: number): string {
    // 确定符号并取得绝对值
    const sign = offset >= 0 ? '+' : '-';
    const absoluteOffset = Math.abs(offset);

    // 分离小时和分钟
    const hours = Math.floor(absoluteOffset);
    const minutes = Math.floor((absoluteOffset - hours) * 60);

    // 格式化小时和分钟
    const formattedHours = hours.toString()
    const formattedMinutes = minutes.toString().padStart(2, '0');

    // 返回格式化的字符串
    return `${sign}${formattedHours}:${formattedMinutes}`;
  }
}
