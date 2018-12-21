module MessagesHelper
  def user_name(message)
    message.user.email.split('@')[0].capitalize
  end

  def user_avatar(message)
    hash = Digest::MD5::hexdigest(message.user.email)

    "https://www.gravatar.com/avatar/#{hash}"
  end

  def message_date_time(message)
    date_fromat = "%B %d, %Y | " if message.created_at < (DateTime.now - 1.day)
    message.created_at.strftime("#{date_fromat}%I:%M%p")
  end
end