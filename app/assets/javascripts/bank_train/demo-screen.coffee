class window.OperationScreen
  constructor: (@name, @text)->
    @$elm = jQuery(".#{@name}")

    lines = @text.split("\n")

    @header_lines = lines[0...4]
    @main_lines = lines[4...-4]
    @footer_lines = lines[-4...-1]

  set_raw: ->
    jQuery('<h3>').text('原始字符串')
      .appendTo @$elm
    jQuery('<pre>')
      .text @text
      .appendTo @$elm

  set_header_raw: ->
    jQuery('<h3>').text('头部')
      .appendTo @$elm
    jQuery('<pre>')
      .text @header_lines.join("\n")
      .appendTo @$elm

  set_main_raw: ->
    jQuery('<h3>').text('主体')
      .appendTo @$elm
    jQuery('<pre>')
      .text @main_lines.join("\n")
      .appendTo @$elm

  set_footer_raw: ->
    jQuery('<h3>').text('脚部')
      .appendTo @$elm
    jQuery('<pre>')
      .text @footer_lines.join("\n")
      .appendTo @$elm

  get_screen: ->
    jQuery('<div>').addClass('demo-screen')
      # .prependTo @$elm

  get_screen_header: ->
    jQuery """
      <div class='demo-screen-header'>
        <div class='jgno'>机构码：</div>
        <div class='gyno'>柜员号：</div>
        <div class='title'>新疆农村信用社核心业务系统</div>
        <div class='ywname'>活期存款开户</div>
        <div class='date'>
          <span>日期：</span>
          <span>2005-08-08</span>
        </div>
        <div class='time'>
          <span>时间：</span>
          <span>08:08:08AM</span>
        </div>
      </div>
    """

  get_screen_footer: ->
    jQuery """
      <div class='demo-screen-footer'>
        <div class='t key'>DEL</div>
        <div class='t tip'>退出</div>
        <div class='t key'>-</div>
        <div class='t tip'>浏览消息</div>
        <div class='t key'>↑</div>
        <div class='t key'>↓</div>
        <div class='t key'>←</div>
        <div class='t key'>→</div>
        <div class='t key'>HOME</div>
        <div class='t key'>END</div>
        <div class='t key'>PAGEUP</div>
        <div class='t key'>PAGEDOWN</div>
        <div class='t key'>←┘</div>
        <div class='t tip'>菜单码：</div>
      </div>
    """

  get_screen_main: ->
    jQuery """
      <div class='demo-screen-main'>
      </div>
    """

  get_html: ->
    # @set_raw()
    # @set_header_raw()
    # @set_main_raw()
    # @set_footer_raw()

    $screen = @get_screen()
    $header = @get_screen_header()
    $header.appendTo $screen

    $main = @get_screen_main()
    $main.appendTo $screen

    $footer = @get_screen_footer()
    $footer.appendTo $screen

    # for line in @main_lines
    #   @set_inputs(line, $main)

    ms = new MainScreen(@main_lines)
    ms.render_to $main

    $screen.appendTo @$elm


class MainScreen
  constructor: (@raw_lines)->
    @lines = for raw_line in @raw_lines
      new MainScreenLine raw_line

  render_to: ($elm)->
    for line in @lines
      line.render_to $elm


class MainScreenLine
  constructor: (@raw_line)->

  render_to: ($screen)->
    $line = jQuery('<div>').addClass('line')
      .appendTo $screen

    if @raw_line.match /│\s+│/
      $line.addClass 'empty'
      return
    
    str = @raw_line.replace(/│/g, '')
    match = str.match /([^\[\]\s][^\[\]]+\[\s+\]!?)/g
    for field in match
      new MainScreenField(field).render_to $line

    $line.find('.field').each ->
      jQuery(this)
        # .css 'width', "#{100/match.length}%"
        .css 'width', '50%'

class MainScreenField
  constructor: (@raw_field)->

  render_to: ($line)->
    $field = jQuery('<div>').addClass('field')
      .appendTo $line

    match = @raw_field.match /(.+)(\[\s+\]\!?)/
    label = match[1].replace(/\s/g, '').replace(/[\:\：]/, '')
    ipt = match[2]
    ipt_space_count = ipt.match(/(\s+)/)[1].length

    # label_width = 12 * 4 # 1, 2, 3, 4
    # label_width = 12 * 6 if label.length > 4 # 5, 6
    # label_width = 12 * 8 if label.length > 6 # 7, 8
    # label_width = 12 * label.length if label.length > 8
    label_width = 12 * label.length
    $label = jQuery('<label>').text label
      .css
        'width': label_width
      .appendTo $field

    ipt_width = ipt_space_count * 10
    max_ipt_width = 300 - label_width - 20 - 30
    # width = Math.min ipt_width, max_ipt_width
    width = max_ipt_width

    if ipt.indexOf('!') > -1
      $input = jQuery('<select>')
        .append jQuery('<option>').text '...'
    else
      $input = jQuery('<input>')

    $input
      .css
        'width': width
      .appendTo $field

    $question = jQuery('<span>')
      .addClass 'label-question'
      .html "<span class='glyphicon glyphicon-question-sign'></span>"
      .appendTo $field