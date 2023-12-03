import { CommonConstants } from '../../../common/constant/CommonConstants';
import { DetailConstants } from '../../../common/constant/DetailConstants';
import AlarmItem, { RepeatType } from '../../../viewmodel/AlarmItem';
import DetailModel from '../../../viewmodel/DetailViewModel';
import CommonDialog from './CommonDialog';
import DataTypeUtils from '../../../common/util/DataTypeUtils';
import DimensionUtil from '../../../common/util/DimensionUtils';
import { AlarmClockConstants } from '../../../common/constant/AlarmClockConstants';
import { getChineseWeekday } from '../../../common/util/DateUtils';

@CustomDialog
export default struct RepeatDialog {
  // 使用 DetailConstants.DEFAULT_PROVIDER_KEY 提供的 AlarmItem
  @Consume(DetailConstants.DEFAULT_PROVIDER_KEY) alarmItem: AlarmItem;
  // 存储选择的重复天数
  @State selects: Array<number> = new Array();
  // 存储选择的重复类型
  @State repeatType: RepeatType = RepeatType.NoRepeat;
  // 弹窗控制器
  controller: CustomDialogController = new CustomDialogController({
    builder: RepeatDialog(),
    autoCancel: true
  });
  // 存储重复类型的键名
  private repeatKeys: Array<string> = [];

  // 在弹窗出现前准备数据
  aboutToAppear() {
    this.repeatType = this.alarmItem.repeatType;
    this.selects = DataTypeUtils.deepCopy(this.alarmItem.repeatDays);
    for (let repeatTypeKey in RepeatType) {
      this.repeatKeys.push(repeatTypeKey);
    }
  }

  // 根据重复类型设置选择的重复天数
  setSelectsByRepeatType(repeatType: RepeatType) {
    if (repeatType === RepeatType.NoRepeat) {
      this.selects = [];
    } else if (repeatType === RepeatType.Everyday) {
      this.selects = DetailConstants.WEEKDAY_DATA;
    } else if (repeatType === RepeatType.DoubleRest) {
      this.selects = [1, 2, 3, 4, 5];
    } else if (repeatType === RepeatType.SingleRest) {
      this.selects = [1, 2, 3, 4, 5, 6];
    } else {
      this.selects = this.selects;
    }
  }

  // 构建组件
  build() {
    Column() {
      CommonDialog({
        title: $r('app.string.repeat_name'), // 设置弹窗标题
        controller: this.controller,
        // 确认按钮点击时的回调
        onConfirm: () => {
          if (this.selects.length === 0 && this.repeatType === RepeatType.Custom) {
            this.repeatType = RepeatType.NoRepeat;
          }
          this.alarmItem.repeatType = this.repeatType; // 更新 AlarmItem 的重复类型
          this.setSelectsByRepeatType(this.repeatType); // 根据重复类型设置选择的重复天数
          this.selects = DataTypeUtils.deepCopy(this.selects).sort() // 对选择的重复天数进行排序
          this.alarmItem.repeatDays = this.selects; // 更新 AlarmItem 的重复天数
        }
      }) {
        Column() {

          ForEach(this.repeatKeys, (repeatType: string) => {
            Row() {
              Text(RepeatType[repeatType]) // 显示重复类型的名称
                .fontSize($r('app.float.font_size_M'))
              Radio({ value: repeatType, group: AlarmClockConstants.REPEAT_TYPE_GROUP })
                .checked(RepeatType[repeatType] === this.repeatType) // 根据选择状态更新 Radio 组件
                .width(DimensionUtil.getVp($r('app.float.alarms_item_toggle_height')))
                .height(DimensionUtil.getVp($r('app.float.alarms_item_toggle_height')))
                .onChange((isChecked: boolean) => {
                  if (isChecked) {
                    this.repeatType = RepeatType[repeatType]; // 更新选择的重复类型
                  }
                })
            }.justifyContent(FlexAlign.SpaceBetween)
            .width(CommonConstants.FULL_LENGTH)
          }, repeatType => repeatType)

          Column({ space: DimensionUtil.getVp($r('app.float.alarm_list_space')) }) {
            Divider()
              .color($r('app.color.grey_text'))
              .strokeWidth(1)
              .margin({
                top: DimensionUtil.getVp($r('app.float.delete_button_margin_bottom')),
                bottom: DimensionUtil.getVp($r('app.float.delete_button_margin_bottom'))
              })
            Text("自定义提醒周期")
              .fontColor($r('app.color.grey_text'))
              .fontSize($r('app.float.font_size_S'))

            Row() {
              ForEach(DetailConstants.WEEKDAY_DATA, (item: number) => {
                Button() {
                  Text(getChineseWeekday(item % 7))
                    .fontSize($r('app.float.font_size_M'))
                    .fontColor(this.selects.includes(item) ? Color.Red : Color.Black)
                }
                .borderRadius(DimensionUtil.getVp($r('app.float.weekday_selected_item_radius')))
                .type(ButtonType.Circle)
                .stateEffect(false)
                .backgroundColor(this.selects.includes(item) ? $r('app.color.red_light') : $r('app.color.grey_with_opacity'))
                .onClick(() => {
                  if (!this.selects.includes(item)) {
                    this.selects.push(item);
                    console.log("selects" + this.selects)
                  } else {
                    let index = this.selects.indexOf(item);
                    this.selects.splice(index, CommonConstants.DEFAULT_SINGLE);
                  }
                })
              })
            }.width(CommonConstants.FULL_LENGTH)
            .justifyContent(FlexAlign.SpaceBetween)
          }.visibility(this.repeatType === RepeatType.Custom ? Visibility.Visible : Visibility.Hidden)

        }
      }
    }
  }
}
