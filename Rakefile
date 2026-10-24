PROJECT_NAME = 'game-mruby'
MRBC         = 'game-mrbc'
VERBOSE      = true

PREFIX        = ENV['PREFIX'] || "#{ENV['HOME']}/.local"
HEADER_PREFIX = "#{PREFIX}/include/GameNDK"
HOST_PATH     = 'build/host'

BUILD_CONFIG_FILENAME = 'game.rb'
BUILD_CONFIG_DIRNAME  = 'build_config'
MRUBY_DIRNAME         = 'mruby'
LIBNAME               = 'libgame-mruby.a'
PC_FILENAME           = 'game-mruby.pc'

task :default => :all

desc "Automates the cloning, patching, building of #{PROJECT_NAME}"
task :all, :branch do |t, args|
  args.with_defaults :branch => 'stable'

  Rake::Task[:clone].invoke args[:branch]
  Rake::Task[:build].invoke
  Rake::Task[:patch].invoke
  Rake::Task[:install].invoke
end

desc "Automates the cloning of #{PROJECT_NAME}"
task :clone, :branch do |t, args|
  args.with_defaults :branch => 'stable'

  branch = args[:branch]
  url    = 'https://github.com/mruby/mruby.git'
  cmd    = "git clone --branch #{branch} --single-branch #{url}"

  sh cmd unless Dir.exist? MRUBY_DIRNAME
end

desc "Automates the build of #{PROJECT_NAME}"
task :build do |t|
  src  = BUILD_CONFIG_FILENAME
  dest = "#{MRUBY_DIRNAME}/#{BUILD_CONFIG_DIRNAME}"

  FileUtils.cp src, dest, verbose: VERBOSE
end

desc "Automates the patching of #{PROJECT_NAME}"
task :patch do |t|
  FileUtils.cd(MRUBY_DIRNAME) { sh("MRUBY_CONFIG=\"#{BUILD_CONFIG_DIRNAME}/#{BUILD_CONFIG_FILENAME}\" rake") }
end

desc 'Automates the removal of the build output'
task :clean do
  FileUtils.rm_rf MRUBY_DIRNAME, verbose: VERBOSE
end

desc 'Automates the installation of files'
task :install do
  FileUtils.cd MRUBY_DIRNAME, verbose: VERBOSE do
    # Install Binaries

    src  = "#{HOST_PATH}/bin/mrbc"
    dest = "#{PREFIX}/bin/#{MRBC}"
    FileUtils.install src, dest, verbose: VERBOSE if File.exist? src

    src  = "#{HOST_PATH}/lib/libmruby.a"
    dest = "#{PREFIX}/lib/#{LIBNAME}"
    FileUtils.cp src, dest, verbose: VERBOSE if File.exist? src

    src  = 'game-mruby.pc'
    dest = "#{PREFIX}/lib/pkgconfig/#{PC_FILENAME}"
    FileUtils.cp src, dest, verbose: verbose if File.exist? src

    # Install Headers

    FileUtils.mkdir_p HEADER_PREFIX, verbose: verbose

    dest = "#{HEADER_PREFIX}/mruby.h"
    src  = "#{HOST_PATH}/include/mruby.h"
    FileUtils.cp src, dest, verbose: verbose if File.exist? src

    dest = "#{HEADER_PREFIX}/mrbconf.h"
    src  = "#{HOST_PATH}/include/mrbconf.h"
    FileUtils.cp src, dest, verbose: verbose if File.exist? src

    dest = "#{HEADER_PREFIX}/mruby"
    src  = "#{HOST_PATH}/include/mruby"
    FileUtils.cp_r src, dest, verbose: verbose if File.exist? src
  end
end

desc 'Automates the removal of the installed file'
task :uninstall do
  FileUtils.cd PREFIX, verbose: VERBOSE do
    path = 'bin/game-mrbc'
    FileUtils.rm_f path, verbose: VERBOSE

    path = "lib/#{LIBNAME}"
    FileUtils.rm_f path, verbose: VERBOSE

    path = "lib/pkgconfig/#{PC_FILENAME}"
    FileUtils.rm_f path, verbose: VERBOSE
  end

  FileUtils.cd HEADER_PREFIX, verbose: VERBOSE do
    FileUtils.rm_rf 'mruby',     verbose: VERBOSE
    FileUtils.rm_f  'mruby.h',   verbose: VERBOSE
    FileUtils.rm_f  'mrbconf.h', verbose: VERBOSE
  end
end
