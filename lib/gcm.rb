require 'httparty'

class GCM
  include HTTParty
  default_timeout 30

  attr_accessor :auth_key
  attr_reader :successes, :failures, :canonicals

  PUSH_URL = 'https://android.googleapis.com/gcm/send'

  class << self
    attr_accessor :auth_key
    attr_reader :successes, :failures, :canonicals

    def send_notifications(notifications = [], auth_key = @auth_key)
      @successes, @failures, @canonicals = 0, 0, 0
      gcm = GCM.new(auth_key)
      notifications.each do |notification|
        gcm.send_notification(notification)
        @successes += gcm.successes
        @failures += gcm.failures
        @canonicals += gcm.canonicals
      end
    end
    
  end

  def initialize(auth_key = nil)
    @auth_key = auth_key || self.class.auth_key
    @successes, @failures, @canonicals = 0, 0, 0
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
    case response.code
      when 200
        @successes += response["success"]+1
        @failures += response["failure"]+1
        @canonicals += response["canonical_ids"]+1
        parse_failures(response["results"]) if response["failure"] > 0 || response["canonical_ids"] > 0 
      when 400
        raise "GCM ERROR: #{response.parsed_response}"
      when 401
        raise "Invalid Key in GCM Notification! Check the auth_key!"
      when 500
        puts "INTERNAL ERROR #{response.code}"
      when 503
        puts "The server is temporarily unavailable. Try again later."
    end    
  end
  
private
  def parse_failures(results)
    results.each_with_index do |result, i|
      if result["message_id"] 
        #might be ok, let's check for registration_id
        puts "error id:#{i} must be replaced with #{result["registration_id"]}" if result["registration_id"] 
      else
        puts "error id:#{i} - #{result["error"]}"
      end
    end
  end
    
end