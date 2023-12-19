/**
 * 列表懒加载
 */

@Component
@Entry
struct LazyList {
  private data: MyDataSource = new MyDataSource()

  build() {
    Scroll() {
      List() {
        LazyForEach(this.data, (item: string, index: number) => {
          ListItem() {
            Row() {
              Text('item value: ' + item + (index + 1))
                .fontSize(20)
                .margin(10)
            }
          }
        })
      }
      .cachedCount(3) //屏幕缓存数
      .width('100%')
      .height('100%')
    }
    .backgroundColor(Color.Pink)
  }
}

/**
 * 实现IDataSource接口为List提供懒加载数据
 */
class BasicDataSource implements IDataSource {
  private listeners: DataChangeListener[] = []

  unregisterDataChangeListener(listener: DataChangeListener): void {
    const pos = this.listeners.indexOf(listener)
    if (pos >= 0) {
      console.info('remove listener')
      this.listeners.splice(pos, 1)
    }
  }

  registerDataChangeListener(listener: DataChangeListener): void {
    if (this.listeners.indexOf(listener) < 0) {
      console.info('add listener')
      this.listeners.push(listener)
    }
  }

  getData(index: number) {
    return undefined
  }

  totalCount(): number {
    return 0
  }

  notifyDataReload(): void {
    this.listeners.forEach(listener => {
      listener.onDataReloaded()
    })
  }

  notifyDataAdd(index: number): void {
    this.listeners.forEach(listener => {
      listener.onDataAdd(index)
    })
  }

  notifyDataChanged(index: number): void {
    this.listeners.forEach(listener => {
      listener.onDataChange(index)
    })
  }

  notifyDataDelete(index: number): void {
    this.listeners.forEach(listener => {
      listener.onDataDelete(index)
    })
  }

  notifyDataRemove(from: number, to: number): void {
    this.listeners.forEach(listener => {
      listener.onDataMove(from, to)
    })
  }
}

/**
 * 业务自定义数据源
 */
class MyDataSource extends BasicDataSource {
  private dataArray: Array<string> = new Array(200).fill('test')

  public totalCount(): number {
    return this.dataArray.length
  }

  public getData(index: number): any {
    return this.dataArray[index]
  }

  public addData(index: number, data: string): void {
    this.dataArray.splice(index, 0, data)
    this.notifyDataAdd(index)
  }

  public pushData(data: string): void {
    this.dataArray.push(data)
    this.notifyDataAdd(this.dataArray.length - 1)
  }
}