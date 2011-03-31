module ApplicationHelper

  def connected_providers_for(user)
    user.user_tokens.collect{|u| u.provider.to_sym }
  end

  def unconnected_providers_for(user)
    User.omniauth_providers - user.user_tokens.collect{|u| u.provider.to_sym }
  end

  def notice_html
    "<div class=\"notice\">#{notice}</div>" unless notice.blank?
  end

  def alert_html
    "<div class=\"alert\">#{alert}</div>" unless alert.blank?
  end

  def word_chart(user, words)
    name = user.name || user.slug
    word_map = words.inject(Hash.new{|h,k| h[k] = 0}) { |map, w| map[w.word.downcase] += 1; map }
    sorted_words = word_map.to_a.sort_by { |word_info| word_info[1] }.reverse

    img_src = ["http://chart.apis.google.com/chart?chxl=1:|"]
    img_src << sorted_words.reverse.collect { |word_info| word_info[0] }.join("|")
    img_src << "&chxr=0,0,#{sorted_words.first[1] + (sorted_words.first[1].to_f * 0.10).ceil},#{(sorted_words.first[1].to_f / 10.0).ceil}"
    img_src << "&chxt=x,y"
    img_src << "&chbh=a,12"
    img_src << "&chs=600x473"
    img_src << "&cht=bhs"
    img_src << "&chco=4D89F9"
    img_src << "&chds=0,#{sorted_words.first[1] + (sorted_words.first[1].to_f * 0.10).ceil}"
    img_src << "&chd=t:"
    img_src << sorted_words.collect { |word_info| word_info[1] }.join(",")
    img_src << "&chma=|#{sorted_words.length}"
    img_src << "&chtt=Words+that+best+describe+#{name}"
    img_src << "&chts=676767,16"

    "<img src=\"#{img_src.join('')}\" width=\"600\" height=\"473\" alt=\"Words that best describe #{name}\"/>".html_safe
  end

end
