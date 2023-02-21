test_tweets = [
  "This president sucks!",
  "I hate this Blank House!",
  "I can't believe we're living under such bad leadership. We were so foolish",
  "President Presidentname is a danger to society. I hate that he's so bad – it sucks."
  ]
banned_phrases = ["sucks", "bad", "hate", "foolish", "danger to society"]

clean_tweets = []

def rm_phrase(str_tocheck, phrase)

  if phrase == "danger to society"
    str_tocheck.sub! "danger to society", "CENSORED"
  end
  
  storage_array = str_tocheck.split(" ")
  return_arr = []
  
  storage_array.each { |word|
    if word.include?(phrase)
      return_arr.push("CENSORED")
    else
      return_arr.push(word)
    end
  }
  
  return return_arr.join(" ")
end

test_tweets.each { |tweet|
  banned_phrases.each { |phrase|
  if tweet.include?(phrase)
    tweet = rm_phrase(tweet, phrase)
  end
  }
  clean_tweets.push(tweet)
}

puts(clean_tweets)