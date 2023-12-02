import { CommonConstants } from '../../../common/constant/CommonConstants';
import DimensionUtil from '../../../common/util/DimensionUtils';

@Component
export default struct CommonDialog {
  // 弹窗标题
  private title?: string | Resource;
  // 弹窗控制器
  private controller?: CustomDialogController;
  // 确认按钮点击回调函数
  private onConfirm: () => void = () => {
  };
  // 自定义组件闭包
  @BuilderParam closer: () => void = () => {
  };

  // 构建组件
  build() {
    Column() {
      // 弹窗标题
      Text(this.title)
        .fontSize(DimensionUtil.getFp($r('app.float.common_dialog_title_font_size')))
        .width(CommonConstants.FULL_LENGTH)
        .fontColor($r('app.color.grey_divider'))
        .margin({
          bottom: DimensionUtil.getVp($r('app.float.common_dialog_title_margin_vertical'))
        })

      // 自定义组件闭包
      this.closer()

      Row() {
        // 取消按钮
        Button($r('app.string.cancel')).actionBtnStyle().onClick(() => {
          if (!this.controller) {
            return;
          }
          this.controller.close();
        })

        // 确认按钮
        if (this.onConfirm) {
          Button($r('app.string.confirm')).actionBtnStyle().onClick(() => {
            this.onConfirm();
            if (!this.controller) {
              return;
            }
            this.controller.close();
          })
        }
      }
      .margin({ top: DimensionUtil.getVp($r('app.float.common_dialog_margin_vertical')) })
    }
    .width(CommonConstants.FULL_LENGTH)
    .padding(DimensionUtil.getVp($r('app.float.common_dialog_padding')))
    .justifyContent(FlexAlign.Center)
  }
}

// 扩展 Button 样式
@Extend(Button) function actionBtnStyle() {
  .fontSize(DimensionUtil.getFp($r('app.float.common_dialog_button_font_size')))
  .height(DimensionUtil.getVp($r('app.float.common_dialog_button_height')))
  .layoutWeight(CommonConstants.DEFAULT_LAYOUT_WEIGHT)
  .fontColor($r('app.color.green_light'))
  .backgroundColor($r('app.color.trans_parent'))
}
