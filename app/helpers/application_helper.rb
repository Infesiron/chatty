module ApplicationHelper
  def human_boolean(boolean)
    boolean ? "Yes" : "No"
  end

  def submit_btn_text(object)
    @room.new_record? ? "Create" : "Update"
  end
end
