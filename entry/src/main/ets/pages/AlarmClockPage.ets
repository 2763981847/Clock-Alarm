import router from '@ohos.router';
import { CommonConstants } from '../common/constant/CommonConstants';
import AlarmItem from '../viewmodel/AlarmItem';
import { AlarmClockConstants } from '../common/constant/AlarmClockConstants';
import AlarmClockViewModel from '../viewmodel/AlarmClockViewModel';
import AlarmList from '../view/AlarmClock/AlarmList';
import DimensionUtil from '../common/util/DimensionUtils';
import HeaderContainer from '../view/HeaderContainer';
import { findNearestAlarmTime } from '../common/util/AlarmClockUtils';
import NearestAlarmTime from '../view/AlarmClock/NearestAlarmTime';


/**
 * 闹钟页面。
 */
@Component
export default struct AlarmClockPage {
  // 用于定时刷新最近的闹钟时间的定时器ID
  private intervalId: number = CommonConstants.DEFAULT_NUMBER_NEGATIVE;

  // 闹钟模型，用于管理和查询闹钟数据
  private alarmClockModel: AlarmClockViewModel = AlarmClockViewModel.instant;

  // 存储闹钟列表数据的状态
  @State alarmItems: Array<AlarmItem> = new Array();

  // 存储最近的闹钟时间的状态
  @State nearestAlarmTime: {
    days: number,
    hours: number,
    minutes: number
  } = null;

  // 在页面即将显示时触发的生命周期函数
  aboutToAppear() {
    // 查询闹钟数据
    this.alarmClockModel.queryAlarmsTasker((alarms: Array<AlarmItem>) => {
      this.alarmClockModel.disableExpiredReminders();
      // 将查询到的数据赋值给 alarmItems 和 nearestAlarmTime
      animateTo({ duration: CommonConstants.ANIMATION_MEDIUM_DURATION }, () => {
        this.alarmItems = alarms;
        this.nearestAlarmTime = findNearestAlarmTime(this.alarmItems);

        // 如果最近的闹钟时间为0，则默认设置为1分钟
        if (this.nearestAlarmTime && this.nearestAlarmTime.days === 0 && this.nearestAlarmTime.hours === 0 && this.nearestAlarmTime.minutes === 0) {
          this.nearestAlarmTime.minutes = 1;
        }
      });
    });

    // 设置定时器，定时刷新最近的闹钟时间并禁用过期的闹钟
    this.intervalId = setInterval(() => {
      this.nearestAlarmTime = findNearestAlarmTime(this.alarmItems);

      // 如果最近的闹钟时间为0，则默认设置为1分钟
      if (this.nearestAlarmTime && this.nearestAlarmTime.days === 0 && this.nearestAlarmTime.hours === 0 && this.nearestAlarmTime.minutes === 0) {
        this.nearestAlarmTime.minutes = 1;
      }

      this.alarmClockModel.disableExpiredReminders();

    }, AlarmClockConstants.DEFAULT_ONE_SECOND_MS);
  }

  // 在页面即将消失时触发的生命周期函数
  aboutToDisappear() {
    // 清除定时器
    clearInterval(this.intervalId);
  }

  // 构建页面内容
  build() {
    Column() {
      // 顶部容器，包括标题和添加闹钟按钮
      HeaderContainer({ title: AlarmClockConstants.DEFAULT_STRING_ALARM }) {
        // 添加闹钟按钮
        Button() {
          Image($r('app.media.ic_add')).objectFit(ImageFit.Fill);
        }
        .stateEffect(false)
        .backgroundColor($r('app.color.trans_parent'))
        .width(DimensionUtil.getVp($r('app.float.new_alarm_button_size')))
        .height(DimensionUtil.getVp($r('app.float.new_alarm_button_size')))
        .onClick(() => {
          // 点击按钮跳转到添加闹钟页面
          router.pushUrl({ url: 'pages/DetailPage' });
        });
      }

      // 显示最近的闹钟时间的组件
      NearestAlarmTime({ nearestAlarmTime: $nearestAlarmTime });

      // 闹钟列表组件，显示用户添加的闹钟项
      AlarmList({ alarmItems: $alarmItems });
    }
    .width(CommonConstants.FULL_LENGTH)
    .height(CommonConstants.FULL_LENGTH)
    .backgroundColor($r('app.color.grey_light'));
  }
}
