# frozen_string_literal: true

# rubocop:disable Style/ClassAndModuleChildren
module SpecSupport
  module JSONHelpers
    def json_response
      JSON.parse(response.body, symbolize_names: true)
    end
  end
end
# rubocop:enable Style/ClassAndModuleChildren
