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

  def word_chart(user, words, good)
    name = user.name || user.slug
    word_map = words.inject(Hash.new{|h,k| h[k] = 0}) { |map, w| map[w.word.word.downcase] += 1; map }
    sorted_words = word_map.to_a.sort_by { |word_info| word_info[1] }.reverse

    chart = []
    partitioned_words = sorted_words.partition { |word_info| word_info[1] > 1 }
    unless partitioned_words[0].empty?
      img_src = ["http://chart.apis.google.com/chart?chxl=1:|"]
      img_src << partitioned_words[0].reverse.collect { |word_info| word_info[0] }.join("|")
      img_src << "&chxr=0,0,#{partitioned_words[0].first[1] + (partitioned_words[0].first[1].to_f * 0.10).ceil},#{(partitioned_words[0].first[1].to_f / 10.0).ceil}"
      img_src << "&chxt=x,y"
      img_src << "&chbh=a,12"
      img_src << "&chs=600x#{60 + (partitioned_words[0].length * 24)}"
      img_src << "&cht=bhs"
      img_src << "&chco=#{good ? "008000" : "AA0033"}"
      img_src << "&chds=0,#{partitioned_words[0].first[1] + (partitioned_words[0].first[1].to_f * 0.10).ceil}"
      img_src << "&chd=t:"
      img_src << partitioned_words[0].collect { |word_info| word_info[1] }.join(",")
      img_src << "&chma=|#{partitioned_words[0].length}"
      img_src << "&chtt=People+think+#{name}+#{good ? "is definitely:" : "is definitely not:"}"
      img_src << "&chts=676767,16"

      chart << "<img src=\"#{img_src.join('')}\" width=\"600\" height=\"#{60 + (partitioned_words[0].length * 15)}\" alt=\"Words that #{good ? "best" : "don't"} describe #{name}\"/>"
    end

    unless partitioned_words[1].empty?
      chart << "<p>"
      chart << "#{name} is #{"also " unless partitioned_words[0].empty?}#{"not" unless good} (each of these words has only been suggested once):"
      chart << "</p>"
      chart << "<div class='explanation'>"
      chart << partitioned_words[1].sort.collect { |word_info| word_info[0] }.join(", ")
      chart << "</div>"
    end

    chart.join("").html_safe
  end

end
