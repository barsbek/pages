module PagesHelper
  def html_to_markdown(with_html)
    with_html.to_s
      .gsub(/<b>(.+)<\/b>/) { "**#{$1}**" }
      .gsub(/<i>(.+)<\/i>/) { "\\\\#{$1}\\\\" }
      .gsub(/<a.+href\=https?:\/\/[^\/]+\/(\S+)>(.+)<\/a>/) do
        "((#{$1}[#{$2}]))"
      end
  end

  def markdown_to_html(val, url=nil)
    val.to_s
      .gsub(/\*{2}([^\*][^\*]+)\*{2}/) { "<b>#{$1}</b>" }
      .gsub(/\\{2}([^\\][^\\]+)\\{2}/) { "<i>#{$1}</i>" }
      .gsub(/\({2}([^\[]+)\[([^\]][^\)][^\)]+)\]\){2}/) do
        href = url ? "#{url}/#{$1}" : $1
        "<a href=#{href}>#{$2}</a>"
      end
  end
end
