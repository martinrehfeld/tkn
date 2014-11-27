group :compile do
  guard :shell do
    def compile
      cmd = "make"
      puts "\n#{cmd}"
      puts `#{cmd}`
      puts '...done.'
    end

   watch /src\/([a-z].+)\.(hrl|erl|app\.src)/ do |m|
      compile
    end
  end
end
