class BankTrainSlider
  constructor: (@$elm)->
    @bind_events()

  bind_events: ->
    that = this

    # 点击顶部翻页
    @$elm.on 'click', '.page-flow .page', ->
      page_id = jQuery(this).data('num')
      that.to_page(page_id)

    # 翻前页
    @$elm.on 'click', '.prev-link .link', =>
      $page = @$elm.find(".page-flow .page.active")
      prev_page_id = $page.data('prev')[0]
      @to_page prev_page_id, 'toleft' if prev_page_id?

    # 翻后页
    @$elm.on 'click', '.next-link .link', =>
      $page = @$elm.find(".page-flow .page.active")
      next_page_id = $page.data('next')[0]
      @to_page next_page_id if next_page_id?

    # 播放 demo
    @$elm.on 'click', '.show-demo .btn.play', ->
      screen = jQuery(this).closest('.show-demo').data('screen')
      that.play_demo(screen)

    # 暂停 demo
    @$elm.on 'click', '.show-demo .btn.pause', ->
      that.pause_demo()

    jQuery(document).on 'show.bs.modal', (evt)->
      that.pause_demo()
      
      $desc = jQuery('.question-dialog').find('.desc')
      current_screen = jQuery('.demo-pager .page.active h2').html()
      
      if that.current_field_label?
        $desc.html "正在对 <b>#{current_screen}</b> 中的输入框： <b>#{that.current_field_label}</b> 提问"
      else
        $desc.html "正在对 <b>#{current_screen}</b> 提问"


  to_page: (page_id, direction = 'toright')->
    current_page_id = @$elm.find(".page-flow .page.active").data('num')
    return if page_id is current_page_id

    @$elm.find(".page-flow .page.active").removeClass 'active'
    @$elm.find(".page-flow .page[data-num=#{page_id}]").addClass 'active'

    that = this
    @$elm.find('.demo-pager .page.active')
      .css 'z-index', ''
      .animate
        'margin-left': if direction is 'toright' then '-100%' else '100%'
      , 200, ->
        jQuery(this)
          .removeClass 'active'

        that.$elm.find(".demo-pager .page[data-num=#{page_id}]")
          .addClass 'active'
          .css
            'margin-left': if direction is 'toright' then '100%' else '-100%'
            'z-index': 1
          .animate
            'margin-left': '0'
          , 200

  pause_demo: ->
    @play = false

  play_demo: (screen)->
    @play = true
    @current_idx ||= 0
    if @current_idx is 0
      jQuery('.field').removeClass('filled')
    jQuery('.screen-tip').remove()

    jQuery.getJSON '/demo/screens_input.json', (d)=>
      data = d[screen]
      console.log @current_idx
      @play_data(screen, data, @current_idx)

  play_data: (screen, d, idx)->
    data = d[idx]
    console.log data

    field = parseInt data[0]
    tip_text = data[1]
    value = data[2]

    tip_text = tip_text.split('').map (x)->
      "<span>#{x}</span>"
    $tip = jQuery('<div>').addClass('screen-tip')
      .append tip_text
    $tip.find('span').css 'visibility', 'hidden'
    
    $screen = jQuery(".dscreen.#{screen}")
    $field = $screen.find('.field').eq(field)
    @current_field_label = $field.find('label').html()
    
    left = $field.position().left
    top = $field.position().top
    left = left + $field.width() + 20

    $tip.appendTo jQuery('.demo-pager .page.active')
      .css
        'left': left
        'top': top - 20 - 5
        'opacity': 0
      .animate
        'top': top - 5
        'opacity': 1
      , 500, =>
        # setTimeout =>
        @show_tip_text $tip, =>
          console.log 111111
          if value?
            $field.addClass('filled')
            $field.find('input').val(value)
            $field.find('option').text(value)        
          
          if idx < d.length - 1
            @current_idx = @current_idx + 1
            if @play
              $tip.hide()
              @play_data(screen, d, @current_idx)
          else
            @current_idx = null
            console.log '播放完毕'
        # , 1500

  show_tip_text: ($tip, func)->
    length = $tip.find('span').length
    @_st $tip, length, 0, func

  _st: ($tip, length, idx, func)->
    $tip.find('span').eq(idx).css 'visibility', 'visible'
    if idx is length - 1
      setTimeout =>
        func()
      , 1500
    else
      setTimeout =>
        @_st $tip, length, idx + 1, func
      , 150


jQuery(document).on 'page:change', ->
  new BankTrainSlider jQuery('.demo-page')

jQuery(document).on 'page:change', ->
  jQuery.getJSON '/demo/screens.json', (data)->
    for key, value of data
      try
        input = new OperationScreen key, value
        input.get_html()
      catch e