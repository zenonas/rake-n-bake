require 'term/ansicolor'

namespace :bake do
  task :check_external_dependencies do
    include Term::ANSIColor
    checker = RakeNBake::DependencyChecker.new(@external_dependencies)

    puts 'Checking external dependencies...'
    checker.check
    puts

    missing = checker.missing
    fail("The following dependencies are missing: \n#{missing.join(%Q[\n])}") unless missing.empty?
    puts
  end
end
