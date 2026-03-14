# frozen_string_literal: true

module Legion
  module Extensions
    module CognitiveLoadBalancing
      class Client
        include Runners::CognitiveLoadBalancing

        def engine
          @engine ||= Helpers::LoadBalancer.new
        end
      end
    end
  end
end
