json.array! @boards do |board|
  json.extract! board, :id, :name, :description
end
