class PostAndCategoryPage
  constructor: (@$topelm)->
    @bind_events()

  bind_events: ->
    that = this
    @$topelm.on 'click', 'a.post', ->
      that.select_post jQuery(this)

  select_post: ($post)->
    @$topelm.find('a.post').removeClass('active')
    $post.addClass('active')

    cids = $post.data('categories')

    @$topelm.find('.child-category').removeClass('active')
    @$topelm.find('.category').removeClass('active')
    @$topelm.find('.current-active').text "，当前岗位涉及 #{cids.length} 项"

    for cid in cids
      @$topelm
        .find(".child-category[data-id=#{cid}]").addClass('active')
        .closest('.category').addClass('active')


jQuery(document).on 'page:change', ->
  new PostAndCategoryPage jQuery('.bank-train-home')