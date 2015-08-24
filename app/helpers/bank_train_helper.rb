module BankTrainHelper
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
end