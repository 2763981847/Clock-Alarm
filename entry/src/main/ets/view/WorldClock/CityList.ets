import { CommonConstants } from '../../common/constant/CommonConstants'
import DimensionUtil from '../../common/util/DimensionUtils'
import CityItem from '../../viewmodel/CityItem'
import CityListItem from './CityListItem'

@Component
export default struct CityList {
  @Link cityItems: Array<CityItem>
  @Consume isEdit: boolean
  @Consume now: number
  @Link selectedList: Array<number>

  build() {
    List({ space: DimensionUtil.getVp($r('app.float.alarm_list_space')) }) {
      ForEach(this.cityItems, (cityItem: CityItem, index) => {
        ListItem() {
          CityListItem({ cityItem: cityItem,
            onSelected: () => this.selectedList.push(index),
            onCanceled: () => this.selectedList.splice(this.selectedList.indexOf(index)) })
        }.transition({ type: TransitionType.All, opacity: 0, scale: { x: 0, y: 0 } })
      }, (cityItem) => JSON.stringify(cityItem))
    }
    .padding({
      left: DimensionUtil.getVp($r('app.float.alarm_list_content_distance')),
      right: DimensionUtil.getVp($r('app.float.alarm_list_content_distance'))
    })
    .width(CommonConstants.FULL_LENGTH)
    .height(CommonConstants.FULL_LENGTH)

  }
}
