require "resend"

Resend.api_key = ENV.fetch("RESEND_KEY") { "" }
