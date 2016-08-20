module PostsHelper
  def tagger(field)
    hashtag = field.caption
    return hashtag.scan(/\B#\w+/)
  end
end
