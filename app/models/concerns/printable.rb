module Printable
  extend ActiveSupport::Concern

  def print_id
    puts self.id
  end

  def print_name
    puts self.name
  end
end
