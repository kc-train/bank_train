# ActionNode = React.createClass
#   render: ->
#     <div className='action-node' style="left:#{@props.posx};top:#{@props.posy};">
#     </div>


class Action
  constructor: (@data)->

  is_start: ->
    @data['是否起始步骤'] is '是'

  children_names: ->
    (@data['后续操作步骤']||[]).map (x)->
      x['后续步骤名称']

  name_eq: (name)->
    @name() is name

  name: ->
    @data['步骤名称']


class FlowRender
  constructor: (@$elm)->
    @render_data()

  render_data: ->
    jQuery.getJSON '/demo/yaml_sample.json', (data)=>
      # 排列步骤节点
      @render_actions data['操作步骤']

  render_actions: (_actions)->
    @actions = for _action in _actions
      new Action _action

    @deeps = {}

    start_action = (@actions.filter (x)->
      x.is_start())[0]

    # 第一次遍历
    @_r1(start_action, 0)

    $canvas = jQuery('<canvas>')
      .attr 'width', 1000
      .attr 'height', 1000
      .appendTo @$elm.find('.actions-panel')

    @curve_arrow = new CurveArrow $canvas[0]

    # 第二次遍历，画箭头
    @_r2(start_action)

  _r1: (action, deep)->
    action.children = for name in action.children_names()
      (@actions.filter (x)->
        x.name_eq name)[0]

    @deeps[deep] ||= []
    @deeps[deep].push action
    posx = @deeps[deep].length - 1

    posy = deep

    left = posx * 170
    top = posy * 100

    action.cx = left + 60
    action.cy = top + 25

    action.$node = jQuery('<div>')
      .addClass('action-node')
      .css
        left: left
        top: top
      .text action.name()
      .appendTo @$elm.find('.actions-panel')

    for child in action.children
      @_r1 child, deep + 1

  _r2: (action)->
    # 画箭头
    for child in action.children
      @curve_arrow.draw action.cx, action.cy, child.cx, child.cy, '#666666'
      @_r2 child


# jQuery(document).on 'page:change', ->
#   if jQuery('.yaml-sample').length
#     new FlowRender jQuery('.yaml-sample')