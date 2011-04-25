require 'active_support/core_ext/string/inflections.rb'

class String
  def underscore_preserve(safe)
    self.split(safe).map(&:underscore).join(safe)
  end
end
