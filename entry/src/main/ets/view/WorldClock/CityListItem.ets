import { CommonConstants } from '../../common/constant/CommonConstants';
import WorldClockConstants from '../../common/constant/WorldClockConstants';
import { formatDateTime, plusOffset } from '../../common/util/DateUtils';
import DimensionUtil from '../../common/util/DimensionUtils';
import CityItem from '../../viewmodel/CityItem';

@Component
export default struct CityListItem {
  private cityItem: CityItem = new CityItem();
  @Consume isEdit: boolean
  @Consume now: number
  private onSelected: () => void
  private onCanceled: () => void

  build() {
    Row() {
      Column({ space: DimensionUtil.getVp($r('app.float.alarm_list_space')) }) {
        // 城市名称和国家
        Text(`${this.cityItem.city},${this.cityItem.country}`)
          .fontSize($r('app.float.font_size_MP'))

        // 显示城市的 GMT 偏移
        Text(`GMT${CityItem.formatUTCOffset(this.cityItem.UTCOffset)}`)
          .fontColor($r('app.color.grey_text'))
          .fontSize($r('app.float.font_size_S'))

      }
      .alignItems(HorizontalAlign.Start)

      if (this.isEdit) {
        // 编辑模式下显示复选框
        Checkbox()
          .width(DimensionUtil.getVp($r('app.float.alarms_item_toggle_height')))
          .height(DimensionUtil.getVp($r('app.float.alarms_item_toggle_height')))
          .onChange((value) => {
            if (value) {
              this.onSelected()
            } else {
              this.onCanceled()
            }
          })
      } else {
        // 正常模式下显示城市当前时间
        Text(`${formatDateTime(plusOffset(this.now, this.cityItem.UTCOffset), WorldClockConstants.TIMER_FORMAT)}`)
          .fontSize($r('app.float.font_size_MP'))
      }
    }
    .padding({
      left: DimensionUtil.getVp($r('app.float.alarm_list_content_distance')),
      right: DimensionUtil.getVp($r('app.float.alarm_list_content_distance'))
    })
    .justifyContent(FlexAlign.SpaceBetween)
    .width(CommonConstants.FULL_LENGTH)
    .height(DimensionUtil.getVp($r('app.float.alarms_item_height')))
    .backgroundColor(Color.White)
    .borderRadius(DimensionUtil.getVp($r('app.float.alarms_item_radius')))
  }
}
