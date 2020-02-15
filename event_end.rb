#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'mailer'

puts('EVENT END')

send_email('Event attachments', include_attachments: true)

# Remove attachments already sent by email
Dir.foreach(ATTACHMENTS_PATH) do |file_name|
  is_directory = %w[. ..].include?(file_name)

  file = File.join(ATTACHMENTS_PATH, file_name)
  File.delete(file) unless is_directory
end
