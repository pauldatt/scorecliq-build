module MessagesHelper
  def recipients_options
    s = ''
    current_user.friends.each do |user|
      s << "<option value='#{user.id}'>#{user.name}</option>"
    end
    s.html_safe
  end
end