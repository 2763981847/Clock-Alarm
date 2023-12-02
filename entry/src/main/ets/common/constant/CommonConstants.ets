/**
 * 通用常量类。
 */
export class CommonConstants {
  /**
   * 数据库首选项ID。
   */
  static readonly PREFERENCE_ID = 'storageId';
  /**
   * 数据库闹钟数据键。
   */
  static readonly ALARM_KEY = 'alarmData';

  /**
   * 数据库城市数据键。
   */
  static readonly CITY_KEY = 'cityData';
  /**
   * 通用的全长字符串
   */
  static readonly FULL_LENGTH: string = '100%';
  /**
   * 默认的空格字符串。
   */
  static readonly DEFAULT_STRING_SPACE: string = ' ';
  /**
   * 默认的逗号字符串。
   */
  static readonly DEFAULT_STRING_COMMA: string = '，';
  /**
   * 默认的不重复字符串。
   */
  static readonly DEFAULT_STRING_NO_REPEAT: string = '仅一次';
  /**
   * 默认的负数。
   */
  static readonly DEFAULT_NUMBER_NEGATIVE: number = -1;
  /**
   * 默认的布局权重。
   */
  static readonly DEFAULT_LAYOUT_WEIGHT: number = 1;
  /**
   * 默认的单数。
   */
  static readonly DEFAULT_SINGLE: number = 1;
  /**
   * 默认的双数。
   */
  static readonly DEFAULT_DOUBLE: number = 2;
  /**
   * 默认的数据选择器小时选择。
   */
  static readonly DEFAULT_DATA_PICKER_HOUR_SELECTION: number = 2;
  /**
   * 默认的总分钟数。
   */
  static readonly DEFAULT_TOTAL_MINUTE: number = 60;
  /**
   * 默认的星期一字符串。
   */
  static readonly DEFAULT_STRING_MONDAY: string = '周一';
  /**
   * 默认的星期二字符串。
   */
  static readonly DEFAULT_STRING_TUESDAY: string = '周二';
  /**
   * 默认的星期三字符串。
   */
  static readonly DEFAULT_STRING_WEDNESDAY: string = '周三';
  /**
   * 默认的星期四字符串。
   */
  static readonly DEFAULT_STRING_THURSDAY: string = '周四';
  /**
   * 默认的星期五字符串。
   */
  static readonly DEFAULT_STRING_FRIDAY: string = '周五';
  /**
   * 默认的星期六字符串。
   */
  static readonly DEFAULT_STRING_SATURDAY: string = '周六';
  /**
   * 默认的星期日字符串。
   */
  static readonly DEFAULT_STRING_SUNDAY: string = '周日';
  /**
   * 默认的时刻数。
   */
  static readonly DEFAULT_NUMBER_MOMENT: number = 3;
  /**
   * 默认的间隔步长。
   */
  static readonly DEFAULT_INTERVAL_STEP: number = 5;
  /**
   * 默认的通用度数。
   */
  static readonly DEFAULT_COMMON_DEGREE: number = 6;
  /**
   * 默认的指针宽度。
   */
  static readonly DEFAULT_POINTER_WIDTH: number = 10;
  /**
   * 默认的总小时数。
   */
  static readonly DEFAULT_TOTAL_HOUR: number = 12;
  /**
   * 默认的间隔时间最大值。
   */
  static readonly DEFAULT_INTERVAL_TIME_MAX: number = 10;
  /**
   * 默认的间隔分钟最大值。
   */
  static readonly DEFAULT_INTERVAL_MINUTE_MAX: number = 30;
  /**
   * 应用包名
   */
  static readonly BUNDLE_NAME: string = 'com.huawei.alarmclock';
  /**
   * Ability名称。
   */
  static readonly ABILITY_NAME: string = 'EntryAbility';
  /**
   * 动画持续时间
   */
  static readonly ANIMATION_MEDIUM_DURATION = 500
  static readonly ANIMATION_SHORT_DURATION = 300
  /**
   * 日期时间换算常量
   */
  static readonly MILLISECONDS_PER_SECOND = 1000;
  static readonly SECONDS_PER_MINUTE = 60;
  static readonly MINUTES_PER_HOUR = 60;
  static readonly HOURS_PER_DAY = 24;
  static readonly DAYS_PER_WEEK = 7;
  static readonly MILLISECONDS_PER_MINUTE = CommonConstants.MILLISECONDS_PER_SECOND * CommonConstants.SECONDS_PER_MINUTE;
  static readonly MILLISECONDS_PER_HOUR = CommonConstants.MILLISECONDS_PER_MINUTE * CommonConstants.MINUTES_PER_HOUR;
  static readonly MILLISECONDS_PER_DAY = CommonConstants.MILLISECONDS_PER_HOUR * CommonConstants.HOURS_PER_DAY;
  static readonly MILLISECONDS_PER_WEEK = CommonConstants.MILLISECONDS_PER_DAY * CommonConstants.DAYS_PER_WEEK;
}

/**
 * 星期枚举类
 */
export enum WeekDays {
  DEFAULT_NUMBER_MONDAY = 1,
  DEFAULT_NUMBER_TUESDAY = 2,
  DEFAULT_NUMBER_WEDNESDAY = 3,
  DEFAULT_NUMBER_THURSDAY = 4,
  DEFAULT_NUMBER_FRIDAY = 5,
  DEFAULT_NUMBER_SATURDAY = 6,
  DEFAULT_NUMBER_SUNDAY = 7
}
