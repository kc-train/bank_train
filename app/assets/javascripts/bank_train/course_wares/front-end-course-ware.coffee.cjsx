###
  FrontEndCourseWare 前端课件
    RoleLane 角色泳道
      ActionNode 操作步骤节点
      ActionNode
    RoleLane 
###

ActionNode = React.createClass
  render: ->
    <div className='action-node' style={{left: "#{@props.left}px", top: "#{@props.top}px"}}>
      <div className='name'>{@props.action.name()}</div>
    </div>

RoleLane = React.createClass
  render: ->
    <div className='role-lane'>
      <div className='lane-header'>角色：{@props.role}</div>
      <div className='lane-nodes'>
        {
          for action in @props.actions
            <ActionNode action={action} left={0} top={0} key={action.name()} />
        }
      </div>
    </div>

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
      dp = new DataParser data
      @state.roles = dp.get_roles()
      @setState @state


class DataParser
  constructor: (@data)->

  get_actions: ->
    @actions ||= (=>
      for _action in @data['操作步骤']
        new Action _action
    )()

  get_roles: ->
    @roles ||= (=>
      roles = {}
      for action in @get_actions()
        role = action.role()
        roles[role] ||= []
        roles[role].push action
      roles
    )()

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

jQuery(document).on 'page:change', ->
  if jQuery('.yaml-sample').length
    dataurl = jQuery('.yaml-sample').data('url')
    React.render <FrontEndCourseWare dataurl={dataurl} />, jQuery('.yaml-sample')[0]