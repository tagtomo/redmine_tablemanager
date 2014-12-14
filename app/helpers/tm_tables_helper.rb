module TmTablesHelper
  def link_to_add_fields(name, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + "_fields", f: builder)
    end
    link_to(name, '#', class: "addList", data: {id: id, fields: fields.gsub("\n", "")})
  end
  def button_tag_add_fields(name, f, class_name, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + "_fields", f: builder)
    end
    button_tag(name ,type: "button", class: class_name, data: {id: id, fields: fields.gsub("\n", "")})
  end
end
