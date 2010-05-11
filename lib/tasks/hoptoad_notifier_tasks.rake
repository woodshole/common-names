begin
  Dir[File.join(RAILS_ROOT, 'vendor', 'gems', 'hoptoad_notifier-*')].each do |vendored_notifier|
    $: << File.join(vendored_notifier, 'lib')
  end

  require 'hoptoad_notifier/tasks'
rescue MissingSourceFile => e
  # OK, so this file gets included by the rakefile, right?
  # But, what if you want to install Hoptoad Notifier via rake gems:install?
  # You can't do it, because this file requires hoptoad_notifier/tasks and 
  # causes the whole rakefile to freak itself out!
  #
  # To allow us to install Hoptoad Notifier using rake gems, I had to insert
  # this begin-rescue block to save Hoptoad Notifier from itself. 
  #
  # THIS KIND OF THING IS SO RIDICULOUS.
end