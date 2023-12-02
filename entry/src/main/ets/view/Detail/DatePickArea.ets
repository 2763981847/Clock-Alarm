import { DetailConstants } from '../../common/constant/DetailConstants';
import { CommonConstants } from '../../common/constant/CommonConstants';
import DimensionUtil from '../../common/util/DimensionUtils';
import DayDataItem from '../../viewmodel/DayDataItem';

@Component
export default struct DatePickArea {
  build() {
    Stack({ alignContent: Alignment.Center }) {
      Row() {
        // 遍历日期数据
        ForEach(DetailConstants.DAY_DATA, (item: DayDataItem) => {
          // 创建文本选择器
          TextPicker({ range: item.data, selected: item.delSelect })
            .layoutWeight(CommonConstants.DEFAULT_LAYOUT_WEIGHT)
            .backgroundColor($r('app.color.grey_light'))
            .onChange((_value: string, index: number) => {
              item.delSelect = index; // 更新选择的日期索引
            })
        }, (item: DayDataItem) => JSON.stringify(item))
      }
    }
    .height(DimensionUtil.getVp($r('app.float.date_picker_height')))
    .padding({
      left: DimensionUtil.getVp($r('app.float.date_picker_padding_horizon')),
      right: DimensionUtil.getVp($r('app.float.date_picker_padding_horizon'))
    })
  }
}
