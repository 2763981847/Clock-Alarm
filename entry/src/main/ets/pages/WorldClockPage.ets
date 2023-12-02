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
  // 提供当前时间的状态变量
  @Provide now: number = new Date().getTime();

  // 提供编辑模式是否激活的状态变量
  @Provide isEdit: boolean = false;

  // 用于存储更新当前时间的计时器id的变量
  private timeInterval: number = CommonConstants.DEFAULT_NUMBER_NEGATIVE;

  // 世界时钟数据管理的视图模型
  private worldClockModel: WorldClockViewModel = WorldClockViewModel.instant;

  // 用于存储城市项列表的状态变量
  @State cityItems: Array<CityItem> = [];

  // 用于存储选定城市项列表的状态变量
  @State selectedList: Array<number> = [];

  // 在页面显示之前调用的方法
  aboutToAppear() {
    // 查询城市列表并更新界面
    this.worldClockModel.queryCitiesTasker((cities: Array<CityItem>) => {
      animateTo({ duration: CommonConstants.ANIMATION_MEDIUM_DURATION }, () => {
        this.cityItems = cities;
      });
    });

    // 设置定时器以更新当前时间
    this.timeInterval = setInterval(() => {
      this.now = new Date().getTime();
    }, CommonConstants.MILLISECONDS_PER_SECOND);
  }

  // 在页面即将消失之前调用的方法
  aboutToDisappear() {
    // 清除定时器以停止更新当前时间
    clearInterval(this.timeInterval);
  }

  // 构建页面内容
  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        HeaderContainer({ title: WorldClockConstants.WORLD_CLOCK }) {
          Row({ space: DimensionUtil.getVp($r('app.float.new_alarm_button_size')) }) {
            // 添加新城市的按钮
            Button() {
              Image($r('app.media.ic_add')).objectFit(ImageFit.Fill);
            }
            .stateEffect(false)
            .backgroundColor($r('app.color.trans_parent'))
            .width(DimensionUtil.getVp($r('app.float.new_alarm_button_size')))
            .height(DimensionUtil.getVp($r('app.float.new_alarm_button_size')))
            .onClick(() => {
              router.pushUrl({ url: 'pages/AddCityPage' });
            });

            // 切换编辑模式的按钮
            Button() {
              Image($r('app.media.ic_edit')).objectFit(ImageFit.Fill);
            }
            .stateEffect(false)
            .backgroundColor($r('app.color.trans_parent'))
            .width(DimensionUtil.getVp($r('app.float.new_alarm_button_size')))
            .height(DimensionUtil.getVp($r('app.float.new_alarm_button_size')))
            .onClick(() => {
              this.selectedList = [];
              this.isEdit = !this.isEdit;
            });
          }
        }

        Scroll(new Scroller()) {
          Column({ space: DimensionUtil.getVp($r('app.float.alarm_list_space')) }) {
            ClockArea({ now: $now }); // 显示当前时间

            // 以中文显示日期和星期几
            Text("中国标准时间")
              .fontColor($r('app.color.grey_text'))
              .fontSize($r('app.float.font_size_S'));
            Text(`${formatDateTime(this.now, "MM月dd日")}  星期${getChineseWeekday(new Date(this.now).getDay())}`)
              .fontSize($r('app.float.font_size_M'));

            // 渲染城市项列表
            CityList({ cityItems: $cityItems, selectedList: $selectedList });
          }.width(CommonConstants.FULL_LENGTH)
          .justifyContent(FlexAlign.Start);
        }.width(CommonConstants.FULL_LENGTH)
        .scrollBar(BarState.Off)
        .edgeEffect(EdgeEffect.Spring);
      }.width(CommonConstants.FULL_LENGTH)
      .height(CommonConstants.FULL_LENGTH)
      .justifyContent(FlexAlign.Start);

      // 如果编辑模式激活，显示删除按钮
      if (this.isEdit) {
        Button() {
          Column({ space: DimensionUtil.getVp($r('app.float.alarm_list_space')) }) {
            // 删除按钮图标
            Image($r('app.media.ic_delete'))
              .objectFit(ImageFit.Contain)
              .width($r('app.float.font_size_L'));
            Text("删除")
              .fontSize($r('app.float.font_size_SM'));
          }.justifyContent(FlexAlign.Center);
        }
        .onClick(() => {
          // 批量删除选定的城市
          this.worldClockModel.batchRemoveCities(this.selectedList);
          this.selectedList = [];
          this.isEdit = false;
        })
        .backgroundColor(Color.White)
        .borderRadius(DimensionUtil.getVp($r('app.float.alarms_item_radius')))
        .aspectRatio(5)
        .width(CommonConstants.FULL_LENGTH)
        .margin({
          left: DimensionUtil.getVp($r('app.float.title_horizon_margin')),
          right: DimensionUtil.getVp($r('app.float.title_horizon_margin'))
        })
        .offset({ y: -DimensionUtil.getVp($r('app.float.title_horizon_margin')) });
      }
    }.backgroundColor($r('app.color.grey_light'))
    .height(CommonConstants.FULL_LENGTH)
    .width(CommonConstants.FULL_LENGTH);
  }
}
