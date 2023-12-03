/**
 * 添加城市页面组件。
 */
import { CommonConstants } from '../common/constant/CommonConstants';
import DimensionUtil from '../common/util/DimensionUtils';
import BackContainer from '../view/BackContainer';
import CityItem from '../viewmodel/CityItem';
import WorldClockViewModel from '../viewmodel/WorldClockViewModel';
import promptAction from '@ohos.promptAction';
import router from '@ohos.router';

@Component
@Entry
struct AddCityPage {
  private viewModel: WorldClockViewModel = WorldClockViewModel.instant;

  /**
   * 页面过渡效果配置。
   */
  pageTransition() {
    // 定义页面进入时的效果，从底侧滑入，时长为300ms，无论页面栈发生push还是pop操作均可生效
    PageTransitionEnter({ type: RouteType.None, duration: CommonConstants.ANIMATION_SHORT_DURATION })
      .slide(SlideEffect.Bottom);
    // 定义页面退出时的效果，向底侧滑出，时长为300ms，无论页面栈发生push还是pop操作均可生效
    PageTransitionExit({ type: RouteType.None, duration: CommonConstants.ANIMATION_SHORT_DURATION })
      .slide(SlideEffect.Bottom);
  }

  /**
   * 构建页面内容。
   */
  build() {
    Column() {
      BackContainer({ header: "添加城市" });

      List({ scroller: new Scroller(), space: DimensionUtil.getVp($r('app.float.city_list_space')) }) {
        ForEach(WorldClockViewModel.mainCities, (city: CityItem) => {
          ListItem() {
            Column() {
              Text(`${city.city},${city.country}`)
                .fontSize($r('app.float.font_size_M'));

              Text(`GMT${CityItem.formatUTCOffset(city.UTCOffset)}`)
                .fontColor($r('app.color.grey_text'))
                .fontSize($r('app.float.font_size_S'));
            }
            .alignItems(HorizontalAlign.Start);
          }
          .onClick(() => {
            if (this.viewModel.cities.some(cityItem => CityItem.equals(cityItem, city))) {
              promptAction.showToast({
                message: '该城市已添加'
              });
              return;
            }
            this.viewModel.addCity(city);
            router.back();
          });
        });
      }
      .padding({
        left: DimensionUtil.getVp($r('app.float.title_horizon_margin')),
        right: DimensionUtil.getVp($r('app.float.title_horizon_margin'))
      });

    }.width(CommonConstants.FULL_LENGTH);
  }
}
