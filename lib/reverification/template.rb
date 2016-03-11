module Reverification
  class Template
    class << self
      delegate :url_helpers, to: 'Rails.application.routes'

      def final_warning_notice(email)
        { to: "#{email}", from: Reverification::Mailer::FROM,
          subject: 'Your Account Will Be Deleted In Two Weeks: Please Reverify',
          body_html: "<p>Hello.<br><br> You are receiving this notice because Open Hub has determined that this account
            is spam and will be deleted from the website in 2 weeks. If this is incorrect, please #{login_link}
            and then click #{verify_link} to reverify in order to restore your account. Failure to do so
            within the 2 weeks time span will result in your account's deletion and will no longer be able to be
            restored. Please reverify your account by tomorrow so that you may continue to enjoy our services.<br><br>
            Sincerely,<br><br>The Open Hub Team<br>8 New England Executive Park<br>Burlington, MA 01803</p>" }
      end

      def account_is_spam_notice(email)
        { to: "#{email}", from: Reverification::Mailer::FROM, subject: 'Your Account Status Has Converted to Spam',
          body_html: "<p>Hello.<br><br>You are receiving this notice because Open Hub has determined that this account
            is spam and has changed the status of your account to spam in its system. If this is incorrect,
            please #{login_link} and then click #{verify_link} to reverify in order to restore your account. Failure to
            do so will result in your account's eventual deletion. Please reverify your account within 2
            weeks so that you may continue to enjoy our services. Please note that if you fail to verify within the 2
            weeks period, your account and all data associated it will be marked for deletion.<br><br>
            Sincerely,<br><br>The Open Hub Team<br>8 New England Executive Park<br>Burlington, MA 01803</p>" }
      end

      def marked_for_spam_notice(email)
        { to: "#{email}", from: Reverification::Mailer::FROM,
          subject: 'Account Marked for Spam',
          body_html: "<p>Hello.<br><br> As an effort to eliminate excessive spam accounts, Open Hub has provided you
            the following link in order to reverify your account with us. Please #{login_link} and then click
            #{verify_link} to reverify within 2 weeks so that you may continue to enjoy our
            services. Please note that if you fail to verify your account within the 2 weeks time span, Open Hub will
            convert your account status as spam. Thank you.<br><br>
            Sincerely,<br><br>The Open Hub Team<br>8 New England Executive Park<br>Burlington, MA 01803</p>" }
      end

      def first_reverification_notice(email)
        { to: "#{email}", from: Reverification::Mailer::FROM,
          subject: 'Please Reverify Your Open Hub Account',
          body_html: "<p>Hello.<br><br>As an effort to eliminate excessive spam accounts, Open Hub has provided you the
            following link in order to reverify your account with us. Please #{login_link} and then click
            #{verify_link} to reverify within 2 weeks so that you may continue to enjoy our
            services. Please note that if you fail to verify your account within 2 weeks, Open Hub will flag your
            account as spam. Thank you.<br><br>
            Sincerely,<br><br>The Open Hub Team<br>8 New England Executive Park<br>Burlington, MA 01803</p>" }
      end

      def login_link
        "<a href=#{url_helpers.new_session_url(host: ENV['URL_HOST'])}>login</a>"
      end

      def verify_link
        "<a href=#{url_helpers.new_authentication_url(host: ENV['URL_HOST'])}>here</a>"
      end
    end
  end
end
