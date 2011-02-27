require 'parser'
require 'net/https'

class GmailParser < Parser
  FEED_BASE = "mail.google.com"

  def initialize(account, password)
    raise ArgumentError, "Missing account name" if account.nil?
    raise ArgumentError, "Missing password" if password.nil?
    @account = account
    @password = password
  end

  def green?
    unread_doc = load_feed
    unread_mail?(unread_doc)
  end

  private

  def load_feed
    unread_doc = ""
    http = Net::HTTP.new(FEED_BASE, 443)
    http.use_ssl = true
    http.start() {|http|
      request = Net::HTTP::Get.new('/mail/feed/atom')
      request.basic_auth @account, @password
      unread_feed = http.request(request).body
      unread_doc = Nokogiri::XML(unread_feed)
    }
    verify_credentials(unread_doc)
    unread_doc
  end

  def verify_credentials(unread_doc)
    if unread_doc.xpath("//H1/text()").first.to_s.casecmp("Unauthorized") == 0
      puts "Wrong Gmail credentials"
      exit(1)
    end
  end

  def unread_mail_count(unread_doc)
    unread_mail_count = unread_doc.xpath("//xmlns:fullcount/text()").to_s.to_i
    Logger.log("Found #{unread_mail_count} unread mail(s) for #{@account}")
    unread_mail_count
  end

  def unread_mail?(unread_doc)
    unread_mail_count(unread_doc) > 0
  end
end
