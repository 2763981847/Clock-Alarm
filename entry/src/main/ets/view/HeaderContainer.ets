// 导入常用模块和工具
import { CommonConstants } from '../common/constant/CommonConstants';
import DimensionUtil from '../common/util/DimensionUtils';

// 定义 HeaderContainer 组件
@Component
export default struct HeaderContainer {
  // 定义标题，标题可以是字符串或资源
  private title: string | Resource

  // 自定义组件闭包
  @BuilderParam closer?: () => void = () => null

  // 定义组件的渲染函数
  build() {
    Row() {
      // 创建文本组件，显示标题，标题以竖线字符开头
      Text('| ' + this.title)
        // 设置文本的水平对齐方式为开始
        .textAlign(TextAlign.Start)
          // 设置文本的字体大小，使用 DimensionUtil.getFp 获取尺寸
        .fontSize(DimensionUtil.getFp($r('app.float.title_font_size')))
          // 设置文本的字体颜色为灰色
        .fontColor($r('app.color.grey_divider'))
          // 设置文本的字体粗细为粗体
        .fontWeight(FontWeight.Bold)

      // 放置组件闭包
      this.closer()
    }
    // 设置整个容器的内容水平对齐方式为居中
    .justifyContent(FlexAlign.SpaceBetween)
    // 设置整个容器的内边距
    .padding({
      left: DimensionUtil.getVp($r('app.float.title_horizon_margin')),
      right: DimensionUtil.getVp($r('app.float.title_horizon_margin'))
    })
    // 设置整个容器的高度和宽度，使用 CommonConstants.FULL_LENGTH 表示铺满整个屏幕
    .height(DimensionUtil.getVp($r("app.float.page_header_height")))
    .width(CommonConstants.FULL_LENGTH)
  }
}
