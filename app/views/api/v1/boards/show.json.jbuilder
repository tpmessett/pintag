json.extract! @board, :id, :name, :description
json.content @board.contents do |content|
  json.extract! content, :id, :name, :description, :link
end
