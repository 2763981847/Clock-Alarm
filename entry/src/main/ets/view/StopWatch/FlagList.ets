import { CommonConstants } from '../../common/constant/CommonConstants'
import { StopWatchConstants } from '../../common/constant/StopWatchConstants'
import DimensionUtil from '../../common/util/DimensionUtils'
import { formatMilliseconds } from '../../common/util/StopWatchUtils'

@Component
export default struct FlagList {
  private listScroller: Scroller = new Scroller()
  @Link flags: Array<number>

  build() {
    List({ scroller: this.listScroller }) {
      // 遍历标记列表
      ForEach(this.flags, (flag: number, index: number) => {
        ListItem() {
          Row() {
            // 显示标记的索引
            Text(index.toString())
              .fontSize($r('app.float.font_size_MP'))
            // 显示与上一个标记的时间差
            Text(`+${formatMilliseconds(flag - (index === 0 ? 0 : this.flags[index-1]))}`)
              .fontSize($r('app.float.font_size_MP'))
              .fontColor($r('app.color.grey_text'))
            // 显示标记的时间
            Text(formatMilliseconds(flag))
              .fontSize($r('app.float.font_size_MP'))
          }.width(CommonConstants.FULL_LENGTH)
          .height(StopWatchConstants.FLAG_ITEM_HEIGHT)
          .justifyContent(FlexAlign.SpaceBetween)
        }
        .transition({
          type: TransitionType.Insert,
          // 设置插入时的动画效果，向下平移
          translate: { y: StopWatchConstants.FLAG_ITEM_HEIGHT }
        })

      })
    }.width(CommonConstants.FULL_LENGTH)
    .height(CommonConstants.FULL_LENGTH)
    .padding({
      left: DimensionUtil.getVp($r('app.float.title_horizon_margin')),
      right: DimensionUtil.getVp($r('app.float.title_horizon_margin'))
    })
  }
}
