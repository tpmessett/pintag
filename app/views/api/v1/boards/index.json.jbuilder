json.boards do
  json.array! @boards do |board|
    json.extract! board, :id, :name, :description
  end
end

json.tags do
  json.array! @tags do |tag|
    json.extract! tag, :id, :name
  end
end
