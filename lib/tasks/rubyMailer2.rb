require 'net/smtp'

def send_email(to,opts={})
  opts[:server]      ||= 'smtp.rdslink.ro'
  opts[:from]        ||= 'mail-noreply@colourpop.com'
  opts[:from_alias]  ||= 'ColourPop Team'
  opts[:subject]     ||= "Spring Sales"
  opts[:body]        ||= "Hello Ioana,\n\n We thought you might like to check out these products we have on sale:\n https://colourpop.com/collections/bye-bye\n\n Sincerely,\nThe ColourPop Team"

  msg = <<END_OF_MESSAGE
From: #{opts[:from_alias]} <#{opts[:from]}>
To: <#{to}>
Subject: #{opts[:subject]}

#{opts[:body]}
END_OF_MESSAGE

  Net::SMTP.start(opts[:server]) do |smtp|
    asd = smtp.send_message msg, opts[:from], to
  end
end

send_email "radu.petrut@yahoo.com"
#send_email "radu.petrut23@gmail.com"
#send_email "radu.petrut@outlook.com"
#send_email "ioana_clc@yahoo.com"
