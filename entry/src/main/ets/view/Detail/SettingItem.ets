import { CommonConstants } from '../../common/constant/CommonConstants';
import { AlarmSettingTypes } from '../../common/constant/AlarmSettingTypes';
import AlarmSettingItem from '../../viewmodel/AlarmSettingItem';
import DimensionUtil from '../../common/util/DimensionUtils';
import IntervalDialog from './dialog/IntervalDialog';
import DurationDialog from './dialog/DurationDialog';
import RenameDialog from './dialog/RenameDialog';
import RepeatDialog from './dialog/RepeatDialog';

@Component
export default struct SettingItem {
  @Link settingInfo: Array<AlarmSettingItem>;
  repeatDialogController: CustomDialogController = new CustomDialogController({
    builder: RepeatDialog(),
    autoCancel: true
  });
  reNameDialogController: CustomDialogController = new CustomDialogController({
    builder: RenameDialog(),
    autoCancel: true
  });
  durationDialogController: CustomDialogController = new CustomDialogController({
    builder: DurationDialog(),
    autoCancel: true
  });
  intervalDialogController: CustomDialogController = new CustomDialogController({
    builder: IntervalDialog(),
    autoCancel: true
  });

  // 打开设置对话框的函数
  private showSettingDialog(sType: AlarmSettingTypes) {
    switch (sType) {
      case AlarmSettingTypes.REPEAT:
        this.repeatDialogController.open();
        break;
      case AlarmSettingTypes.ALARM_NAME:
        this.reNameDialogController.open();
        break;
      case AlarmSettingTypes.RING_DURATION:
        this.durationDialogController.open();
        break;
      case AlarmSettingTypes.INTERVAL:
        this.intervalDialogController.open();
        break;
      default:
        break
    }
  }

  build() {
    Column() {
      // 遍历设置信息
      ForEach(this.settingInfo, (item: AlarmSettingItem, index: number | undefined) => {
        Divider()
          .visibility(index === 0 ? Visibility.Hidden : Visibility.Visible)
          .opacity($r('app.float.divider_opacity'))
          .color($r('app.color.grey_divider'))
          .lineCap(LineCapStyle.Round)
          .margin({
            left: DimensionUtil.getVp($r('app.float.setting_item_divider_margin_horizon')),
            right: DimensionUtil.getVp($r('app.float.setting_item_divider_margin_horizon'))
          })
        Row() {
          // 显示设置项的标题
          Text(item.title)
            .fontSize(DimensionUtil.getFp($r('app.float.setting_item_name_font_size')))
            .fontWeight(FontWeight.Regular)
            .fontColor($r('app.color.grey_divider'))
            .layoutWeight(CommonConstants.DEFAULT_LAYOUT_WEIGHT)
          // 显示设置项的内容
          Text(item.content)
            .fontSize(DimensionUtil.getFp($r('app.float.setting_item_content_font_size')))
            .fontWeight(FontWeight.Normal)
            .fontColor($r('app.color.grey_divider'))
            .opacity($r('app.float.setting_item_content_font_opacity'))
          // 显示右箭头图标
          Image($r('app.media.ic_right'))
            .width(DimensionUtil.getVp($r('app.float.setting_item_image_width')))
            .height(DimensionUtil.getVp($r('app.float.setting_item_image_height')))
            .objectFit(ImageFit.Fill)
            .margin({
              left: DimensionUtil.getVp($r('app.float.setting_item_image_margin_horizon'))
            })
        }
        .height(DimensionUtil.getVp($r('app.float.setting_item_height')))
        .alignItems(VerticalAlign.Center)
        .padding({
          left: DimensionUtil.getVp($r('app.float.setting_item_interval')),
          right: DimensionUtil.getVp($r('app.float.setting_item_interval'))
        })
        .onClick(() => {
          // 点击时打开相应的设置对话框
          this.showSettingDialog(item.sType);
        })
      }, (item: AlarmSettingItem, index: number | undefined) => JSON.stringify(item) + index)
    }
    .margin({
      bottom: DimensionUtil.getVp($r('app.float.setting_item_interval')),
      left: DimensionUtil.getVp($r('app.float.setting_item_interval')),
      right: DimensionUtil.getVp($r('app.float.setting_item_interval'))
    })
    .borderRadius(DimensionUtil.getVp($r('app.float.setting_item_border_radius')))
    .backgroundColor(Color.White)
  }
}
