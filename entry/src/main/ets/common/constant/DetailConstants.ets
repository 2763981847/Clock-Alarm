/**
 * 详细页面常量描述。
 */
import DayDataItem from '../../viewmodel/DayDataItem';

export class DetailConstants {
  /**
   * 详细页面的日期数据。
   */
  static readonly DAY_DATA: DayDataItem[] = [

    { timeType: 0, delSelect: 0, data:
    [
      '00', '01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12',
      '13', '14', '15', '16', '17', '18', '19', '20', '21', '22', '23'
    ]
    } as DayDataItem,
    { timeType: 1, delSelect: 0, data:
    [
      '00', '01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12',
      '13', '14', '15', '16', '17', '18', '19', '20', '21', '22', '23', '24',
      '25', '26', '27', '28', '29', '30', '31', '32', '33', '34', '35', '36',
      '37', '38', '39', '40', '41', '42', '43', '44', '45', '46', '47', '48',
      '49', '50', '51', '52', '53', '54', '55', '56', '57', '58', '59',
    ]
    } as DayDataItem
  ];
  /**
   * 星期日期数据。
   */
  static readonly WEEKDAY_DATA: number[] = [1, 2, 3, 4, 5, 6, 7];
  /**
   * 铃声时长列表数据。
   */
  static readonly RING_DURATION: number[] = [1, 5, 10, 15, 20, 30];
  /**
   * 默认的分钟字符串。
   */
  static readonly DEFAULT_STRING_MINUTE: string = '分钟';
  /**
   * 默认的单选框组名称字符串。
   */
  static readonly DEFAULT_STRING_GROUP_NAME: string = 'radioGroup';
  /**
   * 默认的提供者键字符串。
   */
  static readonly DEFAULT_PROVIDER_KEY: string = 'alarmItemProvide';
  /**
   * 默认的重复字符串。
   */
  static readonly DEFAULT_STRING_REPEAT: string = '重复';
  /**
   * 默认的闹钟名称字符串。
   */
  static readonly DEFAULT_STRING_ALARM_NAME: string = '闹钟名';
  /**
   * 默认的再响间隔字符串。
   */
  static readonly DEFAULT_STRING_INTERVAL: string = '再响间隔';
  /**
   * 默认的闹铃时长字符串。
   */
  static readonly DEFAULT_STRING_DURATION: string = '闹铃时长';
  /**
   * 默认的次数字符串。
   */
  static readonly DEFAULT_STRING_TIMES: string = '次';
}
