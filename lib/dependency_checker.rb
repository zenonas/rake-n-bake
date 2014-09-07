require 'term/ansicolor'

class RakeRack
  class DependencyChecker
    include Term::ANSIColor

    def initialize dependencies
      @dependencies = Array(dependencies)
    end

    def check silent = false
      @results = @dependencies.each_with_object({}) do |dep, results|
        results[dep] = system "which #{dep} >/dev/null"
        unless silent
          results[dep] ? print(".".green) : print("F".red)
        end
      end
    end

    def missing
      @results ||= check(true)
      @results.select{|_, present| present == false}.keys
    end

  end
end