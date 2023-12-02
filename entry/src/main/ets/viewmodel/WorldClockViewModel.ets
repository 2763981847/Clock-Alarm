import { CommonConstants } from '../common/constant/CommonConstants';
import DataTypeUtils from '../common/util/DataTypeUtils';
import { GlobalContext } from '../common/util/GlobalContext';
import PreferencesHandler from '../model/database/PreferencesHandler';
import PreferencesListener from '../model/database/PreferencesListener';
import CityItem from './CityItem';

/**
 * 世界时钟视图模型。
 */
export default class WorldClockViewModel {
  static instant: WorldClockViewModel = new WorldClockViewModel();
  static readonly mainCities: Array<CityItem> = [
  // 主要城市的列表
  // 例如：{ city: "巴黎", country: "法国", UTCOffset: 1 }
  // ...
  ];
  public cities: Array<CityItem>;

  private constructor() {
    this.cities = []
  }

  /**
   * 查询城市任务数据库表。
   *
   * @param callback (cities: Array<CityItem>) => void
   */
  private queryDatabaseCities(callback: (cities: Array<CityItem>) => void) {
    let preference = GlobalContext.getContext().getObject('preference') as PreferencesHandler;
    preference.get(CommonConstants.CITY_KEY).then((data: string) => {
      if (!DataTypeUtils.isNull(data)) {
        this.cities = JSON.parse(data);
        callback(this.cities);
      }
    })
  }

  /**
   * 刷新城市任务。
   *
   * @param callback (cities: Array<CityItem>) => void
   */
  public queryCitiesTasker(callback: (cities: Array<CityItem>) => void) {
    let that = this;
    that.queryDatabaseCities(callback);
    let preference = GlobalContext.getContext().getObject('preference') as PreferencesHandler;
    preference.addPreferencesListener({
      onDataChanged() {
        that.queryDatabaseCities(callback);
      }
    } as PreferencesListener)
  }

  /**
   * 将城市保存到数据库中。
   *
   * @param cities 要保存的城市数组，默认为当前城市列表
   */
  public setCitiesToDatabase(cities: Array<CityItem> = this.cities) {
    let preference = GlobalContext.getContext().getObject('preference') as PreferencesHandler;
    preference.set(CommonConstants.CITY_KEY, JSON.stringify(cities));
  }

  /**
   * 添加城市到城市列表中。
   *
   * @param city 要添加的城市
   */
  public addCity(city: CityItem) {
    this.cities.push(city)
    this.setCitiesToDatabase()
  }

  /**
   * 从城市列表中移除指定索引的城市。
   *
   * @param indexToRemove 要移除的城市索引
   */
  public removeCity(indexToRemove: number) {
    this.cities.splice(indexToRemove, 1)
    this.setCitiesToDatabase()
  }

  /**
   * 批量从城市列表中移除指定索引的城市。
   *
   * @param indexesToRemove 要移除的城市索引数组
   */
  public batchRemoveCities(indexesToRemove: Array<number>) {
    indexesToRemove.forEach(index => this.cities.splice(index, 1))
    this.setCitiesToDatabase()
  }
}
