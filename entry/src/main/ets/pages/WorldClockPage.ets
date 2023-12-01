import { CommonConstants } from '../common/constant/CommonConstants'
import WorldClockConstants from '../common/constant/WorldClockConstants'
import ClockArea from '../view/WorldClock/ClockArea'
import HeaderContainer from '../view/HeaderContainer'
import { formatDateTime, getChineseWeekday } from '../common/util/DateUtils'
import DimensionUtil from '../common/util/DimensionUtils'
import router from '@ohos.router'
import WorldClockViewModel from '../viewmodel/WorldClockViewModel'
import CityItem from '../viewmodel/CityItem'
import CityList from '../view/WorldClock/CityList'

@Component
export default struct WorldClockPage {
  @Provide now: number = new Date().getTime()
  @Provide isEdit: boolean = false
  private timeInterval: number = CommonConstants.DEFAULT_NUMBER_NEGATIVE;
  private worldClockModel: WorldClockViewModel = WorldClockViewModel.instant;
  @State cityItems: Array<CityItem> = []
  @State selectedList: Array<number> = []

  aboutToAppear() {
    this.worldClockModel.queryCitiesTasker((cities: Array<CityItem>) => {
      animateTo({ duration: CommonConstants.ANIMATION_MEDIUM_DURATION }, () => {
        this.cityItems = cities;
      })
    })
    this.timeInterval = setInterval(() => {
      this.now = new Date().getTime()
    }, CommonConstants.MILLISECONDS_PER_SECOND);
  }

  aboutToDisappear() {
    clearInterval(this.timeInterval)
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        HeaderContainer({ title: WorldClockConstants.WORLD_CLOCK }) {
          Row({ space: DimensionUtil.getVp($r('app.float.new_alarm_button_size')) }) {
            Button() {
              Image($r('app.media.ic_add')).objectFit(ImageFit.Fill)
            }
            .stateEffect(false)
            .backgroundColor($r('app.color.trans_parent'))
            .width(DimensionUtil.getVp($r('app.float.new_alarm_button_size')))
            .height(DimensionUtil.getVp($r('app.float.new_alarm_button_size')))
            .onClick(() => {
              router.pushUrl({ url: 'pages/AddCityPage' });
            })

            Button() {
              Image($r('app.media.ic_edit')).objectFit(ImageFit.Fill)
            }
            .stateEffect(false)
            .backgroundColor($r('app.color.trans_parent'))
            .width(DimensionUtil.getVp($r('app.float.new_alarm_button_size')))
            .height(DimensionUtil.getVp($r('app.float.new_alarm_button_size')))
            .onClick(() => {
              this.isEdit = !this.isEdit
            })
          }
        }

        ClockArea({ now: $now })
        Text("中国标准时间")
          .fontColor($r('app.color.grey_text'))
          .fontSize($r('app.float.font_size_S'))
        Text(`${formatDateTime(this.now, "MM月dd日")}  星期${getChineseWeekday(new Date(this.now).getDay())}`)
          .fontSize($r('app.float.font_size_M'))

        CityList({ cityItems: $cityItems, selectedList: $selectedList })
      }.width(CommonConstants.FULL_LENGTH)
      .height(CommonConstants.FULL_LENGTH)

      if (this.isEdit) {
        Button('删除')
          .onClick(() => {
            this.worldClockModel.batchRemoveCities(this.selectedList)
            this.isEdit = false
          })
          .width(CommonConstants.FULL_LENGTH)
          .margin({
            left: DimensionUtil.getVp($r('app.float.title_horizon_margin')),
            right: DimensionUtil.getVp($r('app.float.title_horizon_margin'))
          })
      }
    }.backgroundColor($r('app.color.grey_light'))

  }
}