require File.expand_path("test_helper", File.dirname(__FILE__))

class CodeStatisticsTest < Test::Unit::TestCase

  include Construct::Helpers

  should "find passed in directory" do
    within_construct do |construct|
      dir             = construct.directory("lib")
      file            = dir.file("real.rb", "this\nis\n\lame\n")
      controllers_dir = dir.directory("controllers")
      file            = controllers_dir.file("fake.rb", "this\nis\n\lame\n")
      code_stats      = CodeStatistics::CodeStatistics.new([["Libraries", 'lib']])
      assert code_stats.to_s.match(/Libraries/)
      assert code_stats.to_s.match(/Code LOC: 6/)
    end
  end

  should "not duplicate passed in directories with same paths with slashes" do
    within_construct do |construct|
      dir             = construct.directory("lib")
      file            = dir.file("real.rb", "this\nis\n\lame\n")
      controllers_dir = dir.directory("controllers")
      file            = controllers_dir.file("fake.rb", "this\nis\n\lame\n")
      code_stats      = CodeStatistics::CodeStatistics.new([["Libraries", 'lib'], ["libs", 'lib/']])
      assert code_stats.to_s.match(/Libraries/)
      assert code_stats.to_s.match(/Code LOC: 6/)
    end
  end
  
  should "find app controllers directory" do
    within_construct do |construct|
      dir             = construct.directory("app")
      controllers_dir = dir.directory("controllers")
      file            = controllers_dir.file("fake.rb", "this\nis\n\lame\n")
      code_stats      = CodeStatistics::CodeStatistics.new([])
      assert code_stats.to_s.match(/app\/controllers/)
      assert code_stats.to_s.match(/Code LOC: 3/)
    end
  end

  should "don't double count app directory when empty sub directories directory" do
    within_construct do |construct|
      dir             = construct.directory("app")
      controllers_dir = dir.directory("controllers")
      file            = controllers_dir.file("fake.rb", "this\nis\n\lame\n")
      empty_sub_dir = dir.directory("zfolder")
      code_stats      = CodeStatistics::CodeStatistics.new([])
      assert code_stats.to_s.match(/app\/controllers/)
      assert code_stats.to_s.match(/Code LOC: 3/)
    end
  end

  should "find app non rails directory" do
    within_construct do |construct|
      dir             = construct.directory("app")
      sub_dir         = dir.directory("servers")
      file            = sub_dir.file("fake.rb", "this\nis\n\lame\n")
      code_stats      = CodeStatistics::CodeStatistics.new([])
      assert code_stats.to_s.match(/app\/servers/)
      assert code_stats.to_s.match(/Code LOC: 3/)
    end
  end

  should "add spec sub directories and count as test code" do
    within_construct do |construct|
      dir             = construct.directory("spec")
      sub_dir         = dir.directory("models")
      file            = sub_dir.file("fake.rb", "this\nis\n\lame\n")
      sub_dir2        = dir.directory("controllers")
      file            = sub_dir2.file("fake.rb", "this\nis\n\lame\n")
      code_stats      = CodeStatistics::CodeStatistics.new([])
      assert code_stats.to_s.match(/spec\/models/)
      assert code_stats.to_s.match(/spec\/controllers/)
      assert code_stats.to_s.match(/Test LOC: 6/)
    end
  end

  should "add spec sub sub directories and count as test code" do
    within_construct do |construct|
      dir             = construct.directory("spec")
      sub_dir         = dir.directory("models")
      sub_dir2        = sub_dir.directory("controllers")
      file            = sub_dir2.file("fake.rb", "this\nis\n\lame\n")
      code_stats      = CodeStatistics::CodeStatistics.new([])
      assert code_stats.to_s.match(/spec\/models\/controllers/)
      assert code_stats.to_s.match(/Test LOC: 3/)
    end
  end

  should "add spec sub sub directories but add highest level directory with test files and count as test code" do
    within_construct do |construct|
      dir             = construct.directory("spec")
      sub_dir         = dir.directory("models")
      file            = sub_dir.file("top_fake.rb", "this\nis\n\lame\n")
      sub_dir2        = sub_dir.directory("controllers")
      file            = sub_dir2.file("fake.rb", "this\nis\n\lame\n")
      code_stats      = CodeStatistics::CodeStatistics.new([])
      assert code_stats.to_s.match(/spec\/models/)
      assert code_stats.to_s.match(/Test LOC: 6/)
    end
  end

  should "add spec root directory and count as test code" do
    within_construct do |construct|
      dir             = construct.directory("spec")
      file            = dir.file("fake.rb", "this\nis\n\lame\n")
      code_stats      = CodeStatistics::CodeStatistics.new([])
      assert code_stats.to_s.match(/spec/)
      assert code_stats.to_s.match(/Test LOC: 3/)
    end
  end

  should "add test sub directories and count as test code" do
    within_construct do |construct|
      dir             = construct.directory("test")
      sub_dir         = dir.directory("models")
      file            = sub_dir.file("fake.rb", "this\nis\n\lame\n")
      sub_dir2        = dir.directory("controllers")
      file            = sub_dir2.file("fake.rb", "this\nis\n\lame\n")
      code_stats      = CodeStatistics::CodeStatistics.new([])
      assert code_stats.to_s.match(/test\/models/)
      assert code_stats.to_s.match(/test\/controllers/)
      assert code_stats.to_s.match(/Test LOC: 6/)
    end
  end

  should "add test root directory and count as test code" do
    within_construct do |construct|
      dir             = construct.directory("test")
      file            = dir.file("fake.rb", "this\nis\n\lame\n")
      code_stats      = CodeStatistics::CodeStatistics.new([])
      assert code_stats.to_s.match(/Test/)
      assert code_stats.to_s.match(/Test LOC: 3/)
    end
  end

  should "count test directory even if passed in as full path" do
    within_construct do |construct|
      dir             = construct.directory("test")
      file            = dir.file("fake.rb", "this\nis\n\lame\n")
      code_stats      = CodeStatistics::CodeStatistics.new([["test", dir.to_s]])
      assert code_stats.to_s.match(/Test/)
      assert code_stats.to_s.match(/Test LOC: 3/)
    end
  end

  should "calculate correct test to code ratio" do
    within_construct do |construct|
      dir             = construct.directory("app")
      sub_dir         = dir.directory("models")
      file            = sub_dir.file("fake.rb", "this\n"*9)
      sub_dir2        = dir.directory("controllers")
      file            = sub_dir2.file("fake.rb", "this\nis\n\lame\n")

      dir             = construct.directory("test")
      sub_dir         = dir.directory("models")
      file            = sub_dir.file("fake.rb", "this\nis\n\lame\n")
      sub_dir2        = dir.directory("controllers")
      file            = sub_dir2.file("fake.rb", "this\nis\n\lame\n")
      code_stats      = CodeStatistics::CodeStatistics.new([])
      assert code_stats.to_s.match(/Code LOC: 12/)
      assert code_stats.to_s.match(/Test LOC: 6/)
      assert code_stats.to_s.match(/Code to Test Ratio: 1:0.5/)
    end
  end

  should "ignore the expected file globs" do
    within_construct do |construct|
      dir             = construct.directory("app")
      sub_dir         = dir.directory("models")
      file            = sub_dir.file("fake.rb", "this\n"*9)
      sub_dir2        = dir.directory("controllers")
      file            = sub_dir2.file("fake.rb", "this\nis\n\lame\n")

      dir             = construct.directory("test")
      sub_dir         = dir.directory("models")
      file            = sub_dir.file("fake.rb", "this\nis\n\lame\n")
      sub_dir2        = dir.directory("controllers")
      file            = sub_dir2.file("fake.rb", "this\nis\n\lame\n")
      code_stats      = CodeStatistics::CodeStatistics.new([],['app/controllers/**/*'])
      assert code_stats.to_s.match(/Code LOC: 9/)
      assert code_stats.to_s.match(/Test LOC: 6/)
      assert code_stats.to_s.match(/Code to Test Ratio: 1:0.7/)
    end
  end

end
