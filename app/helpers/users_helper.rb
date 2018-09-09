module UsersHelper

  # Returns the Gravatar for the given user.
  def gravatar_for(user, options = { size: 80 })
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.firstName, class: "gravatar")
  end

  def allows_friends?(user)
    if  current_user.friends.include?(user) || 
        current_user.requests_received.any? { |req| req.user == user } || 
        current_user.friend_requests.any? { |req| req.friend == user }
    		return false
    end
    true
  end
end