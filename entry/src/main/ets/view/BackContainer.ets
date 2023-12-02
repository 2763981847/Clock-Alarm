// 导入路由模块和一些常用工具
import router from '@ohos.router';
import { CommonConstants } from '../common/constant/CommonConstants';
import DimensionUtil from '../common/util/DimensionUtils';

// 定义 BackContainer 组件
@Component
export default struct BackContainer {
  // 设置标题，默认值为 "app.string.new_alarm"，可以在构建时自定义
  private header: string | Resource = $r('app.string.new_alarm');

  // 设置返回按钮的图像资源，默认为 "app.media.ic_cancel"，可以在构建时自定义
  private backImgRes?: string | Resource = $r('app.media.ic_cancel');

  // 定义返回按钮的点击事件，默认为空，可以在构建时自定义
  private backFunc?: () => void;

  // 自定义组件闭包
  @BuilderParam closer?: () => void = () => null;

  // 定义组件的渲染函数
  build() {
    Row() {
      // 创建返回按钮
      Button() {
        // 设置按钮的图像，如果未设置 backImgRes，则使用默认图像 "app.media.ic_public_back"
        Image(this.backImgRes == null ? $r('app.media.ic_public_back') : this.backImgRes).objectFit(ImageFit.Fill)
      }
      // 设置按钮的背景颜色为透明
      .backgroundColor($r('app.color.trans_parent'))
      // 设置按钮的宽度和高度，使用 DimensionUtil.getVp 获取尺寸
      .width(DimensionUtil.getVp($r('app.float.title_button_size')))
      .height(DimensionUtil.getVp($r('app.float.title_button_size')))
      // 定义按钮的点击事件
      .onClick(() => {
        // 如果设置了 backFunc，执行 backFunc；否则，执行默认的路由返回操作
        this.backFunc ? this.backFunc() : router.back();
      })

      // 创建标题文本
      Text(this.header)
        // 设置文本的字体大小、行高、左边距、字体颜色、字体粗细
        .fontSize(DimensionUtil.getFp($r('app.float.detail_title_font_size')))
        .lineHeight(DimensionUtil.getVp($r('app.float.title_line_height')))
        .margin({ left: DimensionUtil.getVp($r('app.float.title_margin')) })
        .fontColor($r('app.color.grey_divider'))
        .fontWeight(FontWeight.Bold)

      // 创建一个空白组件，用于添加关闭按钮
      Blank()

      // 调用传入的组件闭包
      this.closer();
    }
    // 设置整个容器的内边距
    .padding({
      left: DimensionUtil.getVp($r('app.float.title_horizon_margin')),
      right: DimensionUtil.getVp($r('app.float.title_horizon_margin'))
    })
    // 设置整个容器的高度和宽度
    .height(DimensionUtil.getVp($r("app.float.page_header_height")))
    .width(CommonConstants.FULL_LENGTH)
  }
}
