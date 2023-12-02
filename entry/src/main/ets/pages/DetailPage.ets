import router from '@ohos.router';
import { CommonConstants } from '../common/constant/CommonConstants';
import AlarmItem, { RepeatType } from '../viewmodel/AlarmItem';
import AlarmSettingItem from '../viewmodel/AlarmSettingItem';
import { AlarmSettingTypes } from '../common/constant/AlarmSettingTypes';
import { DetailConstants } from '../common/constant/DetailConstants';
import BackContainer from '../view/BackContainer';
import DetailModel from '../viewmodel/DetailViewModel';
import DatePickArea from '../view/detail/DatePickArea';
import SettingItem from '../view/Detail/SettingItem';
import DimensionUtil from '../common/util/DimensionUtils';
import promptAction from '@ohos.promptAction';
import { findNearestAlarmTime, generateNearestAlarmTimeToast } from '../common/util/AlarmClockUtils';
/**
 * DetailPage 页面组件。
 */
@Entry
@Component
export default struct DetailPage {
  // 监听 alarmItem 属性变化，提供给子组件使用
  @Watch('onAlarmItemChange') @Provide(DetailConstants.DEFAULT_PROVIDER_KEY) alarmItem: AlarmItem = new AlarmItem();

  // 存储重复设置的数据
  @State repeatSettingArr: Array<AlarmSettingItem> = [];

  // 存储闹钟设置的数据
  @State alarmSettingInfoArr: Array<AlarmSettingItem> = [];

  // 标记是否是新建闹钟
  private isNew: boolean = true;

  // 闹钟视图模型，用于处理闹钟相关逻辑
  private viewModel: DetailModel = DetailModel.instant;

  // 生命周期函数，在页面即将显示时触发
  aboutToAppear() {
    // 获取路由参数，判断是否为编辑已有闹钟
    let params = router.getParams() as Record<string, Object | undefined>;
    if (params !== undefined) {
      let alarmItem: AlarmItem = params.alarmItem as AlarmItem;
      if (alarmItem !== undefined) {
        this.isNew = false;
        this.alarmItem = alarmItem;
        this.viewModel.setAlarmDefaultTime(this.alarmItem);
      } else {
        this.viewModel.setAlarmDefaultTime();
      }
    } else {
      this.viewModel.setAlarmDefaultTime();
    }
    this.initData();
  }

  // 当 alarmItem 属性变化时触发，用于更新数据
  onAlarmItemChange() {
    this.initData();
  }

  // 初始化页面数据
  initData() {
    this.repeatSettingArr = [
      new AlarmSettingItem(DetailConstants.DEFAULT_STRING_REPEAT,
        this.alarmItem.repeatType,
        AlarmSettingTypes.REPEAT)
    ];
    this.alarmSettingInfoArr = [
      new AlarmSettingItem(DetailConstants.DEFAULT_STRING_ALARM_NAME, this.alarmItem.name, AlarmSettingTypes.ALARM_NAME),
      new AlarmSettingItem(DetailConstants.DEFAULT_STRING_DURATION,
        this.alarmItem.duration + DetailConstants.DEFAULT_STRING_MINUTE, AlarmSettingTypes.RING_DURATION),
      new AlarmSettingItem(DetailConstants.DEFAULT_STRING_INTERVAL, this.alarmItem.intervalMinute
      + DetailConstants.DEFAULT_STRING_MINUTE + CommonConstants.DEFAULT_STRING_COMMA
      + this.alarmItem.intervalTimes + DetailConstants.DEFAULT_STRING_TIMES, AlarmSettingTypes.INTERVAL)
    ];
  }

  // 定义页面进入和退出的过渡效果
  pageTransition() {
    // 页面进入效果
    PageTransitionEnter({ type: RouteType.None, duration: CommonConstants.ANIMATION_SHORT_DURATION })
      .slide(SlideEffect.Bottom);
    // 页面退出效果
    PageTransitionExit({ type: RouteType.None, duration: CommonConstants.ANIMATION_SHORT_DURATION })
      .slide(SlideEffect.Bottom);
  }

  // 构建页面内容
  build() {
    Column() {
      // 顶部容器，包括标题和取消/保存按钮
      BackContainer({
        header: this.isNew ? $r('app.string.new_alarm') : $r('app.string.update_alarm'),
        backImgRes: $r('app.media.ic_cancel'),
      }) {
        // 保存按钮
        Button() {
          Image($r('app.media.ic_confirm')).objectFit(ImageFit.Fill)
        }
        .backgroundColor($r('app.color.trans_parent'))
        .width(DimensionUtil.getVp($r('app.float.title_button_size')))
        .height(DimensionUtil.getVp($r('app.float.title_button_size')))
        .onClick(() => {
          // 设置闹钟状态为开启，并保存设置
          this.alarmItem.isOpen = true;
          this.viewModel.setAlarmRemind(this.alarmItem);

          // 获取下一个闹钟时间
          let nextAlarmTime = findNearestAlarmTime([this.alarmItem]);
          // 显示最近闹钟时间的提示信息
          promptAction.showToast({
            message: generateNearestAlarmTimeToast(nextAlarmTime)
          });

          // 返回上一页
          router.back();
        });
      }

      // 日期选择区域
      DatePickArea()

      // 设置项，包括重复设置和闹钟设置
      SettingItem({
        settingInfo: $repeatSettingArr
      });
      SettingItem({
        settingInfo: $alarmSettingInfoArr
      });

      // 空白区域
      Blank()

      // 删除按钮
      Button($r('app.string.delete'))
        .visibility(this.isNew ? Visibility.None : Visibility.Visible)
        .width(DimensionUtil.getVp($r('app.float.delete_button_width')))
        .height(DimensionUtil.getVp($r('app.float.delete_button_height')))
        .fontSize(DimensionUtil.getFp($r('app.float.delete_button_font_size')))
        .fontColor($r('app.color.red_light'))
        .backgroundColor($r('app.color.grey_with_opacity'))
        .borderRadius(DimensionUtil.getVp($r('app.float.delete_button_radius')))
        .margin({
          bottom: DimensionUtil.getVp($r('app.float.delete_button_margin_bottom'))
        })
        .onClick(() => {
          // 移除闹钟
          this.viewModel.removeAlarmRemind(this.alarmItem.id);
          // 返回上一页
          router.back();
        });
    }
    .backgroundColor($r('app.color.grey_light'))
    .width(CommonConstants.FULL_LENGTH)
    .height(CommonConstants.FULL_LENGTH);
  }
}
