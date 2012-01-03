def simple_format(text)
  text = '' if text.nil?
  start_tag = '<p>'
  text = Sanitize.clean(text)
  text = text.to_str
  text.gsub!(/\r\n?/, "\n")                    # \r\n and \r -> \n
  text.gsub!(/\n\n+/, "</p>\n\n#{start_tag}")  # 2+ newline  -> paragraph
  text.gsub!(/([^\n]\n)(?=[^\n])/, '\1<br />') # 1 newline   -> br
  text.insert 0, start_tag
  text.concat("</p>")
end
