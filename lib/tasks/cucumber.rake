# frozen_string_literal: true

unless ARGV.any? { |a| a =~ /^gems/ } # Don't load anything when running the gems:* tasks

  vendored_cucumber_bin = Dir["#{Rails.root}/vendor/{gems,plugins}/cucumber*/bin/cucumber"].first
  unless vendored_cucumber_bin.nil?
    $LOAD_PATH.unshift(File.dirname(vendored_cucumber_bin) + '/../lib')
  end

  begin
    require 'cucumber/rake/task'

    namespace :cucumber do
      Cucumber::Rake::Task.new({ ok: 'test:prepare' }, 'Run features that should pass') do |t|
        t.binary = vendored_cucumber_bin # If nil, the gem's binary is used.
        t.fork = true # You may get faster startup if you set this to false
        t.profile = 'default'
      end

      Cucumber::Rake::Task.new({ wip: 'test:prepare' }, 'Run features that are being worked on') do |t|
        t.binary = vendored_cucumber_bin
        t.fork = true # You may get faster startup if you set this to false
        t.profile = 'wip'
      end

      Cucumber::Rake::Task.new({ rerun: 'test:prepare' }, 'Record failing features and run only them if any exist') do |t|
        t.binary = vendored_cucumber_bin
        t.fork = true # You may get faster startup if you set this to false
        t.profile = 'rerun'
      end

      desc 'Run all features'
      task all: %i[ok wip]

      task statsetup: :environment do
        require 'rails/code_statistics'
        if File.exist?('features')
          ::STATS_DIRECTORIES << %w[Cucumber\ features features]
        end
        if File.exist?('features')
          ::CodeStatistics::TEST_TYPES << 'Cucumber features'
        end
      end

      task annotations_setup: :environment do
        Rails.application.configure do
          if config.respond_to?(:annotations)
            config.annotations.directories << 'features'
            config.annotations.register_extensions('feature') { |tag| /#\s*(#{tag}):?\s*(.*)$/ }
          end
        end
      end
    end
    desc 'Alias for cucumber:ok'
    task cucumber: 'cucumber:ok'

    task default: :cucumber

    task features: :cucumber do
      warn "*** The 'features' task is deprecated. See rake -T cucumber ***"
    end

    task 'test:prepare' => :environment do
    end

    task stats: 'cucumber:statsetup'

    task notes: 'cucumber:annotations_setup'
  rescue LoadError
    desc 'cucumber rake task not available (cucumber not installed)'
    task cucumber: :environment do
      abort 'Cucumber rake task is not available. Be sure to install cucumber as a gem or plugin'
    end
  end

end