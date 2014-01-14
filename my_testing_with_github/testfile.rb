

require 'fileutils'

#puts `pwd`
 puts Dir.glob("/home/josh/RubyminePro/automation_rails/my_testing_with_github/sss/*")

FileUtils.rm_r Dir.glob('/home/josh/RubyminePro/automation_rails/my_testing_with_github/sss/*'),:force =>true +

    working_path= Rails.root.join('public','uploads'