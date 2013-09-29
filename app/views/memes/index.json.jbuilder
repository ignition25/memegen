json.array!(@memes) do |meme|
  json.extract! meme, :context
  json.url meme_url(meme, format: :json)
end
