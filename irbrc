#!/usr/bin/ruby
require 'irb/completion'
require 'irb/ext/save-history'
require 'tempfile'

IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb_history"

IRB.conf[:AUTO_INDENT] = true

# adapted from http://github.com/gilesbowkett/utility-belt/blob/0a542e50a3c27f883688358f70c89719be651e4b/lib/utility_belt/interactive_editor.rb
def vim
  unless @vim_tempfile
    @vim_tempfile = Tempfile.new("irb_tempfile")
  end
  system(%[vim -c ":set syntax=ruby" #{@vim_tempfile.path}])
  Object.class_eval(`cat #{@vim_tempfile.path}`)
rescue Exception => error
  puts error
end
alias :vi :vim

class Object
  # list methods which aren't in superclass
  def local_methods(obj = self)
    (obj.methods - obj.class.superclass.instance_methods).sort
  end
  
  # print documentation
  #
  #   ri 'Array#pop'
  #   Array.ri
  #   Array.ri :pop
  #   arr.ri :pop
  def ri(method = nil)
    unless method && method =~ /^[A-Z]/ # if class isn't specified
      klass = self.kind_of?(Class) ? name : self.class.name
      method = [klass, method].compact.join('#')
    end
    puts `ri '#{method}'`
  end
end

load File.dirname(__FILE__) + '/.railsrc' if $0 == 'irb' && ENV['RAILS_ENV']
