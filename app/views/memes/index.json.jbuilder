json.array!(@memes) do |meme|
  json.extract! meme, :title, :context
  json.url meme_url(meme, format: :json)
end
