# Overriding String functionality
class String
  # @return [String] Convert CamelCase string to snake_case
  def snakecase
    str = dup
    str.gsub! /::/, '/'
    str.gsub! /([A-Z]+)([A-Z][a-z])/, '\1_\2'
    str.gsub! /([a-z\d])([A-Z])/, '\1_\2'
    str.tr! '.', '_'
    str.tr! '-', '_'
    str.downcase!
    str
  end
end
