jQuery(document).on 'lily:addable-items-inputer-item-render', (evt, data)->
  $item = data.item
  $item.find('.input-group-addon').text data.idx
