###
  FrontEndCourseWare 前端课件
    RoleLane 角色泳道
      ActionNode 操作步骤节点
      ActionNode
    RoleLane 
###

ActionNode = React.createClass
  render: ->
    pos = @props.action.pos()

    <div className='action-node' style={{left: "#{pos.left}px", top: "#{pos.top}px"}}>
      <div className='name'>{@props.action.name()}</div>
    </div>

RoleLane = React.createClass
  render: ->
    <div className='role-lane' data-role={@props.role}>
      <div className='lane-header'>角色：{@props.role}</div>
      <div className='lane-nodes' ref='nodes_panel'>
        {
          for action in @props.actions
            @maxtop ||= 0
            @maxleft ||= 0
            pos = action.pos()
            @maxtop = Math.max @maxtop, pos.top
            @maxleft = Math.max @maxleft, pos.left

            <ActionNode action={action} key={action.name()} />
        }
      </div>
    </div>

  componentDidMount: ->
    # 修正 role panel 的宽高
    height = @maxtop + 50 + 30
    width = @maxleft + 120 + 30
    $panel = jQuery @refs.nodes_panel.getDOMNode()
    $panel.css
      width: width
      height: height


FrontEndCourseWare = React.createClass
  render: ->
    <div className='front-end-course-ware'>
      {
        for role, actions of @state.roles
          <RoleLane role={role} actions={actions} key={role} />
      }
    </div>

  getInitialState: ->
    roles: []
    actions: []

  componentDidMount: ->
    jQuery.getJSON @props.dataurl, (data)=>
      @dp = new DataParser data
      @state.roles = @dp.get_roles()
      @setState @state

  componentDidUpdate: ->
    # 画箭头
    role_pos = {}

    for role, actions of @state.roles
      $lane = jQuery(".role-lane[data-role=#{role}] .lane-nodes")
      role_pos[role] = $lane.position()

    # 第二次遍历，画箭头
    @dp.draw_arrow(role_pos)


class DataParser
  constructor: (@data)->
    # 整理数据
    @tidy_data()

  tidy_data: ->
    @roles = {}
    @actions = for _action in @data['操作步骤']
      action = new Action _action
      role = action.role()
      @roles[role] ||= []
      @roles[role].push action
      action

    # 递归遍历，计算深度
    @deeps = {}
    for role, actions of @roles
      @deeps[role] = {}

    @_r1_deep @start_action(), 0

  _r1_deep: (action, deep)->
    deep_role = @deeps[action.role()]
    deep_role[deep] ||= []
    deep_role[deep].push action
    action.deep = deep

    action.posx = deep_role[deep].length - 1
    action.posy = deep

    action.children = for name in action.children_names()
      child = (@actions.filter (x)-> x.name_eq name)[0]
      @_r1_deep child, deep + 1
      child

  draw_arrow: (role_pos)->
    $cwel = jQuery('.front-end-course-ware')
    height = $cwel.height() - 50
    width = $cwel.width()

    $canvas = jQuery('<canvas>')
      .attr 'width', width
      .attr 'height', height
      .prependTo $cwel

    @curve_arrow = new CurveArrow $canvas[0]

    @_r2 @start_action(), role_pos

  _r2: (action, role_pos)->
    # 画箭头
    for child in action.children
      x0 = action.pos().left + 60
      y0 = action.pos().top + 25
      x1 = child.pos().left + 60
      y1 = child.pos().top + 25

      action_offset = role_pos[action.role()]
      child_offset = role_pos[child.role()]

      x0 += action_offset.left
      # y0 += action_offset.top
      x1 += child_offset.left
      # y1 += child_offset.top

      @curve_arrow.draw x0, y0, x1, y1, '#999999'
      @_r2 child, role_pos

  get_actions: ->
    @actions

  get_roles: ->
    @roles

  start_action: ->
    (@actions.filter (x)-> x.is_start())[0]



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

  role: ->
    @data['操作者']

  pos: ->
    @offx = 30
    @offy = 30

    {
      left: @posx * 150 + @offx
      top: @posy * 80 + @offy
    }


jQuery(document).on 'page:change', ->
  if jQuery('.yaml-sample').length
    dataurl = jQuery('.yaml-sample').data('url')
    React.render <FrontEndCourseWare dataurl={dataurl} />, jQuery('.yaml-sample')[0]