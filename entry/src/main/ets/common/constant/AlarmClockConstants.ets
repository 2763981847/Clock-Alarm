/**
 * 闹钟页面常量描述。
 */
export class AlarmClockConstants {
  /**
   * 闹钟页面时间列表。
   */
  static readonly TIMES: number[] = [3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 1, 2];
  /**
   * 默认的单个数字最大值。
   */
  static readonly DEFAULT_SINGLE_DIGIT_MAX: number = 9;
  /**
   * 默认的水平角度。
   */
  static readonly DEFAULT_HORIZONTAL_ANGLE: number = 180;
  /**
   * 默认的一秒毫秒数。
   */
  static readonly DEFAULT_ONE_SECOND_MS: number = 1000;
  /**
   * 默认的零字符串。
   */
  static readonly DEFAULT_ZEROING: string = '0';
  /**
   * 默认的闹钟名称字符串。
   */
  static readonly DEFAULT_STRING_ALARM: string = '闹钟';
  /**
   * 默认的空字符串引号。
   */
  static readonly DEFAULT_STRING_NULL: string = '';
  /**
   * 默认的冒号字符串。
   */
  static readonly DEFAULT_STRING_COLON: string = ':';
  /**
   * 默认的时钟时间字体大小单位。
   */
  static readonly CLOCK_TIME_FONT_SIZE_UNIT: string = 'px';
  /**
   * 小时指针图片的URL。
   */
  static readonly HOUR_POINTER_IMAGE_URL: string = '../../../resources/base/media/ic_hour_pointer.png';
  /**
   * 分钟指针图片的URL。
   */
  static readonly MINUTE_POINTER_IMAGE_URL: string = '../../../resources/base/media/ic_minute_pointer.png';
  /**
   * 秒钟指针图片的URL。
   */
  static readonly SECOND_POINTER_IMAGE_URL: string = '../../../resources/base/media/ic_second_pointer.png';
  /**
   * 时钟盘图片的URL。
   */
  static readonly CLOCK_PAN_IMAGE_URL: string = '../../../resources/base/media/ic_clock_pan.png';
  /**
   * 重复类型分组。
   */
  static readonly REPEAT_TYPE_GROUP: string = 'repeatTypeGroup';
}
