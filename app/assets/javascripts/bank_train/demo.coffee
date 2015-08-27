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

jQuery(document).on 'page:change', ->
  new BankTrainSlider jQuery('.demo-page')

jQuery(document).on 'page:change', ->
  jQuery.getJSON '/demo/screens.json', (data)->
    # input1 = new OperationScreen 'input1', data['input1']
    # input1.get_html()

    # input2 = new OperationScreen 'input2', data['input2']
    # input2.get_html()

    for key, value of data
      try
        input = new OperationScreen key, value
        input.get_html()
      catch e