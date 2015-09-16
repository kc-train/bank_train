class CalendarPage
  constructor: (@$elm)->
    @bind_events()
    @set_current_display_month_day new Date()

  # 设置当前显示月份，并更新表头和表体
  # 传入的值可以是该月的任意一天，日期并不重要
  set_current_display_month_day: (any_month_day)->
    @current_display_month_day = any_month_day
    @current_display_year = any_month_day.getFullYear()
    @current_display_month = any_month_day.getMonth()
    @fill_header()
    @fill_body()

  is_today: (day)->
    today = new Date()
    return day.getFullYear() is today.getFullYear() and 
           day.getMonth() is today.getMonth() and 
           day.getDate() is today.getDate()

  # 判断某个日期是否属于当前显示月份
  is_day_of_current_month: (day)->
    return day.getFullYear() is @current_display_year and 
           day.getMonth() is @current_display_month

  get_first_day: ->
    return new Date(@current_display_year, @current_display_month, 1)

  get_last_day: ->
    return new Date(@current_display_year, @current_display_month + 1, 0)

  get_delta_date: (day, delta_days)->
    new Date(day.getTime() + delta_days * 24 * 60 * 60 * 1000)

  bind_events: ->
    # 上一月
    @$elm.on 'click', '.to-prev-month', => @to_prev_month()

    # 下一月
    @$elm.on 'click', '.to-next-month', => @to_next_month()

  to_prev_month: ->
    @set_current_display_month_day(@get_delta_date @get_first_day(), - 1)

  to_next_month: ->
    @set_current_display_month_day(@get_delta_date @get_last_day(), + 1)

  fill_header: ->
    # 根据 @set_current_display_month_day 的值填充 header
    @$elm.find('.current-month').text "#{@current_display_year}年#{@current_display_month + 1}月"

  fill_body: ->
    # 根据 @set_current_display_month_day 的值填充 body
    first_day = @get_first_day()
    first_weekday = first_day.getDay()

    # first_weekday
    # 1 2 3 4 5 6 0
    # 一 二 三 四 五 六 日
    # 0 1 2 3 4 5 6
    
    first_day_idx = (first_weekday - 1 + 7) % 7

    for idx in [0..41]
      date = @get_delta_date first_day, idx - first_day_idx
      $td = @$elm.find("tbody td[data-idx=#{idx}]")
      $td.text date.getDate()
      @set_td_class $td, date

  set_td_class: ($td, date)->
    $td.removeClass('weekend other-month-day today')
    return $td.addClass 'today' if @is_today date
    return $td.addClass 'other-month-day' if not @is_day_of_current_month date
    return $td.addClass 'weekend' if date.getDay() is 6 or date.getDay() is 0 



jQuery(document).on 'page:change', ->
  if jQuery('.page-calendar').length
    new CalendarPage jQuery('.page-calendar')