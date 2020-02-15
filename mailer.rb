# frozen_string_literal: true

require 'mail'
require 'zip'

EMAIL_USER = ENV['EMAIL_USER']
EMAIL_PASSWORD = ENV['EMAIL_PASSWORD']
EMAIL_DESTINATION = ENV['EMAIL_DESTINATION']
ATTACHMENTS_PATH = ENV['ATTACHMENTS_PATH']

def send_email(email_body, include_attachments:)
  attachments_filename = 'attachments.zip'
  attachments_zipfile_path = "#{ATTACHMENTS_PATH}/#{attachments_filename}"

  options = {
    address: 'smtp.gmail.com',
    port: 587,
    user_name: EMAIL_USER,
    password: EMAIL_PASSWORD,
    authentication: 'plain',
    enable_starttls_auto: true
  }

  Mail.defaults { delivery_method :smtp, options }

  mail = Mail.new do
    to EMAIL_DESTINATION
    from EMAIL_USER
    subject '[Security system] Event alert!'
    body email_body
  end
  
  if include_attachments
    Zip::File.open(attachments_zipfile_path, Zip::File::CREATE) do |zipfile|
      Dir.each_child(ATTACHMENTS_PATH) do |filename|
        zipfile.add(filename, File.join(ATTACHMENTS_PATH, filename))
      end
    end

    mail.add_file filename: attachments_filename, 
                  content: File.read(attachments_zipfile_path)
  end

  mail.deliver
end
