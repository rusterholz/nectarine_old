class ApplicationMailer < ActionMailer::Base
  include Sidekiq::Mailer
end