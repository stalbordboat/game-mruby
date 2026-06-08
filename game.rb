MRuby::Build.new do |conf|
  conf.toolchain ENV.fetch('MRUBY_TOOLCHAIN', 'gcc').to_sym

  conf.enable_test

  conf.gembox              'stdlib'
  conf.gembox              'metaprog'

  conf.gem :core        => 'mruby-pack'
  conf.gem :core        => 'mruby-sprintf'
  conf.gem :core        => 'mruby-random'
  conf.gem :core        => 'mruby-bin-mrbc'

  conf.cc.flags         = '-fpic'

  latest_stable_version = `git tag`.scan(/4.\d.\d/).last

  conf.install_prefix   = ENV['PREFIX'] || "#{ENV['HOME']}/.local"
  contents              = %Q[prefix=#{conf.install_prefix}
exec_prefix=${prefix}
includedir=${prefix}/include/GameNDK
libdir=${exec_prefix}/lib

Name: game-mruby
Description: A configuration of mruby for GameNDK.
Version: #{latest_stable_version}
Cflags: -I${includedir}
Libs: -L${libdir} -lgame-mruby -lm]
  pc_filename           = 'game-mruby.pc'

  File.write(pc_filename, contents)
end
