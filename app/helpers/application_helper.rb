module ApplicationHelper
  def hide_class is_button = false
    return unless current_user
    is_button && current_user.donations == 0 || !is_button && current_user.donations > 0 ? "hide" : nil
  end
end
