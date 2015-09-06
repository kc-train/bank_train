class AddableInputer
  constructor: (config = {})->
    @template = config.template
    @items = []

  append_item: (item)->
    $item = jQuery('<div>')
      .addClass 'addable-inputer-item'
      .appendTo @$list

    $item_container = jQuery('<div>')
      .addClass 'addable-inputer-item-container'
      .appendTo $item

    item.appendTo $item_container
    jQuery('<div>')
      .addClass('btn')
      .addClass('btn-default')
      .addClass('addable-inputer-remove-btn')
      .html '删除'
      .appendTo $item
    return @

  remove_item: (idx)->
    @$list.children().eq(idx).remove()
    return @

  render_to: ($container)->
    @$elm = jQuery('<div>')
      .addClass 'addable-inputer'
      .appendTo $container

    @$list = jQuery('<div>')
      .addClass 'addable-inputer-list'
      .appendTo @$elm

    @$ops = jQuery('<div>')
      .addClass 'addable-inputer-ops'
      .appendTo @$elm

    @$add_button = jQuery('<div>')
      .addClass('btn')
      .addClass('btn-default')
      .addClass('addable-inputer-add-button')
      .html '增加'
      .appendTo @$ops

    @bind_events()

  bind_events: ->
    @$add_button.on 'click', (evt)=>
      @append_item @template.instance()

    @$elm.on 'click', '.addable-inputer-remove-btn', (evt)->
      jQuery(this).closest('.addable-inputer-item').remove()

class AddableInputerItemTemplate
  constructor: (@$dom)->

  instance: ->
    @$dom.clone()

jQuery(document).on 'page:change', ->
  if jQuery('.demo-inputer').length
    mii = new AddableInputer {
      template: new AddableInputerItemTemplate jQuery """
        <div>inputer</div>
      """
    }
    mii.render_to jQuery('.demo-inputer')
