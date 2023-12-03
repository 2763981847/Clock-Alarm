// 引入常量和工具类
import { CommonConstants } from '../../../common/constant/CommonConstants';
import { DetailConstants } from '../../../common/constant/DetailConstants';
import AlarmItem from '../../../viewmodel/AlarmItem'; // 闹钟项的ViewModel
import CommonDialog from './CommonDialog'; // 通用对话框组件
import DimensionUtil from '../../../common/util/DimensionUtils'; // 尺寸工具类

// 定义一个自定义的对话框组件，用于设置闹钟的间隔时间
@CustomDialog
export default struct IntervalDialog {
  // 使用DetailConstants中的默认提供器键来消费AlarmItem
  @Consume(DetailConstants.DEFAULT_PROVIDER_KEY) alarmItem: AlarmItem;

  // 定义状态变量：间隔分钟和间隔次数
  @State intervalMinuteSelect: number = 0;
  @State intervalTimesSelect: number = 0;

  // 对话框控制器
  controller?: CustomDialogController;

  // 在对话框即将出现时的操作
  aboutToAppear(): void {
    // 初始化状态变量为AlarmItem中的值
    this.intervalMinuteSelect = this.alarmItem.intervalMinute;
    this.intervalTimesSelect = this.alarmItem.intervalTimes;
  }

  // 构建对话框的内容
  build() {
    // 使用Flex布局
    Flex() {
      // 如果间隔时间或间隔次数大于0
      if ((this.intervalTimesSelect | this.intervalMinuteSelect) > 0) {
        // 创建一个通用对话框
        CommonDialog({
          title: $r('app.string.ring_interval'), // 设置标题
          controller: this.controller, // 设置控制器
          // 确认按钮的回调函数
          onConfirm: () => {
            // 更新AlarmItem的间隔分钟和次数
            this.alarmItem.intervalMinute = Number(this.intervalMinuteSelect.toFixed(0))
            this.alarmItem.intervalTimes = Number(this.intervalTimesSelect.toFixed(0))
          }
        }) {
          // 创建两个间隔设置项
          this.IntervalItem($r('app.string.ring_interval_content'), 0) // 间隔分钟设置项
          // 分割线
          Divider()
            .opacity($r('app.float.divider_opacity')) // 设置透明度
            .color($r('app.color.grey_divider')) // 设置颜色
            .lineCap(LineCapStyle.Round) // 设置线帽样式
          // 间隔次数设置项
          this.IntervalItem($r('app.string.ring_times_content'), CommonConstants.DEFAULT_SINGLE)
        }
      }
    }
  }

  // 构建间隔项的方法，包含文本和滑动条
  @Builder IntervalItem(title: string | Resource, intervalType: number) {
    // 显示标题文本
    Text(title)
      .fontSize(DimensionUtil.getFp($r('app.float.interval_dialog_title_font_size')))
      .width(CommonConstants.FULL_LENGTH)
      .textAlign(TextAlign.Start)
      .margin({
        top: DimensionUtil.getVp($r('app.float.interval_dialog_title_margin_top'))
      })
    // 使用行布局
    Row() {
      // 滑动条组件
      Slider({
        value: (intervalType === 0 ? this.intervalMinuteSelect : this.intervalTimesSelect), // 根据类型设置当前值
        min: (intervalType === 0 ? CommonConstants.DEFAULT_INTERVAL_STEP : 0), // 设置最小值
        max: (intervalType === 0
          ? CommonConstants.DEFAULT_INTERVAL_MINUTE_MAX
          : CommonConstants.DEFAULT_INTERVAL_TIME_MAX), // 设置最大值
        step: (intervalType === 0 ? CommonConstants.DEFAULT_INTERVAL_STEP : CommonConstants.DEFAULT_DOUBLE), // 设置步长
        style: SliderStyle.OutSet // 设置样式
      })
        .blockColor(Color.Blue) // 设置滑块颜色
        .trackColor(Color.Gray) // 设置轨道颜色
        .selectedColor(Color.Blue) // 设置选择颜色
        .showSteps(true) // 显示步进
        .showTips(false) // 不显示提示
          // 当滑动条值改变时的回调
        .onChange((value: number) => {
          // 根据类型更新状态变量
          if (intervalType === 0) {
            this.intervalMinuteSelect = value;
          } else {
            this.intervalTimesSelect = value;
          }
        })
      // 显示当前选定值的文本
      Text((intervalType === 0 ? this.intervalMinuteSelect : this.intervalTimesSelect).toFixed(0))
        .fontSize(DimensionUtil.getFp($r('app.float.interval_dialog_result_font_size')))
    }
    .width(CommonConstants.FULL_LENGTH) // 设置宽度
  }
}
