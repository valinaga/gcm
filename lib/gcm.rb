require 'httparty'
require 'cgi'

class GCM
  include HTTParty
  format :json
  default_timeout 30

  attr_accessor :timeout, :auth_key

  PUSH_URL = 'https://android.apis.google.com/c2dm/send'

  class << self
    attr_accessor :auth_key

    def send_notifications(notifications = [], auth_key = @auth_key)
      gcm = GCM.new(auth_key)
      notifications.collect do |notification|
        gcm.send_notification(notification)
      end
    end
    
  end

  def initialize(auth_key = nil)
    @auth_key = auth_key || self.class.auth_key
  end

  # {
  #   :registration_ids => ["...", "..."],
  #   :data => {
  #     :message => "Hi!", 
  #     :score => 7
  #   },
  #   :collapse_key => "optional collapse_key string"
  # }
  def send_notification(options)
    options[:collapse_key] ||= 'foo'
    registration_id = options.delete(:registration_id)
    options.merge!({ :registration_ids => [ registration_id ] }) unless registration_id.nil?
    
    params = {
      :body    => options.to_json,
      :headers => {
        'Content-Type' => 'application/json',
        'Authorization' => "key=#{@auth_key}"
      }
    }

    response = self.class.post(PUSH_URL, params)
    puts response
    # check for authentication failures
    # raise response.parsed_response if response['Error=']

    #@auth_token = response.body.split("\n")[2].gsub('Auth=', '')

  end

end