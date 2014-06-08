require 'user_agent'

module Browser
  extend ActiveSupport::Concern

  included do
    helper_method :current_browser
  end

  def current_browser
    @current_browser ||= Browser::Base.new( request )
  end

  class Base

    INQUIRY = /^[a-z_]+\?$/

    def initialize( request )
      @ua = UserAgent.parse( request.env['HTTP_USER_AGENT'] )
      @inquirer = ( @ua.browser ? ActiveSupport::StringInquirer.new( @ua.browser.gsub(/\s+/, '').underscore ) : ActiveSupport::StringInquirer.new( '' ) )
    end

    def method_missing( meth, *args, &block )
      if ['mobile?', 'bot?', 'webkit?'].include?( meth.to_s )
        @ua.send( meth, *args, &block )
      elsif meth.to_s =~ INQUIRY
        @inquirer.send( meth, *args, &block )
      elsif @ua.respond_to?( meth )
        @ua.send( meth, *args, &block )
      else
        super
      end
    end

    def respond_to?( meth )
      !!( meth.to_s =~ INQUIRY || [ 'chrome_frame?', 'to_s' ].include?( meth.to_s ) || @ua.respond_to?( meth ) )
    end

    def ie?
      @inquirer.internet_explorer?
    end

    def chrome_frame?
      !!@ua.chromeframe
    rescue NoMethodError
      false
    end

    def to_hash
      {
        browser: @ua.browser,
        version: @ua.version.to_s,
        platform: @ua.platform,
        os: @ua.os,
        mobile: @ua.mobile?,
        bot: @ua.bot?
      }
    end

    def to_s
      self.to_hash.to_s
    end

    def inspect
      self.to_hash.inspect
    end

  end

end
