class WizardPage
  constructor: (@$elm)->
    @bind_events()

  bind_events: ->
    @$elm.on 'click', '.input-group.search a.btn', =>
      that.$elm.find('.step.s1').removeClass('active').addClass('done')
      that.$elm.find('.step.s2').removeClass('active').addClass('done')
      that.$elm.find('.step.s3').addClass('active')

      that.$elm.find('.block[data-step=1]').hide(400)
      that.$elm.find('.block[data-step=2]').hide(400)
      that.$elm.find('.block[data-step=3]').show(400)

    that = this
    @$elm.on 'click', '.post .pbox', ->
      that.$elm.find('.step.s1').removeClass('active').addClass('done')
      that.$elm.find('.step.s2').addClass('active')

      that.$elm.find('.block[data-step=1]').hide(400)
      that.$elm.find('.block[data-step=2]').show(400)

      levels = jQuery(this).data('levels')
      for level in levels
        console.log ".level[data-id=#{level}]"
        that.$elm.find(".level[data-id=#{level}]").addClass('active')

    @$elm.on 'click', '.level', ->
      that.$elm.find('.step.s2').removeClass('active').addClass('done')
      that.$elm.find('.step.s3').addClass('active')

      that.$elm.find('.block[data-step=2]').hide(400)
      that.$elm.find('.block[data-step=3]').show(400)


jQuery(document).on 'page:change', ->
  if jQuery('.demo-wizard').length
    new WizardPage jQuery('.demo-wizard')