import { CommonConstants } from '../../../common/constant/CommonConstants';
import { DetailConstants } from '../../../common/constant/DetailConstants';
import AlarmItem from '../../../viewmodel/AlarmItem';
import CommonDialog from './CommonDialog';
import DimensionUtil from '../../../common/util/DimensionUtils';

@CustomDialog
export default struct DurationDialog {
  // 使用 DetailConstants.DEFAULT_PROVIDER_KEY 提供的 AlarmItem
  @Consume(DetailConstants.DEFAULT_PROVIDER_KEY) alarmItem: AlarmItem;
  // 响铃时长选项，以分钟为单位
  private durations: Array<number> = DetailConstants.RING_DURATION;
  // 弹窗控制器
  controller?: CustomDialogController;

  // 构建组件
  build() {
    Flex() {
      // 使用 CommonDialog 组件来构建通用对话框
      CommonDialog({
        title: $r('app.string.ring_duration'),
        controller: this.controller
      }) {
        // 遍历响铃时长选项
        ForEach(this.durations, (item: number) => {
          Row() {
            // 显示响铃时长和单位
            Text(item + CommonConstants.DEFAULT_STRING_SPACE + DetailConstants.DEFAULT_STRING_MINUTE)
              .layoutWeight(CommonConstants.DEFAULT_LAYOUT_WEIGHT)
              .fontColor($r('app.color.grey_divider'))
              .fontSize(DimensionUtil.getFp($r('app.float.duration_dialog_content_font_size')))

            // 创建单选按钮，用于选择响铃时长
            Radio({ value: item.toString(), group: DetailConstants.DEFAULT_STRING_GROUP_NAME })
              .checked(item === this.alarmItem.duration ? true : false)
              .height(DimensionUtil.getVp($r('app.float.duration_dialog_radio_size')))
              .width(DimensionUtil.getVp($r('app.float.duration_dialog_radio_size')))
              .onChange(() => {
                // 当单选按钮被选中时，更新 AlarmItem 的响铃时长并关闭对话框
                if (!this.controller) {
                  return;
                }
                this.controller.close();
                this.alarmItem.duration = item;
              })
          }
          .width(CommonConstants.FULL_LENGTH)
        })
      }
    }
  }
}
