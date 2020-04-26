# frozen_string_literal: true


module HelpshareErrors
  class Unauthenticated < StandardError; end

  ERRORS = {
    Unauthenticated => :unauthenticated
  }
end
