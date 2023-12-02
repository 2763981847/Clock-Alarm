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
    {
      city: "巴黎", country: "法国", UTCOffset: 1
    },
    {
      city: "纽约", country: "美国", UTCOffset: -5
    },
    {
      city: "东京", country: "日本", UTCOffset: 9
    },
    {
      city: "伦敦", country: "英国", UTCOffset: 0
    },
    {
      city: "悉尼", country: "澳大利亚", UTCOffset: 11
    },
    {
      city: "莫斯科", country: "俄罗斯", UTCOffset: 3
    },
    {
      city: "里约热内卢", country: "巴西", UTCOffset: -3
    },
    {
      city: "开普敦", country: "南非", UTCOffset: 2
    },
    {
      city: "墨西哥城", country: "墨西哥", UTCOffset: -6
    },
    {
      city: "新德里", country: "印度", UTCOffset: 5.5
    },
    {
      city: "柏林", country: "德国", UTCOffset: 1
    },
    {
      city: "布宜诺斯艾利斯", country: "阿根廷", UTCOffset: -3
    },
    {
      city: "首尔", country: "韩国", UTCOffset: 9
    },
    {
      city: "马德里", country: "西班牙", UTCOffset: 1
    },
    {
      city: "多伦多", country: "加拿大", UTCOffset: -5
    },
    {
      city: "开罗", country: "埃及", UTCOffset: 2
    },
    {
      city: "曼谷", country: "泰国", UTCOffset: 7
    },
    {
      city: "雅加达", country: "印度尼西亚", UTCOffset: 7
    },
    {
      city: "伊斯坦布尔", country: "土耳其", UTCOffset: 3
    },
    {
      city: "迪拜", country: "阿联酋", UTCOffset: 4
    }
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
