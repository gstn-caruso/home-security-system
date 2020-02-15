#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'mailer'

puts('EVENT START')

send_email('WARNING: Motion was detected', include_attachments: false)
