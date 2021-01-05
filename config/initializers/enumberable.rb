# frozen_string_literal: true

module Enumerable
  def count_by(&block)
    list = group_by(&block).map { |key, items| [key, items.count] }
    Hash[list]
  end
end
