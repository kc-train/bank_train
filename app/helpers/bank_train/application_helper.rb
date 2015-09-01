module BankTrain
  module ApplicationHelper

    def controller?(*controller)
      controller.include?(params[:controller])
    end

    def action?(*action)
      action.include?(params[:action])
    end

    def nav_link(path, str)
      klass = current_page?(path) ? 'active' : ''
      
      capture_haml {
        haml_tag :li, class: klass do
          haml_tag :a, str, href: path
        end
      }
    end

    def operation_tree_node(operation)
        haml_tag :li, class: :operation do
          haml_tag :div, operation.name, class: :name
          haml_tag :a,'删除', href:"/business_operations/#{operation.id}",:data=>{ :confirm => "确认删除吗？", :method => :delete}
          haml_tag :a ,'修改', href:"/business_operations/#{operation.id}/edit"
          haml_tag :ul, class: :operations do
            operation.children_operations.each do |child|
              operation_tree_node child
            end
          end
        end
    end

  end
end