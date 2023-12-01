export default class CityItem {
  city: string
  country: string
  UTCOffset: number

  static equals(one: CityItem, other: CityItem) {
    return one.city === other.city && one.country === other.country
  }

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