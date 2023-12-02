// 格式化日期时间的函数
export function formatDateTime(date: Date | number, format: string): string {
  // 如果输入的日期是数字，将其转换为日期对象
  date = new Date(date)
  // 定义日期格式化的参数对象
  const o = {
    'y+': date.getFullYear(), // 年份
    'M+': date.getMonth() + 1, // 月份
    'd+': date.getDate(), // 日
    'h+': date.getHours() % 12 === 0 ? 12 : date.getHours() % 12, // 小时
    'H+': date.getHours(), // 小时
    'm+': date.getMinutes(), // 分
    's+': date.getSeconds(), // 秒
    'q+': Math.floor((date.getMonth() + 3) / 3), // 季度
    'S+': date.getMilliseconds(), // 毫秒
    'a': date.getHours() < 12 ? '上午' : '下午', // 上午/下午
    'A': date.getHours() < 12 ? 'AM' : 'PM', // AM/PM
  };

  // 替换日期格式中的占位符
  if (/(y+)/.test(format)) {
    format = format.replace(RegExp.$1, (date.getFullYear() + '').substr(4 - RegExp.$1.length));
  }

  for (let k in o) {
    if (new RegExp('(' + k + ')').test(format)) {
      format = format.replace(
        RegExp.$1,
          RegExp.$1.length === 1 ? o[k] : ('00' + o[k]).substr(('' + o[k]).length)
      );
    }
  }

  // 返回格式化后的日期字符串
  return format;
}

/**
 * 获取星期几的中文表示。
 * @param dayOfWeek 星期几的数字表示 (0表示星期日, 1表示星期一, 以此类推)
 * @returns 星期几的中文表示
 */
export function getChineseWeekday(dayOfWeek: number): string {
  const weekdays = ['日', '一', '二', '三', '四', '五', '六'];

  if (dayOfWeek >= 0 && dayOfWeek <= 6) {
    return weekdays[dayOfWeek];
  } else {
    throw new Error('无效的星期几数字，必须在0到6之间');
  }
}

/**
 * 根据偏移量调整日期时间。
 * @param date 日期时间对象或时间戳
 * @param offset 偏移量，可以为正数（向后移动）或负数（向前移动）
 * @returns 调整后的日期时间对象
 */
export function plusOffset(date: number | Date, offset: number): Date {
  date = new Date(date)
  // 确定符号并取得绝对值
  const sign = offset >= 0 ? 1 : -1;
  const absoluteOffset = Math.abs(offset);

  // 分离小时和分钟
  const hours = Math.floor(absoluteOffset);
  const minutes = Math.floor((absoluteOffset - hours) * 60);
  date.setHours(date.getHours() + sign * hours)
  date.setMinutes(date.getMinutes() + sign * minutes)
  return date
}
