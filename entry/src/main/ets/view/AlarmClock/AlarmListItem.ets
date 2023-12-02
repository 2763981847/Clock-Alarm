import AlarmClockViewModel from '../../viewmodel/AlarmClockViewModel';
import { CommonConstants } from '../../common/constant/CommonConstants';
import AlarmItem from '../../viewmodel/AlarmItem';
import DimensionUtil from '../../common/util/DimensionUtils';
import promptAction from '@ohos.promptAction';
import { findNearestAlarmTime, generateNearestAlarmTimeToast } from '../../common/util/AlarmClockUtils';

@Component
export default struct AlarmListItem {
  // 闹钟视图模型
  private mainModel: AlarmClockViewModel = AlarmClockViewModel.instant;
  // 闹钟项
  private alarmItem: AlarmItem = new AlarmItem();

  // 构建闹钟项视图
  build() {
    Row() {
      Column() {
        // 闹钟时间文本
        Text(this.mainModel.getTaskTimeContent(this.alarmItem.hour, this.alarmItem.minute))
          .CommonTextAttr(DimensionUtil.getFp($r('app.float.alarms_item_time_font_size')),
            FontWeight.Regular,
            { left: DimensionUtil.getVp($r('app.float.alarms_item_time_margin_left')) });

        // 闹钟描述文本
        Text(this.mainModel.getDescContent(this.alarmItem))
          .CommonTextAttr(DimensionUtil.getFp($r('app.float.alarms_item_dec_font_size')),
            FontWeight.Normal,
            { top: DimensionUtil.getVp($r('app.float.alarms_item_dec_margin_top')) },
            $r('app.float.alarms_item_desc_text_opacity'));
      }
      .width(CommonConstants.FULL_LENGTH)
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(CommonConstants.DEFAULT_LAYOUT_WEIGHT);

      // 开关按钮
      Toggle({ type: ToggleType.Switch, isOn: this.alarmItem.isOpen })
        .onChange((isOn: boolean) => {
          this.mainModel.openAlarm(this.alarmItem.id, isOn);
          if (isOn) {
            this.alarmItem.isOpen = true;
            let nextAlarmTime = findNearestAlarmTime([this.alarmItem]);
            promptAction.showToast({
              message: generateNearestAlarmTimeToast(nextAlarmTime)
            });
          }
        })
        .width(DimensionUtil.getVp($r('app.float.alarms_item_toggle_width')))
        .height(DimensionUtil.getVp($r('app.float.alarms_item_toggle_height')));
    }
    .padding({
      left: DimensionUtil.getVp($r('app.float.alarm_list_content_distance')),
      right: DimensionUtil.getVp($r('app.float.alarm_list_content_distance'))
    })
    .width(CommonConstants.FULL_LENGTH)
    .height(DimensionUtil.getVp($r('app.float.alarms_item_height')))
    .backgroundColor(Color.White)
    .borderRadius(DimensionUtil.getVp($r('app.float.alarms_item_radius')));
  }
}

// 扩展 Text 组件，设置通用文本属性
@Extend(Text) function CommonTextAttr(fontSize: number, fontWeight: number, margin?: Margin,
                                      opacity?: Resource) {
  .fontColor($r('app.color.grey_divider'))
  .fontSize(fontSize)
  .fontWeight(fontWeight)
  .margin(margin != undefined ? margin : 0)
  .opacity(opacity != undefined ? opacity : 1);
}
