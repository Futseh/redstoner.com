class AllPreview < ActionMailer::Preview
  @@user = User.new(id: 123, uuid: "aabbccddeeff11223344556677889900", ign: "fancy_user", name: "fancy_user", email_token: "abcdefg", email: "fancymail@example.com", created_at: Time.now, last_ip: "1.2.3.4")
  @@op     = User.new(id: 32, name: "TheOP", ign: "the_op", email: "theopuser@example.com")

  def register_mail_normal
    RedstonerMailer.register_mail(@@user, false)
  end

  def register_mail_idiot
    RedstonerMailer.register_mail(@@user, true)
  end

  def register_info_mail_normal
    RedstonerMailer.register_info_mail(@@user, false)
  end

  def register_info_mail_idiot
    RedstonerMailer.register_info_mail(@@user, true)
  end

  def new_thread_mention_mail
    thread = Forumthread.new(id: 123, user_author: @@op, title: "Wow, test thread!", content: "# Markdown!\n\n@mention\n`incline code`\n\n<b>html?</b>\n\n[yt:abcd1234]\n\n[link](/forums)")
    RedstonerMailer.new_thread_mention_mail(@@user, thread)
  end

  def new_thread_reply_mail
    thread = Forumthread.new(id: 123, user_author: @@op, title: "Wow, test thread!", content: "You should not see this...")
    reply  = Threadreply.new(id: 312, user_author: @@user, content: "# Markdown!\n\n`incline code`\n\n<b>html?</b>\n\n[yt:abcd1234]\n\n[link](/forums)", forumthread: thread)
    RedstonerMailer.new_thread_reply_mail(@@user, reply)
  end

  def new_post_mention_mail
    post    = Blogpost.new(id: 123, user_author: @@op, title: "Wow, test post!", content: "@mention Wow, that is **cool**!")
    RedstonerMailer.new_post_mention_mail(@@user, post)
  end

  def new_post_comment_mail
    post    = Blogpost.new(id: 123, user_author: @@op, title: "Wow, test post!", content: "You should not see this...")
    comment = Comment.new(id: 312, user_author: @@user, content: "Wow, that is **cool**!", blogpost: post)
    RedstonerMailer.new_post_comment_mail(@@user, comment)
  end

  def email_change_confirm_mail
    RedstonerMailer.email_change_confirm_mail(@@user)
  end
end