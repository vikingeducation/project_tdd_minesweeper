module Errors
  class UnavailableCellError < StandardError;  end

  class IllegalActionError < StandardError; end

  class CellWasMinedError < StandardError; end
end