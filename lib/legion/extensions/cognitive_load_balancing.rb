# frozen_string_literal: true

require_relative 'cognitive_load_balancing/version'
require_relative 'cognitive_load_balancing/helpers/constants'
require_relative 'cognitive_load_balancing/helpers/subsystem'
require_relative 'cognitive_load_balancing/helpers/load_balancer'
require_relative 'cognitive_load_balancing/runners/cognitive_load_balancing'
require_relative 'cognitive_load_balancing/client'

module Legion
  module Extensions
    module CognitiveLoadBalancing
      extend Legion::Extensions::Core if defined?(Legion::Extensions::Core)
    end
  end
end
