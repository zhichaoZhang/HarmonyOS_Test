import DayDataItem from '../../viewmodel/alarm_clock/DayDataItem';
export class AlarmClockConstant {
  /**
   * Main page times list.
   */
  static readonly TIMES: number[] = [3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 1, 2];
  /**
   * Default single digit max.
   */
  static readonly DEFAULT_SINGLE_DIGIT_MAX: number = 9;
  /**
   * Default horizontal angle.
   */
  static readonly DEFAULT_HORIZONTAL_ANGLE: number = 180;
  /**
   * Default one second ms.
   */
  static readonly DEFAULT_ONE_SECOND_MS: number = 1000;
  /**
   * Default zeroing.
   */
  static readonly DEFAULT_ZEROING: string = '0';
  /**
   * Default string morning.
   */
  static readonly DEFAULT_STRING_MORNING: string = '上午';
  /**
   * Default string afternoon.
   */
  static readonly DEFAULT_STRING_AFTERNOON: string = '下午';
  /**
   * Default string alarm name.
   */
  static readonly DEFAULT_STRING_ALARM: string = '闹钟';
  /**
   * Default string quotation.
   */
  static readonly DEFAULT_STRING_NULL: string = '';
  /**
   * Default string colon.
   */
  static readonly DEFAULT_STRING_COLON: string = ':';
  /**
   * Default clock time font size unit.
   */
  static readonly CLOCK_TIME_FONT_SIZE_UNIT: string = 'px';
  /**
   * Hour pointer image url.
   */
  static readonly HOUR_POINTER_IMAGE_URL: string = '../../../resources/base/media/ic_hour_pointer.png';
  /**
   * Minute pointer image url.
   */
  static readonly MINUTE_POINTER_IMAGE_URL: string = '../../../resources/base/media/ic_minute_pointer.png';
  /**
   * Second pointer image url.
   */
  static readonly SECOND_POINTER_IMAGE_URL: string = '../../../resources/base/media/ic_second_pointer.png';
  /**
   * Clock pan image url.
   */
  static readonly CLOCK_PAN_IMAGE_URL: string = '../../../resources/base/media/ic_clock_pan.png';

  /**
   * detail page day data.
   */
  static readonly DAY_DATA: DayDataItem[] = [
    { timeType: 0, delSelect: 0, data: ['上午', '下午'] } as DayDataItem,
    { timeType: 1, delSelect: 0, data:
    [
      '01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12'
    ]
    } as DayDataItem,
    { timeType: 2, delSelect: 0, data:
    [
      '01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12',
      '13', '14', '15', '16', '17', '18', '19', '20', '21', '22', '23', '24',
      '25', '26', '27', '28', '29', '30', '31', '32', '33', '34', '35', '36',
      '37', '38', '39', '40', '41', '42', '43', '44', '45', '46', '47', '48',
      '49', '50', '51', '52', '53', '54', '55', '56', '57', '58', '59', '00',
    ]
    } as DayDataItem
  ];
  /**
   * week day data.
   */
  static readonly WEEKDAY_DATA: number[] = [1, 2, 3, 4, 5, 6, 7];
  /**
   * ring duration list data.
   */
  static readonly RING_DURATION: number[] = [1, 5, 10, 15, 20, 30];
  /**
   * default string minute.
   */
  static readonly DEFAULT_STRING_MINUTE: string = '分钟';
  /**
   * default string group name.
   */
  static readonly DEFAULT_STRING_GROUP_NAME: string = 'radioGroup';
  /**
   * default string provider key.
   */
  static readonly DEFAULT_PROVIDER_KEY: string = 'alarmItemProvide';
  /**
   * default string repeat.
   */
  static readonly DEFAULT_STRING_REPEAT: string = '重复';
  /**
   * default string alarm name.
   */
  static readonly DEFAULT_STRING_ALARM_NAME: string = '闹钟名';
  /**
   * default string interval.
   */
  static readonly DEFAULT_STRING_INTERVAL: string = '再响间隔';
  /**
   * default string duration.
   */
  static readonly DEFAULT_STRING_DURATION: string = '闹铃时长';
  /**
   * default string times.
   */
  static readonly DEFAULT_STRING_TIMES: string = '次';

  /**
   * database preference id.
   */
  static readonly PREFERENCE_ID = 'storageId';
  /**
   * database alarm data key.
   */
  static readonly ALARM_KEY = 'alarmData';
  /**
   * common full length
   */
  static readonly FULL_LENGTH: string = '100%';
  /**
   * default string space.
   */
  static readonly DEFAULT_STRING_SPACE: string = ' ';
  /**
   * default string comma.
   */
  static readonly DEFAULT_STRING_COMMA: string = '，';
  /**
   * default string no repeat.
   */
  static readonly DEFAULT_STRING_NO_REPEAT: string = '不重复';
  /**
   * default number negative.
   */
  static readonly DEFAULT_NUMBER_NEGATIVE: number = -1;
  /**
   * default layout weight.
   */
  static readonly DEFAULT_LAYOUT_WEIGHT: number = 1;
  /**
   * default single.
   */
  static readonly DEFAULT_SINGLE: number = 1;
  /**
   * default double.
   */
  static readonly DEFAULT_DOUBLE: number = 2;
  /**
   * default data picker hour selection.
   */
  static readonly DEFAULT_DATA_PICKER_HOUR_SELECTION: number = 2;
  /**
   * default total minute.
   */
  static readonly DEFAULT_TOTAL_MINUTE: number = 60;
  /**
   * default string monday.
   */
  static readonly DEFAULT_STRING_MONDAY: string = '周一';
  /**
   * default string tuesday.
   */
  static readonly DEFAULT_STRING_TUESDAY: string = '周二';
  /**
   * default string wednesday.
   */
  static readonly DEFAULT_STRING_WEDNESDAY: string = '周三';
  /**
   * default string thursday.
   */
  static readonly DEFAULT_STRING_THURSDAY: string = '周四';
  /**
   * default string friday.
   */
  static readonly DEFAULT_STRING_FRIDAY: string = '周五';
  /**
   * default string saturday.
   */
  static readonly DEFAULT_STRING_SATURDAY: string = '周六';
  /**
   * default string sunday.
   */
  static readonly DEFAULT_STRING_SUNDAY: string = '周日';
  /**
   * default number moment.
   */
  static readonly DEFAULT_NUMBER_MOMENT: number = 3;
  /**
   * default interval step.
   */
  static readonly DEFAULT_INTERVAL_STEP: number = 5;
  /**
   * default common degree
   */
  static readonly DEFAULT_COMMON_DEGREE: number = 6;
  /**
   * default pointer width.
   */
  static readonly DEFAULT_POINTER_WIDTH: number = 10;
  /**
   * default total hour.
   */
  static readonly DEFAULT_TOTAL_HOUR: number = 12;
  /**
   * default interval time max.
   */
  static readonly DEFAULT_INTERVAL_TIME_MAX: number = 10;
  /**
   * default interval minute max.
   */
  static readonly DEFAULT_INTERVAL_MINUTE_MAX: number = 30;
}

/**
 * Default number for a week.
 */
export enum WeekDays {
  DEFAULT_NUMBER_MONDAY = 1,
  DEFAULT_NUMBER_TUESDAY = 2,
  DEFAULT_NUMBER_WEDNESDAY = 3,
  DEFAULT_NUMBER_THURSDAY = 4,
  DEFAULT_NUMBER_FRIDAY = 5,
  DEFAULT_NUMBER_SATURDAY = 6,
  DEFAULT_NUMBER_SUNDAY = 7
}