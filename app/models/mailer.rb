class Mailer < ActionMailer::Base

  helper ApplicationHelper

  ADMIN_EMAILS = ["jared@bestwords.me"]
  default_url_options[:host] = Rails.application.host
  default :from => "BestWords.Me <support@bestwords.me>", :bcc => "emails@bestwords.me", :host => Rails.application.host, :headers => {'X-SMTPAPI' => '{"category": "BestWords"}'}

  def notify_words_added(user_id, emailing, user_word_ids)
    @user = User.find(user_id)
    @emailing = emailing
    @words = UserWord.where("id in (#{user_word_ids.join(',')})").includes(:word)
    mail(
      :to => nice_email_address_for_user(@user),
      :subject => "Someone has added some words to your page"
    )
  end

  def nice_email_address_for_user(user)
    nice_email_address(user.email, "secret person")
  end

  def nice_email_address(email, name)
    "#{"#{name}" unless name.blank?} <#{email}>"
  end

end
