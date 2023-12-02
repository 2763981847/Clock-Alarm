import { CommonConstants } from '../../../common/constant/CommonConstants';
import { DetailConstants } from '../../../common/constant/DetailConstants';
import AlarmItem from '../../../viewmodel/AlarmItem';
import CommonDialog from './CommonDialog';
import DimensionUtil from '../../../common/util/DimensionUtils';

@CustomDialog
export default struct RenameDialog {
  // 使用 DetailConstants.DEFAULT_PROVIDER_KEY 提供的 AlarmItem
  @Consume(DetailConstants.DEFAULT_PROVIDER_KEY) alarmItem: AlarmItem;
  // 存储输入的名称
  private name: string = '';
  // 弹窗控制器
  controller: CustomDialogController = new CustomDialogController({
    builder: RenameDialog(),
    autoCancel: true
  });

  // 构建组件
  build() {
    Flex() {
      CommonDialog({
        title: $r('app.string.alarm_name'), // 设置弹窗标题
        controller: this.controller,
        // 确认按钮点击时的回调
        onConfirm: () => {
          this.alarmItem.name = this.name; // 更新 AlarmItem 的名称
        }
      }) {
        TextArea({ text: this.alarmItem.name }) // 显示当前名称
          .width(CommonConstants.FULL_LENGTH)
          .margin({ bottom: DimensionUtil.getVp($r('app.float.rename_dialog_text_margin_bottom')) })
          .onChange((value: string) => {
            this.name = value; // 当名称发生变化时，更新 name 变量
          });

        Divider()
          .opacity($r('app.float.divider_opacity'))
          .color($r('app.color.grey_divider'))
          .lineCap(LineCapStyle.Round);
      }
    }
  }
}
